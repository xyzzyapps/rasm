; ============================================================================
; SECTION 17: REPEAT PREFIXES
; ============================================================================

%macro repeat 1
    rep %1
%endmacro

%macro repeat-if-equal 1
    repe %1
%endmacro

%macro repeat-if-zero 1
    repz %1
%endmacro

%macro repeat-if-not-equal 1
    repne %1
%endmacro

%macro repeat-if-not-zero 1
    repnz %1
%endmacro

