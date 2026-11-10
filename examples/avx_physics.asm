; ============================================================================
; avx_physics.asm
; Eight-wide rigid-particle step, the inner loop of a software physics world.
;
; Optimisations used by physics code:
;   Structure of arrays. Eight x values share one AVX register.
;   Broadcast the time step once, then reuse it.
;   Fused multiply-add: position = velocity * dt + position.
;   A second fused chain builds the squared length x*x + y*y + z*z.
;   vzeroupper before the function returns to C.
;
; From the repo root:
;   nasm -f win64 examples/avx_physics.asm -o build/avx_physics.o -I .
;   gcc build/avx_physics.o -o build/avx_physics.exe
;   nasm -f elf64 examples/avx_physics.asm -o build/avx_physics.o -I .
;   ld build/avx_physics.o -o build/avx_physics
; The program exits 0 when every lane matches.
; ============================================================================

%include "readable_macros.nasm"
default rel

section .data
align 32
; Eight particles. Values are exact in binary32.
pos_x:      define_double_word 0x3f800000, 0x40000000, 0x40400000, 0x40800000, 0x40a00000, 0x40c00000, 0x40e00000, 0x41000000
pos_y:      define_double_word 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000
vel_x:      define_double_word 0x40000000, 0x00000000, 0x3f800000, 0x40800000, 0x00000000, 0x40000000, 0x3f800000, 0x00000000
dt:         define_double_word 0x3f000000
align 32
; Expected x after one step: 2, 2, 3.5, 6, 5, 7, 7.5, 8
expect_x:   define_double_word 0x40000000, 0x40000000, 0x40600000, 0x40c00000, 0x40a00000, 0x40e00000, 0x40f00000, 0x41000000

align 32
; Eight direction vectors. Squared length is exact.
dir_x:      define_double_word 0x40400000, 0x3f800000, 0x00000000, 0x40000000, 0x40a00000, 0x00000000, 0x40c00000, 0x41000000
align 32
dir_y:      define_double_word 0x40800000, 0x40000000, 0x00000000, 0x00000000, 0x00000000, 0x40400000, 0x41000000, 0x00000000
align 32
dir_z:      define_double_word 0x00000000, 0x40000000, 0x40a00000, 0x00000000, 0x00000000, 0x40800000, 0x00000000, 0x00000000
align 32
; 25, 9, 25, 4, 25, 25, 100, 64
expect_dot: define_double_word 0x41c80000, 0x41100000, 0x41c80000, 0x40800000, 0x41c80000, 0x41c80000, 0x42c80000, 0x42800000

section .bss
align 32
out_x:      reserve_byte 32
out_dot:    reserve_byte 32

section .text
%ifidn __OUTPUT_FORMAT__, win64
    global main
main:
    subtract stack_pointer, 40
%else
    global _start
_start:
%endif

    ; Step eight particles. ymm1 = velocity, ymm2 = position, ymm3 = dt.
    avx_load_aligned            avx_register_1, [vel_x]
    avx_load_aligned            avx_register_2, [pos_x]
    avx_broadcast_scalar_single avx_register_3, [dt]
    ; position = velocity * dt + position. The sum stays in the position register.
    fma_multiply_add_packed_single avx_register_2, avx_register_1, avx_register_3, avx_register_2
    avx_load_aligned            [out_x], avx_register_2

    move    register_r8, out_x
    move    register_r9, expect_x
    call_procedure check_eight
    compare accumulator_64, 0
    jump_if_not_equal fail

    ; Squared length of eight vectors: x*x + y*y + z*z.
    avx_xor_packed_single       avx_register_0, avx_register_0, avx_register_0
    avx_load_aligned            avx_register_1, [dir_x]
    fma_multiply_add_packed_single avx_register_0, avx_register_1, avx_register_1, avx_register_0
    avx_load_aligned            avx_register_1, [dir_y]
    fma_multiply_add_packed_single avx_register_0, avx_register_1, avx_register_1, avx_register_0
    avx_load_aligned            avx_register_1, [dir_z]
    fma_multiply_add_packed_single avx_register_0, avx_register_1, avx_register_1, avx_register_0
    avx_load_aligned            [out_dot], avx_register_0

    move    register_r8, out_dot
    move    register_r9, expect_dot
    call_procedure check_eight
    compare accumulator_64, 0
    jump_if_not_equal fail

    ; A normaliser would multiply by the reciprocal square root of out_dot.
    ; That estimate is not bit-exact across CPUs, so this demo stops at the dot.
    avx_reciprocal_square_root_packed_single avx_register_2, avx_register_0
    avx_zero_upper
    move    accumulator_64, 0
    jump    exit_now

fail:
    avx_zero_upper
    move    accumulator_64, 1

exit_now:
%ifidn __OUTPUT_FORMAT__, win64
    add     stack_pointer, 40
    return_from_procedure
%else
    move    destination_index, accumulator
    move    accumulator_64, 60
    syscall_invoke
%endif

; check_eight: r8 = actual, r9 = expected. Returns 0 in rax, or 1.
; Uses only caller-saved registers.
check_eight:
    move    counter_64, 8
.next:
    move    accumulator_32, [register_r8]
    compare accumulator_32, [register_r9]
    jump_if_not_equal .bad
    add     register_r8, 4
    add     register_r9, 4
    decrement counter_64
    jump_if_not_zero .next
    move    accumulator_64, 0
    return_from_procedure
.bad:
    move    accumulator_64, 1
    return_from_procedure
