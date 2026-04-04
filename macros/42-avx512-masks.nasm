; ============================================================================
; SECTION 42: AVX-512 MASK REGISTER OPERATIONS
; ============================================================================

%macro avx512-mask-add-byte 3
    kaddb %1, %2, %3
%endmacro

%macro avx512-mask-add-word 3
    kaddw %1, %2, %3
%endmacro

%macro avx512-mask-add-dword 3
    kaddd %1, %2, %3
%endmacro

%macro avx512-mask-add-qword 3
    kaddq %1, %2, %3
%endmacro

%macro avx512-mask-and-byte 3
    kandb %1, %2, %3
%endmacro

%macro avx512-mask-and-word 3
    kandw %1, %2, %3
%endmacro

%macro avx512-mask-and-dword 3
    kandd %1, %2, %3
%endmacro

%macro avx512-mask-and-qword 3
    kandq %1, %2, %3
%endmacro

%macro avx512-mask-and-not-byte 3
    kandnb %1, %2, %3
%endmacro

%macro avx512-mask-and-not-word 3
    kandnw %1, %2, %3
%endmacro

%macro avx512-mask-and-not-dword 3
    kandnd %1, %2, %3
%endmacro

%macro avx512-mask-and-not-qword 3
    kandnq %1, %2, %3
%endmacro

%macro avx512-mask-move-byte 2
    kmovb %1, %2
%endmacro

%macro avx512-mask-move-word 2
    kmovw %1, %2
%endmacro

%macro avx512-mask-move-dword 2
    kmovd %1, %2
%endmacro

%macro avx512-mask-move-qword 2
    kmovq %1, %2
%endmacro

%macro avx512-mask-not-byte 2
    knotb %1, %2
%endmacro

%macro avx512-mask-not-word 2
    knotw %1, %2
%endmacro

%macro avx512-mask-not-dword 2
    knotd %1, %2
%endmacro

%macro avx512-mask-not-qword 2
    knotq %1, %2
%endmacro

%macro avx512-mask-or-byte 3
    korb %1, %2, %3
%endmacro

%macro avx512-mask-or-word 3
    korw %1, %2, %3
%endmacro

%macro avx512-mask-or-dword 3
    kord %1, %2, %3
%endmacro

%macro avx512-mask-or-qword 3
    korq %1, %2, %3
%endmacro

%macro avx512-mask-or-test-byte 2
    kortestb %1, %2
%endmacro

%macro avx512-mask-or-test-word 2
    kortestw %1, %2
%endmacro

%macro avx512-mask-or-test-dword 2
    kortestd %1, %2
%endmacro

%macro avx512-mask-or-test-qword 2
    kortestq %1, %2
%endmacro

%macro avx512-mask-shift-left-byte 3
    kshiftlb %1, %2, %3
%endmacro

%macro avx512-mask-shift-left-word 3
    kshiftlw %1, %2, %3
%endmacro

%macro avx512-mask-shift-left-dword 3
    kshiftld %1, %2, %3
%endmacro

%macro avx512-mask-shift-left-qword 3
    kshiftlq %1, %2, %3
%endmacro

%macro avx512-mask-shift-right-byte 3
    kshiftrb %1, %2, %3
%endmacro

%macro avx512-mask-shift-right-word 3
    kshiftrw %1, %2, %3
%endmacro

%macro avx512-mask-shift-right-dword 3
    kshiftrd %1, %2, %3
%endmacro

%macro avx512-mask-shift-right-qword 3
    kshiftrq %1, %2, %3
%endmacro

%macro avx512-mask-test-byte 2
    ktestb %1, %2
%endmacro

%macro avx512-mask-test-word 2
    ktestw %1, %2
%endmacro

%macro avx512-mask-test-dword 2
    ktestd %1, %2
%endmacro

%macro avx512-mask-test-qword 2
    ktestq %1, %2
%endmacro

%macro avx512-mask-unpack-byte-word 3
    kunpckbw %1, %2, %3
%endmacro

%macro avx512-mask-unpack-word-dword 3
    kunpckwd %1, %2, %3
%endmacro

%macro avx512-mask-unpack-dword-qword 3
    kunpckdq %1, %2, %3
%endmacro

%macro avx512-mask-xnor-byte 3
    kxnorb %1, %2, %3
%endmacro

%macro avx512-mask-xnor-word 3
    kxnorw %1, %2, %3
%endmacro

%macro avx512-mask-xnor-dword 3
    kxnord %1, %2, %3
%endmacro

%macro avx512-mask-xnor-qword 3
    kxnorq %1, %2, %3
%endmacro

%macro avx512-mask-xor-byte 3
    kxorb %1, %2, %3
%endmacro

%macro avx512-mask-xor-word 3
    kxorw %1, %2, %3
%endmacro

%macro avx512-mask-xor-dword 3
    kxord %1, %2, %3
%endmacro

%macro avx512-mask-xor-qword 3
    kxorq %1, %2, %3
%endmacro

; --- AVX-512 Data Movement ---
%macro avx512-move-aligned-dword 2
    vmovdqa32 %1, %2
%endmacro

%macro avx512-move-aligned-qword 2
    vmovdqa64 %1, %2
%endmacro

%macro avx512-move-unaligned-byte 2
    vmovdqu8 %1, %2
%endmacro

%macro avx512-move-unaligned-word 2
    vmovdqu16 %1, %2
%endmacro

%macro avx512-move-unaligned-dword 2
    vmovdqu32 %1, %2
%endmacro

%macro avx512-move-unaligned-qword 2
    vmovdqu64 %1, %2
%endmacro

; --- AVX-512 Compress/Expand ---
%macro avx512-compress-packed-single 2
    vcompressps %1, %2
%endmacro

%macro avx512-compress-packed-double 2
    vcompresspd %1, %2
%endmacro

%macro avx512-expand-packed-single 2
    vexpandps %1, %2
%endmacro

%macro avx512-expand-packed-double 2
    vexpandpd %1, %2
%endmacro

; --- AVX-512 Ternary Logic ---
%macro avx512-ternary-logic-dword 4
    vpternlogd %1, %2, %3, %4
%endmacro

%macro avx512-ternary-logic-qword 4
    vpternlogq %1, %2, %3, %4
%endmacro

; --- AVX-512 FP Classify ---
%macro avx512-fp-classify-single 3
    vfpclassps %1, %2, %3
%endmacro

%macro avx512-fp-classify-double 3
    vfpclasspd %1, %2, %3
%endmacro

%macro avx512-fp-classify-scalar-single 3
    vfpclassss %1, %2, %3
%endmacro

%macro avx512-fp-classify-scalar-double 3
    vfpclasssd %1, %2, %3
%endmacro

; --- AVX-512 Reduce ---
%macro avx512-reduce-packed-single 3
    vreduceps %1, %2, %3
%endmacro

%macro avx512-reduce-packed-double 3
    vreducepd %1, %2, %3
%endmacro

%macro avx512-reduce-scalar-single 3
    vreducess %1, %2, %3
%endmacro

%macro avx512-reduce-scalar-double 3
    vreducesd %1, %2, %3
%endmacro

; --- AVX-512 Round Scale ---
%macro avx512-round-scale-packed-single 3
    vrndscaleps %1, %2, %3
%endmacro

%macro avx512-round-scale-packed-double 3
    vrndscalepd %1, %2, %3
%endmacro

%macro avx512-round-scale-scalar-single 3
    vrndscaless %1, %2, %3
%endmacro

%macro avx512-round-scale-scalar-double 3
    vrndscalesd %1, %2, %3
%endmacro

; --- AVX-512 Scale ---
%macro avx512-scale-packed-single 3
    vscalefps %1, %2, %3
%endmacro

%macro avx512-scale-packed-double 3
    vscalefpd %1, %2, %3
%endmacro

%macro avx512-scale-scalar-single 3
    vscalefss %1, %2, %3
%endmacro

%macro avx512-scale-scalar-double 3
    vscalefsd %1, %2, %3
%endmacro

; --- AVX-512 Scatter/Gather ---
%macro avx512-scatter-dword-single 5
    vscatterdps %1, %2, %3, %4, %5
%endmacro

%macro avx512-scatter-qword-single 5
    vscatterqps %1, %2, %3, %4, %5
%endmacro

%macro avx512-scatter-dword-double 5
    vscatterdpd %1, %2, %3, %4, %5
%endmacro

%macro avx512-scatter-qword-double 5
    vscatterqpd %1, %2, %3, %4, %5
%endmacro

; --- AVX-512 Integer Operations ---
%macro avx512-abs-packed-byte 2
    vpabsb %1, %2
%endmacro

%macro avx512-abs-packed-word 2
    vpabsw %1, %2
%endmacro

%macro avx512-abs-packed-dword 2
    vpabsd %1, %2
%endmacro

%macro avx512-abs-packed-qword 2
    vpabsq %1, %2
%endmacro

%macro avx512-add-packed-byte 3
    vpaddb %1, %2, %3
%endmacro

%macro avx512-add-packed-word 3
    vpaddw %1, %2, %3
%endmacro

%macro avx512-add-packed-dword 3
    vpaddd %1, %2, %3
%endmacro

%macro avx512-add-packed-qword 3
    vpaddq %1, %2, %3
%endmacro

%macro avx512-compare-equal-byte 4
    vpcmpeqb %1, %2, %3, %4
%endmacro

%macro avx512-compare-equal-word 4
    vpcmpeqw %1, %2, %3, %4
%endmacro

%macro avx512-compare-equal-dword 4
    vpcmpeqd %1, %2, %3, %4
%endmacro

%macro avx512-compare-equal-qword 4
    vpcmpeqq %1, %2, %3, %4
%endmacro

%macro avx512-compare-greater-than-byte 4
    vpcmpgtb %1, %2, %3, %4
%endmacro

%macro avx512-compare-greater-than-word 4
    vpcmpgtw %1, %2, %3, %4
%endmacro

%macro avx512-compare-greater-than-dword 4
    vpcmpgtd %1, %2, %3, %4
%endmacro

%macro avx512-compare-greater-than-qword 4
    vpcmpgtq %1, %2, %3, %4
%endmacro

