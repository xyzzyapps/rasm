; ============================================================================
; 07-logic.nasm - Logic Instructions
; ============================================================================

%macro logical-and 2
    and %1, %2
%endmacro

%macro logical-and-not 2
    andn %1, %2
%endmacro

%macro logical-or 2
    or %1, %2
%endmacro

%macro logical-xor 2
    xor %1, %2
%endmacro

%macro logical-not 1
    not %1
%endmacro

%macro test 2
    test %1, %2
%endmacro
