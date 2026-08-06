; ============================================================================
; fibonacci_raw.asm - The ORIGINAL cryptic version (no macros)
; ============================================================================
; Computes the 10th Fibonacci number and prints:
;     Fib(10) = 55
;
; Build & run (Linux, from the repo root):
;     nasm -f elf64 examples/fibonacci_raw.asm -o fibonacci_raw.o
;     ld fibonacci_raw.o -o fibonacci_raw
;     ./fibonacci_raw
; ============================================================================

global _start

section .data
    msg     db "Fib(10) = ", 0
    msg_len equ $ - msg
    newline db 10

section .bss
    buf     resb 16

section .text
_start:
    mov rdi, msg
    call write_str

    ; --- Fibonacci: F(10) = 55 ---
    mov rcx, 10          ; 10 iterations -> rax = F(10)
    xor rax, rax         ; a = F(0) = 0
    mov rbx, 1           ; b = F(1) = 1
fib_loop:
    add rax, rbx         ; a = a + b
    xchg rax, rbx        ; swap: a = old b, b = new sum
    dec rcx
    jnz fib_loop

    ; --- Convert rax (55) to a decimal string ---
    lea rsi, [buf + 15]
    mov byte [rsi], 0
    mov rbx, 10
conv_loop:
    xor rdx, rdx         ; zero the high part for div
    div rbx              ; rdx:rax / 10 -> rax = quotient, rdx = digit
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz conv_loop

    ; --- Print the digits ---
    mov rdx, buf + 16
    sub rdx, rsi         ; length = end - start
    mov rdi, rsi         ; buffer
    call write_str

    ; --- Print newline ---
    mov rdi, newline
    mov rdx, 1
    call write_str

    ; --- Exit ---
    mov rax, 60
    xor rdi, rdi
    syscall

; write_str: prints the null-terminated string pointed to by rdi
write_str:
    push rbp
    mov rbp, rsp
    xor rsi, rsi
.len:
    cmp byte [rdi + rsi], 0
    je .print
    inc rsi
    jmp .len
.print:
    mov rdx, rsi         ; length
    mov rsi, rdi         ; buffer
    mov rdi, 1           ; fd = stdout
    mov rax, 1           ; sys_write
    syscall
    pop rbp
    ret
