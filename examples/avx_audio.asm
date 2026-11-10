; ============================================================================
; avx_audio.asm
; Eight-sample audio bus. This is the inner loop of a mixer callback.
;
; Optimisations used by audio code:
;   One AVX register holds eight mono samples.
;   The send gain is broadcast, not reloaded per sample.
;   A fused multiply-add mixes dry and wet: out = dry * gain + wet * gain.
;   Packed minimum and maximum clamp the block without a branch.
;   The next block is prefetched before the arithmetic.
;
; From the repo root:
;   nasm -f win64 examples/avx_audio.asm -o build/avx_audio.o -I .
;   gcc build/avx_audio.o -o build/avx_audio.exe
; The program exits 0 when every sample matches.
; ============================================================================

%include "readable_macros.nasm"
default rel

section .data
align 32
; dry and wet are the same block, so dry*0.5 + wet*0.5 equals the block.
; Samples: 2, 0, 1, -2, 0.5, 0, 1, -1
dry:        define_double_word 0x40000000, 0x00000000, 0x3f800000, 0xc0000000, 0x3f000000, 0x00000000, 0x3f800000, 0xbf800000
wet:        define_double_word 0x40000000, 0x00000000, 0x3f800000, 0xc0000000, 0x3f000000, 0x00000000, 0x3f800000, 0xbf800000
gain:       define_double_word 0x3f000000
neg_one:    define_double_word 0xbf800000
pos_one:    define_double_word 0x3f800000
; Clamp of the mix: 1, 0, 1, -1, 0.5, 0, 1, -1
expect_out: define_double_word 0x3f800000, 0x00000000, 0x3f800000, 0xbf800000, 0x3f000000, 0x00000000, 0x3f800000, 0xbf800000

section .bss
align 32
out_samples: reserve_byte 32

section .text
%ifidn __OUTPUT_FORMAT__, win64
    global main
main:
    subtract stack_pointer, 40
%else
    global _start
_start:
%endif

    ; Hide the load of the next callback block under the arithmetic.
    prefetch_t0 [expect_out]

    avx_load_aligned            avx_register_0, [dry]
    avx_load_aligned            avx_register_1, [wet]
    avx_broadcast_scalar_single avx_register_2, [gain]
    ; wet = wet * gain, then out = dry * gain + wet
    avx_multiply_packed_single  avx_register_1, avx_register_1, avx_register_2
    fma_multiply_add_packed_single avx_register_0, avx_register_0, avx_register_2, avx_register_1

    avx_broadcast_scalar_single avx_register_3, [neg_one]
    avx_broadcast_scalar_single avx_register_4, [pos_one]
    avx_maximum_packed_single   avx_register_0, avx_register_0, avx_register_3
    avx_minimum_packed_single   avx_register_0, avx_register_0, avx_register_4
    avx_load_aligned            [out_samples], avx_register_0

    move    register_r8, out_samples
    move    register_r9, expect_out
    move    counter_64, 8
.check:
    move    accumulator_32, [register_r8]
    compare accumulator_32, [register_r9]
    jump_if_not_equal fail
    add     register_r8, 4
    add     register_r9, 4
    decrement counter_64
    jump_if_not_zero .check

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
