; ============================================================================
; Readable Assembly - Example Usage
; ============================================================================
; This file demonstrates how to use the readable assembly macros.
; Assemble with: nasm -f elf64 example.asm -o example.o
; ============================================================================

%include "readable-assembly.inc"

section .data
    greeting    db  "Hello, Readable Assembly!", 10, 0
    number      dq  42
    result      dq  0
    array       dq  1, 2, 3, 4, 5
    array-len   equ 5

section .bss
    buffer      resb 256

section .text
    global _start

_start:
    ; --- Data Movement Examples ---
    move    register-ax, 10              ; mov rax, 10
    move    register-bx, register-ax     ; mov rbx, rax
    move    register-cx, [number]        ; mov rcx, [number]

    ; --- Arithmetic Examples ---
    add     register-ax, 5               ; add rax, 5
    subtract register-bx, 3              ; sub rbx, 3
    increment register-cx                ; inc rcx
    decrement register-dx                ; dec rdx
    multiply register-r8                 ; mul r8
    compare register-ax, register-bx     ; cmp rax, rbx

    ; --- Logic Examples ---
    logical-and register-ax, 0xFF        ; and rax, 0xFF
    logical-or  register-bx, 0x0F        ; or rbx, 0x0F
    logical-xor register-cx, register-dx ; xor rcx, rdx
    logical-not register-ax              ; not rax

    ; --- Shift Examples ---
    shift-logical-left  register-ax, 2   ; shl rax, 2
    shift-logical-right register-bx, 1   ; shr rbx, 1
    shift-arithmetic-right register-cx, 3 ; sar rcx, 3
    rotate-left  register-dx, 4          ; rol rdx, 4
    rotate-right register-r8, 2          ; ror r8, 2

    ; --- Control Flow Examples ---
    compare register-ax, 10
    jump-if-equal     is_ten
    jump-if-greater   greater_than_ten
    jump              done

is_ten:
    move register-r9, 1
    jump done

greater_than_ten:
    move register-r9, 2

done:
    ; --- Stack Operations ---
    push-onto-stack register-ax          ; push rax
    push-onto-stack register-bx          ; push rbx
    pop-from-stack  register-cx          ; pop rcx
    pop-from-stack  register-dx          ; pop rdx

    ; --- Flag Operations ---
    clear-carry-flag                     ; clc
    set-carry-flag                       ; stc
    clear-direction-flag                 ; cld
    set-interrupt-flag                   ; sti
    clear-interrupt-flag                 ; cli

    ; --- Bit Manipulation ---
    bit-scan-forward register-ax, register-bx  ; bsf rax, rbx
    bit-scan-reverse register-cx, register-dx  ; bsr rcx, rdx
    byte-swap      register-r8                  ; bswap r8

    ; --- Load Effective Address ---
    load-effective-address register-ax, [greeting]  ; lea rax, [greeting]

    ; --- Conditional Move ---
    compare register-ax, register-bx
    move-if-equal register-cx, register-dx  ; cmove rcx, rdx

    ; --- Compare and Exchange ---
    compare-and-exchange register-ax, register-bx  ; cmpxchg rax, rbx

    ; --- System ---
    no-operation                               ; nop
    pause                                      ; pause

    ; --- Procedure Call ---
    call-procedure my_function                 ; call my_function

    ; --- Exit (Linux syscall) ---
    move    register-ax, 60              ; mov rax, 60 (sys_exit)
    move    register-di, 0               ; mov rdi, 0 (exit code)
    syscall-invoke                       ; syscall

; ============================================================================
; Function Example
; ============================================================================
my_function:
    ; Prologue
    push-onto-stack register-bp          ; push rbp
    move    register-bp, register-sp     ; mov rbp, rsp

    ; Body: add two values
    move    register-ax, [register-bp + 16]  ; mov rax, [rbp+16]
    add     register-ax, [register-bp + 24]  ; add rax, [rbp+24]

    ; Epilogue
    move    register-sp, register-bp     ; mov rsp, rbp
    pop-from-stack  register-bp          ; pop rbp
    return-from-procedure                ; ret

; ============================================================================
; Loop Example
; ============================================================================
loop_example:
    move    register-cx, 10              ; mov rcx, 10
.loop:
    ; do something
    decrement register-cx                ; dec rcx
    loop-if-not-zero .loop               ; loopnz .loop
    return-from-procedure                ; ret

; ============================================================================
; String Operations Example
; ============================================================================
string_copy:
    load-effective-address register-si, [greeting]  ; lea rsi, [greeting]
    load-effective-address register-di, [buffer]    ; lea rdi, [buffer]
    move    register-cx, 25              ; mov rcx, 25
    clear-direction-flag                          ; cld
    repeat                                        ; rep
    move-string-byte                              ; movsb
    return-from-procedure                         ; ret
