; ============================================================================
; SECTION 33: SSE3 INSTRUCTIONS
; ============================================================================

%macro sse3-add-subtract-packed-double 2
    addsubpd %1, %2
%endmacro

%macro sse3-add-subtract-packed-single 2
    addsubps %1, %2
%endmacro

%macro sse3-horizontal-add-packed-double 2
    haddpd %1, %2
%endmacro

%macro sse3-horizontal-add-packed-single 2
    haddps %1, %2
%endmacro

%macro sse3-horizontal-subtract-packed-double 2
    hsubpd %1, %2
%endmacro

%macro sse3-horizontal-subtract-packed-single 2
    hsubps %1, %2
%endmacro

%macro sse3-load-duplicate-unaligned 2
    lddqu %1, %2
%endmacro

