; ============================================================================
; Readable Assembly - Example Usage
; ============================================================================
; This file demonstrates how to use the readable assembly macros.
; Assemble with: nasm -f elf64 example.asm -o example.o
; ============================================================================

%include "readable_macros.nasm"

section .data
    greeting:   define_byte  "Hello, Readable Assembly!", 10, 0
    number:     define_qword 42
    result:     define_qword 0
    array:      define_qword 1, 2, 3, 4, 5
    equate array_len, 5

section .bss
    buffer:     reserve_byte 256

section .text
    global _start

_start:
    ; --- Data Movement Examples ---
    move    accumulator, 10              ; mov rax, 10
    move    base, accumulator     ; mov rbx, rax
    move    counter, [number]        ; mov rcx, [number]

    ; --- Arithmetic Examples ---
    add     accumulator, 5               ; add rax, 5
    subtract base, 3              ; sub rbx, 3
    increment counter                ; inc rcx
    decrement data                ; dec rdx
    multiply register_r8                 ; mul r8
    compare accumulator, base     ; cmp rax, rbx

    ; --- Sized Arithmetic (explicit 8/16/32/64-bit forms) ---
    add_dword     [number], 8            ; add dword [number], 8
    compare_dword [number], 50           ; cmp dword [number], 50
    increment_word [number]              ; inc word [number]
    decrement_byte [array]               ; dec byte [array]

    ; --- Logic Examples ---
    logical_and accumulator, 0xFF        ; and rax, 0xFF
    logical_or  base, 0x0F        ; or rbx, 0x0F
    logical_xor counter, data ; xor rcx, rdx
    logical_not accumulator              ; not rax

    ; --- Shift Examples ---
    shift_logical_left  accumulator, 2   ; shl rax, 2
    shift_logical_right base, 1   ; shr rbx, 1
    shift_arithmetic_right counter, 3 ; sar rcx, 3
    rotate_left  data, 4          ; rol rdx, 4
    rotate_right register_r8, 2          ; ror r8, 2

    ; --- Control Flow Examples ---
    compare accumulator, 10
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
    push_onto_stack accumulator          ; push rax
    push_onto_stack base          ; push rbx
    pop_from_stack  counter          ; pop rcx
    pop_from_stack  data          ; pop rdx

    ; --- Flag Operations ---
    clear_carry_flag                     ; clc
    set_carry_flag                       ; stc
    clear_direction_flag                 ; cld
    set_interrupt_flag                   ; sti
    clear_interrupt_flag                 ; cli

    ; --- Bit Manipulation ---
    bit_scan_forward accumulator, base  ; bsf rax, rbx
    bit_scan_reverse counter, data  ; bsr rcx, rdx
    byte_swap      register_r8                  ; bswap r8

    ; --- Load Effective Address ---
    load_effective_address accumulator, [greeting]  ; lea rax, [greeting]

    ; --- Conditional Move ---
    compare accumulator, base
    move_if_equal counter, data  ; cmove rcx, rdx

    ; --- Compare and Exchange ---
    compare_and_exchange accumulator, base  ; cmpxchg rax, rbx

    ; --- System ---
    no_operation                               ; nop
    pause                                      ; pause

    ; --- Procedure Call ---
    call_procedure my_function                 ; call my_function

    ; --- Exit (Linux syscall) ---
    move    accumulator, 60              ; mov rax, 60 (sys_exit)
    move    destination_index, 0               ; mov rdi, 0 (exit code)
    syscall_invoke                       ; syscall

; ============================================================================
; Function Example
; ============================================================================
my_function:
    ; Prologue
    push_onto_stack base_pointer          ; push rbp
    move    base_pointer, stack_pointer     ; mov rbp, rsp

    ; Body: add two values
    move    accumulator, [base_pointer + 16]  ; mov rax, [rbp+16]
    add     accumulator, [base_pointer + 24]  ; add rax, [rbp+24]

    ; Epilogue
    move    stack_pointer, base_pointer     ; mov rsp, rbp
    pop_from_stack  base_pointer          ; pop rbp
    return_from_procedure                ; ret

; ============================================================================
; Loop Example
; ============================================================================
loop_example:
    move    counter, 10              ; mov rcx, 10
.loop:
    ; do something
    decrement counter                ; dec rcx
    loop_if_not_zero .loop               ; loopnz .loop
    return_from_procedure                ; ret

; ============================================================================
; String Operations Example
; ============================================================================
string_copy:
    load_effective_address source_index, [greeting]  ; lea rsi, [greeting]
    load_effective_address destination_index, [buffer]    ; lea rdi, [buffer]
    move    counter, 25              ; mov rcx, 25
    clear_direction_flag                          ; cld
    repeat movsb                                ; rep movsb
    return_from_procedure                         ; ret
