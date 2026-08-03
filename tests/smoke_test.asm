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
    greeting:   define_byte "Hello, Readable Assembly!", 0
    scratch:    define_qword 0

section .bss
    buffer:     reserve_byte 64

section .text
%ifidn __OUTPUT_FORMAT__, win64
    global main
main:
    ; Windows x64: align stack and reserve shadow space
    sub     stack_pointer, 40
%else
    global _start
_start:
%endif

    ; ------------------------------------------------------------------
    ; TEST 1: factorial(5) == 120  (exercises move, call, compare, jumps,
    ;                                push/pop, multiply, sub, ret)
    ; ------------------------------------------------------------------
    move    accumulator, 5
    call_procedure factorial
    compare accumulator, 120
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 2: arithmetic  (add, subtract, increment, decrement, negate)
    ; ------------------------------------------------------------------
    move    base, 100
    add     base, 22
    subtract base, 2
    increment base
    decrement base
    compare base, 120
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 3: logic  (logical_and, logical_or, logical_xor, logical_not)
    ; ------------------------------------------------------------------
    move    counter, 0x0F0F
    logical_and counter, 0xFF
    compare counter, 0x0F
    jump_if_not_equal fail
    logical_or  counter, 0xF0
    compare counter, 0xFF
    jump_if_not_equal fail
    logical_xor counter, 0xFF
    compare counter, 0
    jump_if_not_equal fail
    logical_not counter
    compare counter, -1
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 4: shifts and rotates
    ; ------------------------------------------------------------------
    move    data, 1
    shift_logical_left data, 4
    compare data, 16
    jump_if_not_equal fail
    shift_logical_right data, 2
    compare data, 4
    jump_if_not_equal fail
    rotate_left data, 4            ; 4 <<< 4 = 64
    compare data, 64
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 5: memory operations + load_effective_address
    ; ------------------------------------------------------------------
    load_effective_address source_index, [greeting]
    move    [scratch], source_index
    compare source_index, [scratch]
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 6: flag control + conditional set
    ; ------------------------------------------------------------------
    clear_carry_flag
    set_carry_flag
    push_flags_qword
    pop_flags_qword
    compare accumulator, 120
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
    move    destination_index, 7
    call_procedure square              ; returns di*di in rax
    compare accumulator, 49
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 9: readable register widths (accumulator_16 = ax, 16-bit)
    ; ------------------------------------------------------------------
    move    accumulator, 0x12345678
    move    accumulator_16, 0xFFFF      ; writes only the low 16 bits
    compare accumulator_32, 0x1234FFFF
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 10: sign-extending converts (cdqe sign-extends eax into rax)
    ; ------------------------------------------------------------------
    move    accumulator_32, 0x7FFFFFFF   ; positive: high bits cleared
    convert_dword_to_qword
    compare accumulator, 0x7FFFFFFF
    jump_if_not_equal fail
    move    accumulator_32, -1           ; negative: high bits set
    convert_dword_to_qword
    compare accumulator, -1
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 11: sized macros on memory (8/16/32/64-bit forms)
    ; ------------------------------------------------------------------
    move    size_dword [scratch], 100
    add_dword [scratch], 20
    compare_dword [scratch], 120
    jump_if_not_equal fail
    logical_and_byte [scratch], 0xFF
    compare_byte [scratch], 120
    jump_if_not_equal fail
    shift_logical_left_byte [scratch], 2   ; 120 << 2 = 480, truncated to 224
    compare_byte [scratch], 224
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; TEST 12: sized sign/zero extension
    ; ------------------------------------------------------------------
    move_byte [scratch], -1              ; 0xFF in the low byte
    move_with_zero_extend_byte accumulator_32, [scratch]
    compare accumulator_32, 255
    jump_if_not_equal fail
    move_with_sign_extend_byte accumulator, [scratch]
    compare accumulator, -1
    jump_if_not_equal fail

    ; ------------------------------------------------------------------
    ; All tests passed - exit 0
    ; ------------------------------------------------------------------
    move    accumulator, 0
    jump    exit_now

fail:
    move    accumulator, 1

exit_now:
%ifidn __OUTPUT_FORMAT__, win64
    add     stack_pointer, 40
    return_from_procedure
%else
    move    destination_index, accumulator   ; exit code
    move    accumulator, 60             ; sys_exit
    syscall_invoke
%endif

; ============================================================================
; factorial(rax) -> rax
; ============================================================================
factorial:
    push_onto_stack base_pointer
    move    base_pointer, stack_pointer
    push_onto_stack base
    push_onto_stack data
    compare accumulator, 1
    jump_if_less_or_equal factorial_base
    ; rax = n * factorial(n - 1)
    move    base, accumulator    ; rbx = n
    subtract accumulator, 1
    call_procedure factorial            ; rsp is 16-byte aligned here
    multiply base                ; rdx:rax = rax * rbx (rbx = n)
    pop_from_stack data
    pop_from_stack base
    move    stack_pointer, base_pointer
    pop_from_stack base_pointer
    return_from_procedure

factorial_base:
    move    accumulator, 1
    pop_from_stack data
    pop_from_stack base
    move    stack_pointer, base_pointer
    pop_from_stack base_pointer
    return_from_procedure

; ============================================================================
; square(rdi) -> rax  (uses movzx, imul-style macros, stack locals)
; ============================================================================
square:
    push_onto_stack base_pointer
    move    base_pointer, stack_pointer
    ; rax = rdi * rdi
    move    accumulator, destination_index
    signed_multiply accumulator         ; imul rax (implicit rax)
    move    stack_pointer, base_pointer
    pop_from_stack base_pointer
    return_from_procedure
