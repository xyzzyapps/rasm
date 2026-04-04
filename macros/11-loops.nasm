; ============================================================================
; 11-loops.nasm - Loop Instructions
; ============================================================================

%macro loop 1
    loop %1
%endmacro

%macro loop-if-equal 1
    loope %1
%endmacro

%macro loop-if-zero 1
    loopz %1
%endmacro

%macro loop-if-not-equal 1
    loopne %1
%endmacro

%macro loop-if-not-zero 1
    loopnz %1
%endmacro
