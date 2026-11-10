; ============================================================================
; avx_game.asm
; Eight entities, one tick. This is a transform-and-cull slice of a game loop.
;
; Optimisations used by engine code:
;   Positions and velocities are structure-of-arrays, eight wide.
;   Fused multiply-add integrates the whole group: x = v * dt + x.
;   A packed compare builds a reject mask. No per-entity branch.
;   and-not applies the mask and clears the velocity of rejected entities.
;   The next group is prefetched while this group is in registers.
;
; From the repo root:
;   nasm -f win64 examples/avx_game.asm -o build/avx_game.o -I .
;   gcc build/avx_game.o -o build/avx_game.exe
; The program exits 0 when positions and velocities match.
; ============================================================================

%include "readable_macros.nasm"
default rel

section .data
align 32
; x: 0, 1, 2, 3, 9, 10, 11, 12
pos_x:      define_double_word 0x00000000, 0x3f800000, 0x40000000, 0x40400000, 0x41100000, 0x41200000, 0x41300000, 0x41400000
vel_x:      define_double_word 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000
dt:         define_double_word 0x3f800000
; Right-hand world bound. An entity is outside when x > 8.
bound_x:    define_double_word 0x41000000
; After the step, x is 1, 2, 3, 4, 10, 11, 12, 13.
expect_x:   define_double_word 0x3f800000, 0x40000000, 0x40400000, 0x40800000, 0x41200000, 0x41300000, 0x41400000, 0x41500000
; Velocity of an outside entity is cleared: 1, 1, 1, 1, 0, 0, 0, 0.
expect_v:   define_double_word 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000, 0x00000000, 0x00000000, 0x00000000, 0x00000000
; Touched by prefetch so the hint has a real second group.
next_group: define_double_word 0, 0, 0, 0, 0, 0, 0, 0

section .bss
align 32
out_x:      reserve_byte 32
out_v:      reserve_byte 32

section .text
%ifidn __OUTPUT_FORMAT__, win64
    global main
main:
    subtract stack_pointer, 40
%else
    global _start
_start:
%endif

    prefetch_t0 [next_group]

    avx_load_aligned            avx_register_1, [vel_x]
    avx_load_aligned            avx_register_2, [pos_x]
    avx_broadcast_scalar_single avx_register_3, [dt]
    ; x = v * dt + x. The sum stays in the position register.
    fma_multiply_add_packed_single avx_register_2, avx_register_1, avx_register_3, avx_register_2

    ; mask = x > bound. Predicate 14 is ordered greater-than.
    avx_broadcast_scalar_single avx_register_3, [bound_x]
    avx_compare_packed_single   avx_register_4, avx_register_2, avx_register_3, 14
    ; v = (not mask) and v. Rejected lanes become zero.
    avx_and_not_packed_single   avx_register_1, avx_register_4, avx_register_1

    avx_load_aligned            [out_x], avx_register_2
    avx_load_aligned            [out_v], avx_register_1

    move    register_r8, out_x
    move    register_r9, expect_x
    call_procedure check_eight
    compare accumulator_64, 0
    jump_if_not_equal fail

    move    register_r8, out_v
    move    register_r9, expect_v
    call_procedure check_eight
    compare accumulator_64, 0
    jump_if_not_equal fail

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
