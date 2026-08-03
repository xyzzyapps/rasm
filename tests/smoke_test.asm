; ============================================================================
; smoke_test.asm - Runtime smoke test for Readable Assembly macros
; ============================================================================
; Exercises a representative sample of the macro library and verifies results
; at runtime. Exits with code 0 on success, 1 on any failure.
;
;   Linux:   nasm -f elf64 smoke_test.asm -o smoke_test.o
;            ld smoke_test.o -o smoke_test
;   Windows: nasm -f win64 smoke_test.asm -o smoke_test.o
;            gcc smoke_test.o -o smoke_test.exe
; ============================================================================

%include "readable_macros.nasm"
default rel

section .data
    greeting    db  "Hello, Readable Assembly!", 0
    scratch     dq  0

section .bss
    buffer      resb 64

section .text
%ifidn __OUTPUT_FORMAT__, win64
    global main
main:
    ; Windows x64: align stack and reserve shadow space
    sub     register_rsp, 40
%else
    global _start
_start:
%endif

    ; ------------------------------------------------------------------
    ; TEST 1: factorial(5) == 120  (exercises move, call, compare, jumps,
    ;                                push/pop, multiply, sub, ret)
    ; ------------------------------------------------------------------
    move    register_ax, 5
    call_procedure factorial
    compare register_ax, 120
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 2: arithmetic  (add, subtract, increment, decrement, negate)
    ; ------------------------------------------------------------------
    move    register_bx, 100
    add     register_bx, 22
    subtract register_bx, 2
    increment register_bx
    decrement register_bx
    compare register_bx, 120
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 3: logic  (logical_and, logical_or, logical_xor, logical_not)
    ; ------------------------------------------------------------------
    move    register_cx, 0x0F0F
    logical_and register_cx, 0xFF
    compare register_cx, 0x0F
    jump_if_not_equal fail
    logical_or  register_cx, 0xF0
    compare register_cx, 0xFF
    jump_if_not_equal fail
    logical_xor register_cx, 0xFF
    compare register_cx, 0
    jump_if_not_equal fail
    logical_not register_cx
    compare register_cx, -1
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 4: shifts and rotates
    ; ------------------------------------------------------------------
    move    register_dx, 1
    shift_logical_left register_dx, 4
    compare register_dx, 16
    jump_if_not_equal fail
    shift_logical_right register_dx, 2
    compare register_dx, 4
    jump_if_not_equal fail
    rotate_left register_dx, 4            ; 4 <<< 4 = 64
    compare register_dx, 64
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 5: memory operations + load_effective_address
    ; ------------------------------------------------------------------
    load_effective_address register_si, [greeting]
    move    [scratch], register_si
    compare register_si, [scratch]
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 6: flag control + conditional set
    ; ------------------------------------------------------------------
    clear_carry_flag
    set_carry_flag
    push_flags_qword
    pop_flags_qword
    compare register_ax, 120
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 7: stack + exchange
    ; ------------------------------------------------------------------
    move    register_r8, 0x1111
    move    register_r9, 0x2222
    exchange register_r8, register_r9
    compare register_r8, 0x2222
    jump_if_not_equal fail
    compare register_r9, 0x1111
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 8: procedures with stack frames
    ; ------------------------------------------------------------------
    move    register_di, 7
    call_procedure square              ; returns di*di in rax
    compare register_ax, 49
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; All tests passed - exit 0
    ; ------------------------------------------------------------------
    move    register_ax, 0
    jump    exit_now

fail:
    move    register_ax, 1

exit_now:
%ifidn __OUTPUT_FORMAT__, win64
    add     register_rsp, 40
    return_from_procedure
%else
    move    register_rdi, register_ax   ; exit code
    move    register_ax, 60             ; sys_exit
    syscall_invoke
%endif

; ============================================================================
; factorial(rax) -> rax
; ============================================================================
factorial:
    push_onto_stack register_bp
    move    register_bp, register_rsp
    push_onto_stack register_bx
    push_onto_stack register_dx
    compare register_ax, 1
    jump_if_less_or_equal factorial_base
    ; rax = n * factorial(n - 1)
    move    register_bx, register_ax    ; rbx = n
    subtract register_ax, 1
    call_procedure factorial            ; rsp is 16-byte aligned here
    multiply register_bx                ; rdx:rax = rax * rbx (rbx = n)
    pop_from_stack register_dx
    pop_from_stack register_bx
    move    register_rsp, register_bp
    pop_from_stack register_bp
    return_from_procedure

factorial_base:
    move    register_ax, 1
    pop_from_stack register_dx
    pop_from_stack register_bx
    move    register_rsp, register_bp
    pop_from_stack register_bp
    return_from_procedure

; ============================================================================
; square(rdi) -> rax  (uses movzx, imul-style macros, stack locals)
; ============================================================================
square:
    push_onto_stack register_bp
    move    register_bp, register_rsp
    ; rax = rdi * rdi
    move    register_ax, register_di
    signed_multiply register_ax         ; imul rax (implicit rax)
    move    register_rsp, register_bp
    pop_from_stack register_bp
    return_from_procedure
