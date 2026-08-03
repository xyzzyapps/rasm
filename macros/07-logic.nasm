; ============================================================================
; 07-logic.nasm - Logic Instructions
; ============================================================================

%macro logical_and 2
    and %1, %2
%endmacro

%macro logical_and_not 2
    andn %1, %2
%endmacro

%macro logical_or 2
    or %1, %2
%endmacro

%macro logical_xor 2
    xor %1, %2
%endmacro

%macro logical_not 1
    not %1
%endmacro

%macro test 2
    test %1, %2
%endmacro
