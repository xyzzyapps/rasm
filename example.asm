; ============================================================================
; Readable Assembly - Example Usage
; ============================================================================
; This file demonstrates how to use the readable assembly macros.
; Assemble with: nasm -f elf64 example.asm -o example.o
; ============================================================================

%include "readable_macros.nasm"

section .data
    greeting    db  "Hello, Readable Assembly!", 10, 0
    number      dq  42
    result      dq  0
    array       dq  1, 2, 3, 4, 5
    array_len   equ 5

section .bss
    buffer      resb 256

section .text
    global _start

_start:
    ; --- Data Movement Examples ---
    move    register_ax, 10              ; mov rax, 10
    move    register_bx, register_ax     ; mov rbx, rax
    move    register_cx, [number]        ; mov rcx, [number]

    ; --- Arithmetic Examples ---
    add     register_ax, 5               ; add rax, 5
    subtract register_bx, 3              ; sub rbx, 3
    increment register_cx                ; inc rcx
    decrement register_dx                ; dec rdx
    multiply register_r8                 ; mul r8
    compare register_ax, register_bx     ; cmp rax, rbx

    ; --- Logic Examples ---
    logical_and register_ax, 0xFF        ; and rax, 0xFF
    logical_or  register_bx, 0x0F        ; or rbx, 0x0F
    logical_xor register_cx, register_dx ; xor rcx, rdx
    logical_not register_ax              ; not rax

    ; --- Shift Examples ---
    shift_logical_left  register_ax, 2   ; shl rax, 2
    shift_logical_right register_bx, 1   ; shr rbx, 1
    shift_arithmetic_right register_cx, 3 ; sar rcx, 3
    rotate_left  register_dx, 4          ; rol rdx, 4
    rotate_right register_r8, 2          ; ror r8, 2

    ; --- Control Flow Examples ---
    compare register_ax, 10
    jump_if_equal     is_ten
    jump_if_greater   greater_than_ten
    jump              done

is_ten:
    move register_r9, 1
    jump done

greater_than_ten:
    move register_r9, 2

done:
    ; --- Stack Operations ---
    push_onto_stack register_ax          ; push rax
    push_onto_stack register_bx          ; push rbx
    pop_from_stack  register_cx          ; pop rcx
    pop_from_stack  register_dx          ; pop rdx

    ; --- Flag Operations ---
    clear_carry_flag                     ; clc
    set_carry_flag                       ; stc
    clear_direction_flag                 ; cld
    set_interrupt_flag                   ; sti
    clear_interrupt_flag                 ; cli

    ; --- Bit Manipulation ---
    bit_scan_forward register_ax, register_bx  ; bsf rax, rbx
    bit_scan_reverse register_cx, register_dx  ; bsr rcx, rdx
    byte_swap      register_r8                  ; bswap r8

    ; --- Load Effective Address ---
    load_effective_address register_ax, [greeting]  ; lea rax, [greeting]

    ; --- Conditional Move ---
    compare register_ax, register_bx
    move_if_equal register_cx, register_dx  ; cmove rcx, rdx

    ; --- Compare and Exchange ---
    compare_and_exchange register_ax, register_bx  ; cmpxchg rax, rbx

    ; --- System ---
    no_operation                               ; nop
    pause                                      ; pause

    ; --- Procedure Call ---
    call_procedure my_function                 ; call my_function

    ; --- Exit (Linux syscall) ---
    move    register_ax, 60              ; mov rax, 60 (sys_exit)
    move    register_di, 0               ; mov rdi, 0 (exit code)
    syscall_invoke                       ; syscall

; ============================================================================
; Function Example
; ============================================================================
my_function:
    ; Prologue
    push_onto_stack register_bp          ; push rbp
    move    register_bp, register_sp     ; mov rbp, rsp

    ; Body: add two values
    move    register_ax, [register_bp + 16]  ; mov rax, [rbp+16]
    add     register_ax, [register_bp + 24]  ; add rax, [rbp+24]

    ; Epilogue
    move    register_sp, register_bp     ; mov rsp, rbp
    pop_from_stack  register_bp          ; pop rbp
    return_from_procedure                ; ret

; ============================================================================
; Loop Example
; ============================================================================
loop_example:
    move    register_cx, 10              ; mov rcx, 10
.loop:
    ; do something
    decrement register_cx                ; dec rcx
    loop_if_not_zero .loop               ; loopnz .loop
    return_from_procedure                ; ret

; ============================================================================
; String Operations Example
; ============================================================================
string_copy:
    load_effective_address register_si, [greeting]  ; lea rsi, [greeting]
    load_effective_address register_di, [buffer]    ; lea rdi, [buffer]
    move    register_cx, 25              ; mov rcx, 25
    clear_direction_flag                          ; cld
    repeat movsb                                ; rep movsb
    return_from_procedure                         ; ret
