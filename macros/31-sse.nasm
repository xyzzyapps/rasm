; ============================================================================
; SECTION 31: SSE INSTRUCTIONS
; ============================================================================

%macro sse-add-packed-single 2
    addps %1, %2
%endmacro

%macro sse-add-scalar-single 2
    addss %1, %2
%endmacro

%macro sse-and-packed-single 2
    andps %1, %2
%endmacro

%macro sse-and-not-packed-single 2
    andnps %1, %2
%endmacro

%macro sse-compare-packed-single 3
    cmpps %1, %2, %3
%endmacro

%macro sse-compare-scalar-single 3
    cmpss %1, %2, %3
%endmacro

%macro sse-compare-ordered-scalar-single 2
    comiss %1, %2
%endmacro

%macro sse-divide-packed-single 2
    divps %1, %2
%endmacro

%macro sse-divide-scalar-single 2
    divss %1, %2
%endmacro

%macro sse-load-unaligned-single 2
    movups %1, %2
%endmacro

%macro sse-load-aligned-single 2
    movaps %1, %2
%endmacro

%macro sse-move-scalar-single 2
    movss %1, %2
%endmacro

%macro sse-move-high-to-low 2
    movhlps %1, %2
%endmacro

%macro sse-move-low-to-high 2
    movlhps %1, %2
%endmacro

%macro sse-move-high-packed-single 2
    movhps %1, %2
%endmacro

%macro sse-move-low-packed-single 2
    movlps %1, %2
%endmacro

%macro sse-move-mask-packed-single 2
    movmskps %1, %2
%endmacro

%macro sse-move-non-temporal-single 2
    movntps %1, %2
%endmacro

%macro sse-maximum-packed-single 2
    maxps %1, %2
%endmacro

%macro sse-maximum-scalar-single 2
    maxss %1, %2
%endmacro

%macro sse-minimum-packed-single 2
    minps %1, %2
%endmacro

%macro sse-minimum-scalar-single 2
    minss %1, %2
%endmacro

%macro sse-multiply-packed-single 2
    mulps %1, %2
%endmacro

%macro sse-multiply-scalar-single 2
    mulss %1, %2
%endmacro

%macro sse-or-packed-single 2
    orps %1, %2
%endmacro

%macro sse-reciprocal-packed-single 1
    rcpps %1
%endmacro

%macro sse-reciprocal-scalar-single 1
    rcpss %1
%endmacro

%macro sse-reciprocal-square-root-packed-single 1
    rsqrtps %1
%endmacro

%macro sse-reciprocal-square-root-scalar-single 1
    rsqrtss %1
%endmacro

%macro sse-shuffle-packed-single 3
    shufps %1, %2, %3
%endmacro

%macro sse-square-root-packed-single 1
    sqrtps %1
%endmacro

%macro sse-square-root-scalar-single 1
    sqrtss %1
%endmacro

%macro sse-subtract-packed-single 2
    subps %1, %2
%endmacro

%macro sse-subtract-scalar-single 2
    subss %1, %2
%endmacro

%macro sse-unpack-high-packed-single 2
    unpckhps %1, %2
%endmacro

%macro sse-unpack-low-packed-single 2
    unpcklps %1, %2
%endmacro

%macro sse-xor-packed-single 2
    xorps %1, %2
%endmacro

