; ============================================================================
; SECTION 32: SSE2 INSTRUCTIONS
; ============================================================================

%macro sse2-add-packed-double 2
    addpd %1, %2
%endmacro

%macro sse2-add-scalar-double 2
    addsd %1, %2
%endmacro

%macro sse2-add-packed-dword 2
    paddd %1, %2
%endmacro

%macro sse2-add-packed-qword 2
    paddq %1, %2
%endmacro

%macro sse2-add-packed-word 2
    paddw %1, %2
%endmacro

%macro sse2-add-packed-byte 2
    paddb %1, %2
%endmacro

%macro sse2-and-not-packed-double 2
    andnpd %1, %2
%endmacro

%macro sse2-and-packed-double 2
    andpd %1, %2
%endmacro

%macro sse2-compare-packed-double 3
    cmppd %1, %2, %3
%endmacro

%macro sse2-compare-scalar-double 3
    cmpsd %1, %2, %3
%endmacro

%macro sse2-compare-ordered-scalar-double 2
    comisd %1, %2
%endmacro

%macro sse2-divide-packed-double 2
    divpd %1, %2
%endmacro

%macro sse2-divide-scalar-double 2
    divsd %1, %2
%endmacro

%macro sse2-load-aligned-double 2
    movapd %1, %2
%endmacro

%macro sse2-load-unaligned-double 2
    movupd %1, %2
%endmacro

%macro sse2-move-scalar-double 2
    movsd %1, %2
%endmacro

%macro sse2-move-high-packed-double 2
    movhpd %1, %2
%endmacro

%macro sse2-move-low-packed-double 2
    movlpd %1, %2
%endmacro

%macro sse2-move-mask-packed-double 2
    movmskpd %1, %2
%endmacro

%macro sse2-move-aligned-packed-integer 2
    movdqa %1, %2
%endmacro

%macro sse2-move-unaligned-packed-integer 2
    movdqu %1, %2
%endmacro

%macro sse2-move-double-duplicate 2
    movddup %1, %2
%endmacro

%macro sse2-move-high-and-duplicate 2
    movshdup %1, %2
%endmacro

%macro sse2-move-low-and-duplicate 2
    movsldup %1, %2
%endmacro

%macro sse2-maximum-packed-double 2
    maxpd %1, %2
%endmacro

%macro sse2-maximum-scalar-double 2
    maxsd %1, %2
%endmacro

%macro sse2-minimum-packed-double 2
    minpd %1, %2
%endmacro

%macro sse2-minimum-scalar-double 2
    minsd %1, %2
%endmacro

%macro sse2-multiply-packed-double 2
    mulpd %1, %2
%endmacro

%macro sse2-multiply-scalar-double 2
    mulsd %1, %2
%endmacro

%macro sse2-or-packed-double 2
    orpd %1, %2
%endmacro

%macro sse2-pack-with-signed-saturation-dword 2
    packssdw %1, %2
%endmacro

%macro sse2-pack-with-signed-saturation-word 2
    packsswb %1, %2
%endmacro

%macro sse2-pack-with-unsigned-saturation-dword 2
    packusdw %1, %2
%endmacro

%macro sse2-pack-with-unsigned-saturation-word 2
    packuswb %1, %2
%endmacro

%macro sse2-compare-equal-qword 2
    pcmpeqq %1, %2
%endmacro

%macro sse2-compare-greater-than-qword 2
    pcmpgtq %1, %2
%endmacro

%macro sse2-extract-byte 3
    pextrb %1, %2, %3
%endmacro

%macro sse2-extract-dword 3
    pextrd %1, %2, %3
%endmacro

%macro sse2-extract-qword 3
    pextrq %1, %2, %3
%endmacro

%macro sse2-insert-byte 3
    pinsrb %1, %2, %3
%endmacro

%macro sse2-insert-dword 3
    pinsrd %1, %2, %3
%endmacro

%macro sse2-insert-qword 3
    pinsrq %1, %2, %3
%endmacro

%macro sse2-maximum-signed-dword 2
    pmaxsd %1, %2
%endmacro

%macro sse2-maximum-signed-word 2
    pmaxsw %1, %2
%endmacro

%macro sse2-maximum-unsigned-dword 2
    pmaxud %1, %2
%endmacro

%macro sse2-maximum-unsigned-word 2
    pmaxuw %1, %2
%endmacro

%macro sse2-minimum-signed-dword 2
    pminsd %1, %2
%endmacro

%macro sse2-minimum-signed-word 2
    pminsw %1, %2
%endmacro

%macro sse2-minimum-unsigned-dword 2
    pminud %1, %2
%endmacro

%macro sse2-minimum-unsigned-word 2
    pminuw %1, %2
%endmacro

%macro sse2-move-byte-mask-from-packed 2
    pmovmskb %1, %2
%endmacro

%macro sse2-multiply-packed-dword 2
    pmuludq %1, %2
%endmacro

%macro sse2-multiply-low-packed-dword 2
    pmulld %1, %2
%endmacro

%macro sse2-multiply-high-rounded-and-scale 2
    pmulhrsw %1, %2
%endmacro

%macro sse2-multiply-and-add-packed-signed-unsigned-bytes 2
    pmaddubsw %1, %2
%endmacro

%macro sse2-horizontal-add-packed-words 2
    phaddw %1, %2
%endmacro

%macro sse2-horizontal-add-packed-dwords 2
    phaddd %1, %2
%endmacro

%macro sse2-horizontal-add-and-saturate-packed-words 2
    phaddsw %1, %2
%endmacro

%macro sse2-horizontal-subtract-packed-words 2
    phsubw %1, %2
%endmacro

%macro sse2-horizontal-subtract-packed-dwords 2
    phsubd %1, %2
%endmacro

%macro sse2-horizontal-subtract-and-saturate-packed-words 2
    phsubsw %1, %2
%endmacro

%macro sse2-align-right-packed 3
    palignr %1, %2, %3
%endmacro

%macro sse2-absolute-value-packed-bytes 1
    pabsb %1
%endmacro

%macro sse2-absolute-value-packed-words 1
    pabsw %1
%endmacro

%macro sse2-absolute-value-packed-dwords 1
    pabsd %1
%endmacro

%macro sse2-sign-extend-packed-word-to-dword 2
    pmovsxwd %1, %2
%endmacro

%macro sse2-sign-extend-packed-byte-to-word 2
    pmovsxbw %1, %2
%endmacro

%macro sse2-sign-extend-packed-byte-to-dword 2
    pmovsxbd %1, %2
%endmacro

%macro sse2-sign-extend-packed-byte-to-qword 2
    pmovsxbq %1, %2
%endmacro

%macro sse2-sign-extend-packed-word-to-qword 2
    pmovsxwq %1, %2
%endmacro

%macro sse2-sign-extend-packed-dword-to-qword 2
    pmovsxdq %1, %2
%endmacro

%macro sse2-zero-extend-packed-word-to-dword 2
    pmovzxwd %1, %2
%endmacro

%macro sse2-zero-extend-packed-byte-to-word 2
    pmovzxbw %1, %2
%endmacro

%macro sse2-zero-extend-packed-byte-to-dword 2
    pmovzxbd %1, %2
%endmacro

%macro sse2-zero-extend-packed-byte-to-qword 2
    pmovzxbq %1, %2
%endmacro

%macro sse2-zero-extend-packed-word-to-qword 2
    pmovzxwq %1, %2
%endmacro

%macro sse2-zero-extend-packed-dword-to-qword 2
    pmovzxdq %1, %2
%endmacro

%macro sse2-shuffle-packed-double 3
    shufpd %1, %2, %3
%endmacro

%macro sse2-square-root-packed-double 1
    sqrtpd %1
%endmacro

%macro sse2-square-root-scalar-double 1
    sqrtsd %1
%endmacro

%macro sse2-store-non-temporal-dword 2
    movnti %1, %2
%endmacro

%macro sse2-store-non-temporal-double 2
    movntpd %1, %2
%endmacro

%macro sse2-subtract-packed-double 2
    subpd %1, %2
%endmacro

%macro sse2-subtract-scalar-double 2
    subsd %1, %2
%endmacro

%macro sse2-unpack-high-packed-double 2
    unpckhpd %1, %2
%endmacro

%macro sse2-unpack-low-packed-double 2
    unpcklpd %1, %2
%endmacro

%macro sse2-xor-packed-double 2
    xorpd %1, %2
%endmacro

