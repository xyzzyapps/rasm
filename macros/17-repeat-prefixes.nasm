; ============================================================================
; SECTION 17: REPEAT PREFIXES
; ============================================================================

%macro repeat 1
    rep %1
%endmacro

%macro repeat_if_equal 1
    repe %1
%endmacro

%macro repeat_if_zero 1
    repz %1
%endmacro

%macro repeat_if_not_equal 1
    repne %1
%endmacro

%macro repeat_if_not_zero 1
    repnz %1
%endmacro

