; ============================================================================
; SECTION 39: AVX INSTRUCTIONS
; ============================================================================

%macro avx_add_packed_double 3
    vaddpd %1, %2, %3
%endmacro

%macro avx_add_packed_single 3
    vaddps %1, %2, %3
%endmacro

%macro avx_add_scalar_double 3
    vaddsd %1, %2, %3
%endmacro

%macro avx_add_scalar_single 3
    vaddss %1, %2, %3
%endmacro

%macro avx_and_packed_double 3
    vandpd %1, %2, %3
%endmacro

%macro avx_and_packed_single 3
    vandps %1, %2, %3
%endmacro

%macro avx_and_not_packed_double 3
    vandnpd %1, %2, %3
%endmacro

%macro avx_and_not_packed_single 3
    vandnps %1, %2, %3
%endmacro

%macro avx_blend_packed_double 4
    vblendpd %1, %2, %3, %4
%endmacro

%macro avx_blend_packed_single 4
    vblendps %1, %2, %3, %4
%endmacro

%macro avx_variable_blend_packed_double 4
    vblendvpd %1, %2, %3, %4
%endmacro

%macro avx_variable_blend_packed_single 4
    vblendvps %1, %2, %3, %4
%endmacro

%macro avx_broadcast_scalar_double 2
    vbroadcastsd %1, %2
%endmacro

%macro avx_broadcast_scalar_single 2
    vbroadcastss %1, %2
%endmacro

%macro avx_compare_packed_double 4
    vcmppd %1, %2, %3, %4
%endmacro

%macro avx_compare_packed_single 4
    vcmpps %1, %2, %3, %4
%endmacro

%macro avx_compare_scalar_double 4
    vcmpsd %1, %2, %3, %4
%endmacro

%macro avx_compare_scalar_single 4
    vcmpss %1, %2, %3, %4
%endmacro

%macro avx_compare_ordered_scalar_double 2
    vcomisd %1, %2
%endmacro

%macro avx_compare_ordered_scalar_single 2
    vcomiss %1, %2
%endmacro

%macro avx_divide_packed_double 3
    vdivpd %1, %2, %3
%endmacro

%macro avx_divide_packed_single 3
    vdivps %1, %2, %3
%endmacro

%macro avx_divide_scalar_double 3
    vdivsd %1, %2, %3
%endmacro

%macro avx_divide_scalar_single 3
    vdivss %1, %2, %3
%endmacro

%macro avx_dot_product_packed_double 4
    vdppd %1, %2, %3, %4
%endmacro

%macro avx_dot_product_packed_single 4
    vdpps %1, %2, %3, %4
%endmacro

%macro avx_horizontal_add_packed_double 3
    vhaddpd %1, %2, %3
%endmacro

%macro avx_horizontal_add_packed_single 3
    vhaddps %1, %2, %3
%endmacro

%macro avx_horizontal_subtract_packed_double 3
    vhsubpd %1, %2, %3
%endmacro

%macro avx_horizontal_subtract_packed_single 3
    vhsubps %1, %2, %3
%endmacro

%macro avx_insert_packed_single 4
    vinsertps %1, %2, %3, %4
%endmacro

%macro avx_load_aligned 2
    vmovaps %1, %2
%endmacro

%macro avx_load_unaligned 2
    vmovups %1, %2
%endmacro

%macro avx_load_aligned_double 2
    vmovapd %1, %2
%endmacro

%macro avx_load_unaligned_double 2
    vmovupd %1, %2
%endmacro

%macro avx_load_aligned_integer 2
    vmovdqa %1, %2
%endmacro

%macro avx_load_unaligned_integer 2
    vmovdqu %1, %2
%endmacro

%macro avx_maximum_packed_double 3
    vmaxpd %1, %2, %3
%endmacro

%macro avx_maximum_packed_single 3
    vmaxps %1, %2, %3
%endmacro

%macro avx_maximum_scalar_double 3
    vmaxsd %1, %2, %3
%endmacro

%macro avx_maximum_scalar_single 3
    vmaxss %1, %2, %3
%endmacro

%macro avx_minimum_packed_double 3
    vminpd %1, %2, %3
%endmacro

%macro avx_minimum_packed_single 3
    vminps %1, %2, %3
%endmacro

%macro avx_minimum_scalar_double 3
    vminsd %1, %2, %3
%endmacro

%macro avx_minimum_scalar_single 3
    vminss %1, %2, %3
%endmacro

%macro avx_multiply_packed_double 3
    vmulpd %1, %2, %3
%endmacro

%macro avx_multiply_packed_single 3
    vmulps %1, %2, %3
%endmacro

%macro avx_multiply_scalar_double 3
    vmulsd %1, %2, %3
%endmacro

%macro avx_multiply_scalar_single 3
    vmulss %1, %2, %3
%endmacro

%macro avx_or_packed_double 3
    vorpd %1, %2, %3
%endmacro

%macro avx_or_packed_single 3
    vorps %1, %2, %3
%endmacro

%macro avx_permute_double 3
    vpermilpd %1, %2, %3
%endmacro

%macro avx_permute_single 3
    vpermilps %1, %2, %3
%endmacro

%macro avx_permute_2x128 4
    vperm2f128 %1, %2, %3, %4
%endmacro

%macro avx_reciprocal_packed_single 2
    vrcpps %1, %2
%endmacro

%macro avx_reciprocal_scalar_single 3
    vrcpss %1, %2, %3
%endmacro

%macro avx_reciprocal_square_root_packed_single 2
    vrsqrtps %1, %2
%endmacro

%macro avx_reciprocal_square_root_scalar_single 3
    vrsqrtss %1, %2, %3
%endmacro

%macro avx_round_packed_double 3
    vroundpd %1, %2, %3
%endmacro

%macro avx_round_packed_single 3
    vroundps %1, %2, %3
%endmacro

%macro avx_round_scalar_double 3
    vroundsd %1, %2, %3
%endmacro

%macro avx_round_scalar_single 3
    vroundss %1, %2, %3
%endmacro

%macro avx_shuffle_packed_double 4
    vshufpd %1, %2, %3, %4
%endmacro

%macro avx_shuffle_packed_single 4
    vshufps %1, %2, %3, %4
%endmacro

%macro avx_square_root_packed_double 2
    vsqrtpd %1, %2
%endmacro

%macro avx_square_root_packed_single 2
    vsqrtps %1, %2
%endmacro

%macro avx_square_root_scalar_double 3
    vsqrtsd %1, %2, %3
%endmacro

%macro avx_square_root_scalar_single 3
    vsqrtss %1, %2, %3
%endmacro

%macro avx_subtract_packed_double 3
    vsubpd %1, %2, %3
%endmacro

%macro avx_subtract_packed_single 3
    vsubps %1, %2, %3
%endmacro

%macro avx_subtract_scalar_double 3
    vsubsd %1, %2, %3
%endmacro

%macro avx_subtract_scalar_single 3
    vsubss %1, %2, %3
%endmacro

%macro avx_test_packed_double 3
    vtestpd %1, %2, %3
%endmacro

%macro avx_test_packed_single 3
    vtestps %1, %2, %3
%endmacro

%macro avx_unpack_high_packed_double 3
    vunpckhpd %1, %2, %3
%endmacro

%macro avx_unpack_high_packed_single 3
    vunpckhps %1, %2, %3
%endmacro

%macro avx_unpack_low_packed_double 3
    vunpcklpd %1, %2, %3
%endmacro

%macro avx_unpack_low_packed_single 3
    vunpcklps %1, %2, %3
%endmacro

%macro avx_xor_packed_double 3
    vxorpd %1, %2, %3
%endmacro

%macro avx_xor_packed_single 3
    vxorps %1, %2, %3
%endmacro

%macro avx_zero_upper 0
    vzeroupper
%endmacro

%macro avx_zero_all 0
    vzeroall
%endmacro

