; ============================================================================
; SECTION 34: SSSE3 INSTRUCTIONS
; ============================================================================

%macro ssse3-shuffle-packed-bytes 2
    pshufb %1, %2
%endmacro

%macro ssse3-sign-packed-bytes 2
    psignb %1, %2
%endmacro

%macro ssse3-sign-packed-words 2
    psignw %1, %2
%endmacro

%macro ssse3-sign-packed-dwords 2
    psignd %1, %2
%endmacro

