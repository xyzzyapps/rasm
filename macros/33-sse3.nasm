; ============================================================================
; SECTION 33: SSE3 INSTRUCTIONS
; ============================================================================

%macro sse3_add_subtract_packed_double 2
    addsubpd %1, %2
%endmacro

%macro sse3_add_subtract_packed_single 2
    addsubps %1, %2
%endmacro

%macro sse3_horizontal_add_packed_double 2
    haddpd %1, %2
%endmacro

%macro sse3_horizontal_add_packed_single 2
    haddps %1, %2
%endmacro

%macro sse3_horizontal_subtract_packed_double 2
    hsubpd %1, %2
%endmacro

%macro sse3_horizontal_subtract_packed_single 2
    hsubps %1, %2
%endmacro

%macro sse3_load_duplicate_unaligned 2
    lddqu %1, %2
%endmacro

