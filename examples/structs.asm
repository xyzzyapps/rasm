; ============================================================================
; structs.asm - C-like structs and nested structs demo
; ============================================================================
; Demonstrates the struct macros from macros/48-structs.nasm.
; Lays out a nested struct in memory, writes fields by name, then verifies
; every offset at runtime. Exits with code 0 on success, 1 on failure.
;
; Build & run (Linux, from the repo root):
;     nasm -f elf64 examples/structs.asm -o structs.o
;     ld structs.o -o structs
;     ./structs
;     echo $?        ; expect 0
;
; Build & run (Windows with MinGW, from the repo root):
;     nasm -f win64 examples/structs.asm -o structs.o
;     gcc structs.o -o structs.exe
;     structs.exe
; ============================================================================

%include "readable_macros.nasm"
default rel

; ============================================================================
; STRUCT DEFINITIONS
; ============================================================================
; point { int x; int y; }                    -> point_size = 8
begin_struct point
    struct_dword field_x
    struct_dword field_y
end_struct

; rect {
;   point topleft; point bottomright;        -> offsets 0, 8
;   char  name[32];                          -> offset 16
; }                                          -> rect_size = 48
begin_struct rect
    struct_nested field_topleft,     point
    struct_nested field_bottomright, point
    struct_byte   field_name, 32
end_struct

; entity {
;   rect   hitbox;                           -> offset 0
;   point  velocity;                         -> offset 48
;   qword  sprite_ptr;                       -> offset 56
;   word   flags;                            -> offset 64
; }                                          -> entity_size = 66
begin_struct entity
    struct_nested field_hitbox,  rect
    struct_nested field_velocity, point
    struct_qword  field_sprite_ptr
    struct_word   field_flags
end_struct

; ============================================================================
; DATA
; ============================================================================
section .data
    ; Self-check values: each dd holds the constant the macro computed.
    ; These must match the layout above exactly.
    expected_x:           dd 0
    expected_y:           dd 4
    expected_point_size:  dd 8
    expected_rt:          dd 0
    expected_rb:          dd 8
    expected_rn:          dd 16
    expected_rect_size:   dd 48
    expected_hitbox:      dd 0
    expected_velocity:    dd 48
    expected_sprite:      dd 56
    expected_flags:       dd 64
    expected_entity_size: dd 66
    expected_nested:      dd 8 + 4          ; rect.bottomright + point.y

section .bss
    storage: reserve_byte entity_size       ; "entity e;"

; ============================================================================
; TEXT
; ============================================================================
section .text
%ifidn __OUTPUT_FORMAT__, win64
    global main
main:
    sub stack_pointer, 40
%else
    global _start
_start:
%endif

    ; ---- Verify the computed offset constants ----
    compare_dword [expected_x], point.field_x
    jump_if_not_equal fail
    compare_dword [expected_y], point.field_y
    jump_if_not_equal fail
    compare_dword [expected_point_size], point_size
    jump_if_not_equal fail

    compare_dword [expected_rt], rect.field_topleft
    jump_if_not_equal fail
    compare_dword [expected_rb], rect.field_bottomright
    jump_if_not_equal fail
    compare_dword [expected_rn], rect.field_name
    jump_if_not_equal fail
    compare_dword [expected_rect_size], rect_size
    jump_if_not_equal fail

    compare_dword [expected_hitbox], entity.field_hitbox
    jump_if_not_equal fail
    compare_dword [expected_velocity], entity.field_velocity
    jump_if_not_equal fail
    compare_dword [expected_sprite], entity.field_sprite_ptr
    jump_if_not_equal fail
    compare_dword [expected_flags], entity.field_flags
    jump_if_not_equal fail
    compare_dword [expected_entity_size], entity_size
    jump_if_not_equal fail

    ; Nested access resolves to 8 + 4 = 12
    compare_dword [expected_nested], rect.field_bottomright + point.field_y
    jump_if_not_equal fail

    ; ---- Use the struct: write and read fields by name ----
    load_effective_address base, [storage]

    move_dword [base + entity.field_hitbox + rect.field_topleft + point.field_x], 10
    move_dword [base + entity.field_hitbox + rect.field_bottomright + point.field_y], 20
    move_dword [base + entity.field_velocity + point.field_x], 3
    move_dword [base + entity.field_velocity + point.field_y], -4
    move_qword [base + entity.field_sprite_ptr], 0x12345678
    move_word  [base + entity.field_flags], 0xABCD

    ; Read them back and check
    compare_dword [base + entity.field_hitbox + rect.field_topleft + point.field_x], 10
    jump_if_not_equal fail
    compare_dword [base + entity.field_hitbox + rect.field_bottomright + point.field_y], 20
    jump_if_not_equal fail
    compare_dword [base + entity.field_velocity + point.field_x], 3
    jump_if_not_equal fail
    compare_dword [base + entity.field_velocity + point.field_y], -4
    jump_if_not_equal fail
    compare_qword [base + entity.field_sprite_ptr], 0x12345678
    jump_if_not_equal fail
    compare_word  [base + entity.field_flags], 0xABCD
    jump_if_not_equal fail

    ; ---- Success: exit 0 ----
%ifidn __OUTPUT_FORMAT__, win64
    move accumulator, 0
    add stack_pointer, 40
    return_from_procedure
%else
    move accumulator, 60
    move destination_index, 0
    syscall_invoke
%endif

fail:
%ifidn __OUTPUT_FORMAT__, win64
    move accumulator, 1
    add stack_pointer, 40
    return_from_procedure
%else
    move accumulator, 60
    move destination_index, 1
    syscall_invoke
%endif
