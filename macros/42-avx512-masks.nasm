; ============================================================================
; SECTION 42: AVX-512 MASK REGISTER OPERATIONS
; ============================================================================

%macro avx512_mask_add_byte 3
    kaddb %1, %2, %3
%endmacro

%macro avx512_mask_add_word 3
    kaddw %1, %2, %3
%endmacro

%macro avx512_mask_add_dword 3
    kaddd %1, %2, %3
%endmacro

%macro avx512_mask_add_qword 3
    kaddq %1, %2, %3
%endmacro

%macro avx512_mask_and_byte 3
    kandb %1, %2, %3
%endmacro

%macro avx512_mask_and_word 3
    kandw %1, %2, %3
%endmacro

%macro avx512_mask_and_dword 3
    kandd %1, %2, %3
%endmacro

%macro avx512_mask_and_qword 3
    kandq %1, %2, %3
%endmacro

%macro avx512_mask_and_not_byte 3
    kandnb %1, %2, %3
%endmacro

%macro avx512_mask_and_not_word 3
    kandnw %1, %2, %3
%endmacro

%macro avx512_mask_and_not_dword 3
    kandnd %1, %2, %3
%endmacro

%macro avx512_mask_and_not_qword 3
    kandnq %1, %2, %3
%endmacro

%macro avx512_mask_move_byte 2
    kmovb %1, %2
%endmacro

%macro avx512_mask_move_word 2
    kmovw %1, %2
%endmacro

%macro avx512_mask_move_dword 2
    kmovd %1, %2
%endmacro

%macro avx512_mask_move_qword 2
    kmovq %1, %2
%endmacro

%macro avx512_mask_not_byte 2
    knotb %1, %2
%endmacro

%macro avx512_mask_not_word 2
    knotw %1, %2
%endmacro

%macro avx512_mask_not_dword 2
    knotd %1, %2
%endmacro

%macro avx512_mask_not_qword 2
    knotq %1, %2
%endmacro

%macro avx512_mask_or_byte 3
    korb %1, %2, %3
%endmacro

%macro avx512_mask_or_word 3
    korw %1, %2, %3
%endmacro

%macro avx512_mask_or_dword 3
    kord %1, %2, %3
%endmacro

%macro avx512_mask_or_qword 3
    korq %1, %2, %3
%endmacro

%macro avx512_mask_or_test_byte 2
    kortestb %1, %2
%endmacro

%macro avx512_mask_or_test_word 2
    kortestw %1, %2
%endmacro

%macro avx512_mask_or_test_dword 2
    kortestd %1, %2
%endmacro

%macro avx512_mask_or_test_qword 2
    kortestq %1, %2
%endmacro

%macro avx512_mask_shift_left_byte 3
    kshiftlb %1, %2, %3
%endmacro

%macro avx512_mask_shift_left_word 3
    kshiftlw %1, %2, %3
%endmacro

%macro avx512_mask_shift_left_dword 3
    kshiftld %1, %2, %3
%endmacro

%macro avx512_mask_shift_left_qword 3
    kshiftlq %1, %2, %3
%endmacro

%macro avx512_mask_shift_right_byte 3
    kshiftrb %1, %2, %3
%endmacro

%macro avx512_mask_shift_right_word 3
    kshiftrw %1, %2, %3
%endmacro

%macro avx512_mask_shift_right_dword 3
    kshiftrd %1, %2, %3
%endmacro

%macro avx512_mask_shift_right_qword 3
    kshiftrq %1, %2, %3
%endmacro

%macro avx512_mask_test_byte 2
    ktestb %1, %2
%endmacro

%macro avx512_mask_test_word 2
    ktestw %1, %2
%endmacro

%macro avx512_mask_test_dword 2
    ktestd %1, %2
%endmacro

%macro avx512_mask_test_qword 2
    ktestq %1, %2
%endmacro

%macro avx512_mask_unpack_byte_word 3
    kunpckbw %1, %2, %3
%endmacro

%macro avx512_mask_unpack_word_dword 3
    kunpckwd %1, %2, %3
%endmacro

%macro avx512_mask_unpack_dword_qword 3
    kunpckdq %1, %2, %3
%endmacro

%macro avx512_mask_xnor_byte 3
    kxnorb %1, %2, %3
%endmacro

%macro avx512_mask_xnor_word 3
    kxnorw %1, %2, %3
%endmacro

%macro avx512_mask_xnor_dword 3
    kxnord %1, %2, %3
%endmacro

%macro avx512_mask_xnor_qword 3
    kxnorq %1, %2, %3
%endmacro

%macro avx512_mask_xor_byte 3
    kxorb %1, %2, %3
%endmacro

%macro avx512_mask_xor_word 3
    kxorw %1, %2, %3
%endmacro

%macro avx512_mask_xor_dword 3
    kxord %1, %2, %3
%endmacro

%macro avx512_mask_xor_qword 3
    kxorq %1, %2, %3
%endmacro

; --- AVX-512 Data Movement ---
%macro avx512_move_aligned_dword 2
    vmovdqa32 %1, %2
%endmacro

%macro avx512_move_aligned_qword 2
    vmovdqa64 %1, %2
%endmacro

%macro avx512_move_unaligned_byte 2
    vmovdqu8 %1, %2
%endmacro

%macro avx512_move_unaligned_word 2
    vmovdqu16 %1, %2
%endmacro

%macro avx512_move_unaligned_dword 2
    vmovdqu32 %1, %2
%endmacro

%macro avx512_move_unaligned_qword 2
    vmovdqu64 %1, %2
%endmacro

; --- AVX-512 Compress/Expand ---
%macro avx512_compress_packed_single 2
    vcompressps %1, %2
%endmacro

%macro avx512_compress_packed_double 2
    vcompresspd %1, %2
%endmacro

%macro avx512_expand_packed_single 2
    vexpandps %1, %2
%endmacro

%macro avx512_expand_packed_double 2
    vexpandpd %1, %2
%endmacro

; --- AVX-512 Ternary Logic ---
%macro avx512_ternary_logic_dword 4
    vpternlogd %1, %2, %3, %4
%endmacro

%macro avx512_ternary_logic_qword 4
    vpternlogq %1, %2, %3, %4
%endmacro

; --- AVX-512 FP Classify ---
%macro avx512_fp_classify_single 3
    vfpclassps %1, %2, %3
%endmacro

%macro avx512_fp_classify_double 3
    vfpclasspd %1, %2, %3
%endmacro

%macro avx512_fp_classify_scalar_single 3
    vfpclassss %1, %2, %3
%endmacro

%macro avx512_fp_classify_scalar_double 3
    vfpclasssd %1, %2, %3
%endmacro

; --- AVX-512 Reduce ---
%macro avx512_reduce_packed_single 3
    vreduceps %1, %2, %3
%endmacro

%macro avx512_reduce_packed_double 3
    vreducepd %1, %2, %3
%endmacro

%macro avx512_reduce_scalar_single 3
    vreducess %1, %2, %3
%endmacro

%macro avx512_reduce_scalar_double 3
    vreducesd %1, %2, %3
%endmacro

; --- AVX-512 Round Scale ---
%macro avx512_round_scale_packed_single 3
    vrndscaleps %1, %2, %3
%endmacro

%macro avx512_round_scale_packed_double 3
    vrndscalepd %1, %2, %3
%endmacro

%macro avx512_round_scale_scalar_single 3
    vrndscaless %1, %2, %3
%endmacro

%macro avx512_round_scale_scalar_double 3
    vrndscalesd %1, %2, %3
%endmacro

; --- AVX-512 Scale ---
%macro avx512_scale_packed_single 3
    vscalefps %1, %2, %3
%endmacro

%macro avx512_scale_packed_double 3
    vscalefpd %1, %2, %3
%endmacro

%macro avx512_scale_scalar_single 3
    vscalefss %1, %2, %3
%endmacro

%macro avx512_scale_scalar_double 3
    vscalefsd %1, %2, %3
%endmacro

; --- AVX-512 Scatter/Gather ---
%macro avx512_scatter_dword_single 5
    vscatterdps %1, %2, %3, %4, %5
%endmacro

%macro avx512_scatter_qword_single 5
    vscatterqps %1, %2, %3, %4, %5
%endmacro

%macro avx512_scatter_dword_double 5
    vscatterdpd %1, %2, %3, %4, %5
%endmacro

%macro avx512_scatter_qword_double 5
    vscatterqpd %1, %2, %3, %4, %5
%endmacro

; --- AVX-512 Integer Operations ---
%macro avx512_abs_packed_byte 2
    vpabsb %1, %2
%endmacro

%macro avx512_abs_packed_word 2
    vpabsw %1, %2
%endmacro

%macro avx512_abs_packed_dword 2
    vpabsd %1, %2
%endmacro

%macro avx512_abs_packed_qword 2
    vpabsq %1, %2
%endmacro

%macro avx512_add_packed_byte 3
    vpaddb %1, %2, %3
%endmacro

%macro avx512_add_packed_word 3
    vpaddw %1, %2, %3
%endmacro

%macro avx512_add_packed_dword 3
    vpaddd %1, %2, %3
%endmacro

%macro avx512_add_packed_qword 3
    vpaddq %1, %2, %3
%endmacro

%macro avx512_compare_equal_byte 4
    vpcmpeqb %1, %2, %3, %4
%endmacro

%macro avx512_compare_equal_word 4
    vpcmpeqw %1, %2, %3, %4
%endmacro

%macro avx512_compare_equal_dword 4
    vpcmpeqd %1, %2, %3, %4
%endmacro

%macro avx512_compare_equal_qword 4
    vpcmpeqq %1, %2, %3, %4
%endmacro

%macro avx512_compare_greater_than_byte 4
    vpcmpgtb %1, %2, %3, %4
%endmacro

%macro avx512_compare_greater_than_word 4
    vpcmpgtw %1, %2, %3, %4
%endmacro

%macro avx512_compare_greater_than_dword 4
    vpcmpgtd %1, %2, %3, %4
%endmacro

%macro avx512_compare_greater_than_qword 4
    vpcmpgtq %1, %2, %3, %4
%endmacro

