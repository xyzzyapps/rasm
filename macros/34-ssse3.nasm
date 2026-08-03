; ============================================================================
; SECTION 34: SSSE3 INSTRUCTIONS
; ============================================================================

%macro ssse3_shuffle_packed_bytes 2
    pshufb %1, %2
%endmacro

%macro ssse3_sign_packed_bytes 2
    psignb %1, %2
%endmacro

%macro ssse3_sign_packed_words 2
    psignw %1, %2
%endmacro

%macro ssse3_sign_packed_dwords 2
    psignd %1, %2
%endmacro

