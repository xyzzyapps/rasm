; ============================================================================
; fibonacci.asm - The SAME program with Readable Assembly macros
; ============================================================================
; Computes the 10th Fibonacci number and prints:
;     Fib(10) = 55
;
; Build & run (Linux, from the repo root):
;     nasm -f elf64 examples/fibonacci.asm -o fibonacci.o
;     ld fibonacci.o -o fibonacci
;     ./fibonacci
;
; Compare with fibonacci_raw.asm - same instructions, different clarity.
; ============================================================================

%include "readable_macros.nasm"

section .data
    prefix:     define_byte "Fib(10) = ", 0
    equate prefix_len, $ - prefix
    newline:    define_byte 10

section .bss
    buffer:     reserve_byte 16

section .text
    global _start

_start:
    move destination_index, prefix
    call_procedure write_string

    ; --- Fibonacci: F(10) = 55 ---
    move counter, 10        ; 10 iterations -> accumulator = F(10)
    move accumulator, 0     ; a = F(0) = 0
    move base, 1            ; b = F(1) = 1

fibonacci_loop:
    add accumulator, base           ; a = a + b
    exchange accumulator, base      ; swap: a = old b, b = new sum
    decrement counter
    jump_if_not_zero fibonacci_loop

    ; --- Convert accumulator (55) to a decimal string ---
    load_effective_address source_index, [buffer + 15]
    move_byte [source_index], 0
    move base, 10

convert_loop:
    move data, 0            ; zero the high part for divide
    divide base             ; rdx:rax / 10 -> accumulator = quotient, data = digit
    add data_8, "0"         ; digit to character
    decrement source_index
    move [source_index], data_8
    compare accumulator, 0
    jump_if_not_zero convert_loop

    ; --- Print the digits ---
    load_effective_address data, [buffer + 16]
    subtract data, source_index     ; length = end - start
    move destination_index, source_index    ; buffer
    call_procedure write_string

    ; --- Print newline ---
    move destination_index, newline
    move data, 1
    call_procedure write_string

    ; --- Exit ---
    move accumulator, 60
    move destination_index, 0
    syscall_invoke

; ============================================================================
; write_string: prints the null-terminated string pointed to by
; destination_index (rdi). Clobbers accumulator, base, counter, data,
; source_index, destination_index.
; ============================================================================
write_string:
    push_onto_stack base_pointer
    move base_pointer, stack_pointer
    move source_index, 0

.length_loop:
    compare_byte [destination_index + source_index], 0
    jump_if_equal .print_it
    increment source_index
    jump .length_loop

.print_it:
    move data, source_index                     ; length
    move source_index, destination_index        ; buffer
    move destination_index, 1                   ; fd = stdout
    move accumulator, 1                         ; sys_write
    syscall_invoke

    pop_from_stack base_pointer
    return_from_procedure
