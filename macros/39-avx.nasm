; ============================================================================
; SECTION 39: AVX INSTRUCTIONS
; ============================================================================

%macro avx-add-packed-double 3
    vaddpd %1, %2, %3
%endmacro

%macro avx-add-packed-single 3
    vaddps %1, %2, %3
%endmacro

%macro avx-add-scalar-double 3
    vaddsd %1, %2, %3
%endmacro

%macro avx-add-scalar-single 3
    vaddss %1, %2, %3
%endmacro

%macro avx-and-packed-double 3
    vandpd %1, %2, %3
%endmacro

%macro avx-and-packed-single 3
    vandps %1, %2, %3
%endmacro

%macro avx-and-not-packed-double 3
    vandnpd %1, %2, %3
%endmacro

%macro avx-and-not-packed-single 3
    vandnps %1, %2, %3
%endmacro

%macro avx-blend-packed-double 4
    vblendpd %1, %2, %3, %4
%endmacro

%macro avx-blend-packed-single 4
    vblendps %1, %2, %3, %4
%endmacro

%macro avx-variable-blend-packed-double 4
    vblendvpd %1, %2, %3, %4
%endmacro

%macro avx-variable-blend-packed-single 4
    vblendvps %1, %2, %3, %4
%endmacro

%macro avx-broadcast-scalar-double 2
    vbroadcastsd %1, %2
%endmacro

%macro avx-broadcast-scalar-single 2
    vbroadcastss %1, %2
%endmacro

%macro avx-compare-packed-double 4
    vcmppd %1, %2, %3, %4
%endmacro

%macro avx-compare-packed-single 4
    vcmpps %1, %2, %3, %4
%endmacro

%macro avx-compare-scalar-double 4
    vcmpsd %1, %2, %3, %4
%endmacro

%macro avx-compare-scalar-single 4
    vcmpss %1, %2, %3, %4
%endmacro

%macro avx-compare-ordered-scalar-double 2
    vcomisd %1, %2
%endmacro

%macro avx-compare-ordered-scalar-single 2
    vcomiss %1, %2
%endmacro

%macro avx-divide-packed-double 3
    vdivpd %1, %2, %3
%endmacro

%macro avx-divide-packed-single 3
    vdivps %1, %2, %3
%endmacro

%macro avx-divide-scalar-double 3
    vdivsd %1, %2, %3
%endmacro

%macro avx-divide-scalar-single 3
    vdivss %1, %2, %3
%endmacro

%macro avx-dot-product-packed-double 4
    vdppd %1, %2, %3, %4
%endmacro

%macro avx-dot-product-packed-single 4
    vdpps %1, %2, %3, %4
%endmacro

%macro avx-horizontal-add-packed-double 3
    vhaddpd %1, %2, %3
%endmacro

%macro avx-horizontal-add-packed-single 3
    vhaddps %1, %2, %3
%endmacro

%macro avx-horizontal-subtract-packed-double 3
    vhsubpd %1, %2, %3
%endmacro

%macro avx-horizontal-subtract-packed-single 3
    vhsubps %1, %2, %3
%endmacro

%macro avx-insert-packed-single 4
    vinsertps %1, %2, %3, %4
%endmacro

%macro avx-load-aligned 2
    vmovaps %1, %2
%endmacro

%macro avx-load-unaligned 2
    vmovups %1, %2
%endmacro

%macro avx-load-aligned-double 2
    vmovapd %1, %2
%endmacro

%macro avx-load-unaligned-double 2
    vmovupd %1, %2
%endmacro

%macro avx-load-aligned-integer 2
    vmovdqa %1, %2
%endmacro

%macro avx-load-unaligned-integer 2
    vmovdqu %1, %2
%endmacro

%macro avx-maximum-packed-double 3
    vmaxpd %1, %2, %3
%endmacro

%macro avx-maximum-packed-single 3
    vmaxps %1, %2, %3
%endmacro

%macro avx-maximum-scalar-double 3
    vmaxsd %1, %2, %3
%endmacro

%macro avx-maximum-scalar-single 3
    vmaxss %1, %2, %3
%endmacro

%macro avx-minimum-packed-double 3
    vminpd %1, %2, %3
%endmacro

%macro avx-minimum-packed-single 3
    vminps %1, %2, %3
%endmacro

%macro avx-minimum-scalar-double 3
    vminsd %1, %2, %3
%endmacro

%macro avx-minimum-scalar-single 3
    vminss %1, %2, %3
%endmacro

%macro avx-multiply-packed-double 3
    vmulpd %1, %2, %3
%endmacro

%macro avx-multiply-packed-single 3
    vmulps %1, %2, %3
%endmacro

%macro avx-multiply-scalar-double 3
    vmulsd %1, %2, %3
%endmacro

%macro avx-multiply-scalar-single 3
    vmulss %1, %2, %3
%endmacro

%macro avx-or-packed-double 3
    vorpd %1, %2, %3
%endmacro

%macro avx-or-packed-single 3
    vorps %1, %2, %3
%endmacro

%macro avx-permute-double 3
    vpermilpd %1, %2, %3
%endmacro

%macro avx-permute-single 3
    vpermilps %1, %2, %3
%endmacro

%macro avx-permute-2x128 4
    vperm2f128 %1, %2, %3, %4
%endmacro

%macro avx-reciprocal-packed-single 2
    vrcpps %1, %2
%endmacro

%macro avx-reciprocal-scalar-single 3
    vrcpss %1, %2, %3
%endmacro

%macro avx-reciprocal-square-root-packed-single 2
    vrsqrtps %1, %2
%endmacro

%macro avx-reciprocal-square-root-scalar-single 3
    vrsqrtss %1, %2, %3
%endmacro

%macro avx-round-packed-double 3
    vroundpd %1, %2, %3
%endmacro

%macro avx-round-packed-single 3
    vroundps %1, %2, %3
%endmacro

%macro avx-round-scalar-double 3
    vroundsd %1, %2, %3
%endmacro

%macro avx-round-scalar-single 3
    vroundss %1, %2, %3
%endmacro

%macro avx-shuffle-packed-double 4
    vshufpd %1, %2, %3, %4
%endmacro

%macro avx-shuffle-packed-single 4
    vshufps %1, %2, %3, %4
%endmacro

%macro avx-square-root-packed-double 2
    vsqrtpd %1, %2
%endmacro

%macro avx-square-root-packed-single 2
    vsqrtps %1, %2
%endmacro

%macro avx-square-root-scalar-double 3
    vsqrtsd %1, %2, %3
%endmacro

%macro avx-square-root-scalar-single 3
    vsqrtss %1, %2, %3
%endmacro

%macro avx-subtract-packed-double 3
    vsubpd %1, %2, %3
%endmacro

%macro avx-subtract-packed-single 3
    vsubps %1, %2, %3
%endmacro

%macro avx-subtract-scalar-double 3
    vsubsd %1, %2, %3
%endmacro

%macro avx-subtract-scalar-single 3
    vsubss %1, %2, %3
%endmacro

%macro avx-test-packed-double 3
    vtestpd %1, %2, %3
%endmacro

%macro avx-test-packed-single 3
    vtestps %1, %2, %3
%endmacro

%macro avx-unpack-high-packed-double 3
    vunpckhpd %1, %2, %3
%endmacro

%macro avx-unpack-high-packed-single 3
    vunpckhps %1, %2, %3
%endmacro

%macro avx-unpack-low-packed-double 3
    vunpcklpd %1, %2, %3
%endmacro

%macro avx-unpack-low-packed-single 3
    vunpcklps %1, %2, %3
%endmacro

%macro avx-xor-packed-double 3
    vxorpd %1, %2, %3
%endmacro

%macro avx-xor-packed-single 3
    vxorps %1, %2, %3
%endmacro

%macro avx-zero-upper 0
    vzeroupper
%endmacro

%macro avx-zero-all 0
    vzeroall
%endmacro

