; ============================================================================
; 08-shift-rotate.nasm - Shift and Rotate Instructions
; ============================================================================

%macro shift_logical_left 2
    shl %1, %2
%endmacro

%macro shift_arithmetic_left 2
    sal %1, %2
%endmacro

%macro shift_logical_right 2
    shr %1, %2
%endmacro

%macro shift_arithmetic_right 2
    sar %1, %2
%endmacro

%macro rotate_left 2
    rol %1, %2
%endmacro

%macro rotate_right 2
    ror %1, %2
%endmacro

%macro rotate_left_through_carry 2
    rcl %1, %2
%endmacro

%macro rotate_right_through_carry 2
    rcr %1, %2
%endmacro

%macro shift_left_double 3
    shld %1, %2, %3
%endmacro

%macro shift_right_double 3
    shrd %1, %2, %3
%endmacro

%macro rotate_right_without_affecting_flags 3
    rorx %1, %2, %3
%endmacro

%macro shift_left_without_affecting_flags 3
    shlx %1, %2, %3
%endmacro

%macro shift_right_arithmetic_without_affecting_flags 3
    sarx %1, %2, %3
%endmacro

%macro shift_right_logical_without_affecting_flags 3
    shrx %1, %2, %3
%endmacro
