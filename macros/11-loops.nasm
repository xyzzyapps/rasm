; ============================================================================
; 11-loops.nasm - Loop Instructions
; ============================================================================

%macro loop 1
    loop %1
%endmacro

%macro loop_if_equal 1
    loope %1
%endmacro

%macro loop_if_zero 1
    loopz %1
%endmacro

%macro loop_if_not_equal 1
    loopne %1
%endmacro

%macro loop_if_not_zero 1
    loopnz %1
%endmacro
