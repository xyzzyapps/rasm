; ============================================================================
; SECTION 35: SSE4.1 INSTRUCTIONS
; ============================================================================

%macro sse41-blend-packed-bytes 3
    pblendvb %1, %2, %3
%endmacro

%macro sse41-blend-packed-words 3
    pblendw %1, %2, %3
%endmacro

%macro sse41-blend-packed-double 3
    blendpd %1, %2, %3
%endmacro

%macro sse41-blend-packed-single 3
    blendps %1, %2, %3
%endmacro

%macro sse41-dot-product-packed-double 3
    dppd %1, %2, %3
%endmacro

%macro sse41-dot-product-packed-single 3
    dpps %1, %2, %3
%endmacro

%macro sse41-extract-packed-single 3
    extractps %1, %2, %3
%endmacro

%macro sse41-insert-packed-single 4
    insertps %1, %2, %3, %4
%endmacro

%macro sse41-mask-move-packed-dword 3
    maskmovdqu %1, %2, %3
%endmacro

%macro sse41-pack-with-unsigned-saturation-dword 2
    packusdw %1, %2
%endmacro

%macro sse41-test-packed 2
    ptest %1, %2
%endmacro

%macro sse41-round-scalar-double 3
    roundsd %1, %2, %3
%endmacro

%macro sse41-round-scalar-single 3
    roundss %1, %2, %3
%endmacro

%macro sse41-round-packed-double 3
    roundpd %1, %2, %3
%endmacro

%macro sse41-round-packed-single 3
    roundps %1, %2, %3
%endmacro

%macro sse41-compare-implicit-length-string-return-index 3
    pcmpistri %1, %2, %3
%endmacro

%macro sse41-compare-implicit-length-string-return-mask 3
    pcmpistrm %1, %2, %3
%endmacro

%macro sse41-compare-explicit-length-string-return-index 3
    pcmpestri %1, %2, %3
%endmacro

%macro sse41-compare-explicit-length-string-return-mask 3
    pcmpestrm %1, %2, %3
%endmacro

