; ============================================================================
; 08-shift-rotate.nasm - Shift and Rotate Instructions
; ============================================================================
; Naming: shift_logical_left/right, shift_arithmetic_left/right,
;   rotate_left/right, rotate_*_through_carry (rcl/rcr).

%macro shift_logical_left 2
    shl %1, %2
%endmacro

%macro shift_logical_left_byte 2
    shl size_byte %1, %2
%endmacro

%macro shift_logical_left_word 2
    shl size_word %1, %2
%endmacro

%macro shift_logical_left_dword 2
    shl size_dword %1, %2
%endmacro

%macro shift_logical_left_qword 2
    shl size_qword %1, %2
%endmacro

%macro shift_arithmetic_left 2
    sal %1, %2
%endmacro

%macro shift_arithmetic_left_byte 2
    sal size_byte %1, %2
%endmacro

%macro shift_arithmetic_left_word 2
    sal size_word %1, %2
%endmacro

%macro shift_arithmetic_left_dword 2
    sal size_dword %1, %2
%endmacro

%macro shift_arithmetic_left_qword 2
    sal size_qword %1, %2
%endmacro

%macro shift_logical_right 2
    shr %1, %2
%endmacro

%macro shift_logical_right_byte 2
    shr size_byte %1, %2
%endmacro

%macro shift_logical_right_word 2
    shr size_word %1, %2
%endmacro

%macro shift_logical_right_dword 2
    shr size_dword %1, %2
%endmacro

%macro shift_logical_right_qword 2
    shr size_qword %1, %2
%endmacro

%macro shift_arithmetic_right 2
    sar %1, %2
%endmacro

%macro shift_arithmetic_right_byte 2
    sar size_byte %1, %2
%endmacro

%macro shift_arithmetic_right_word 2
    sar size_word %1, %2
%endmacro

%macro shift_arithmetic_right_dword 2
    sar size_dword %1, %2
%endmacro

%macro shift_arithmetic_right_qword 2
    sar size_qword %1, %2
%endmacro

%macro rotate_left 2
    rol %1, %2
%endmacro

%macro rotate_left_byte 2
    rol size_byte %1, %2
%endmacro

%macro rotate_left_word 2
    rol size_word %1, %2
%endmacro

%macro rotate_left_dword 2
    rol size_dword %1, %2
%endmacro

%macro rotate_left_qword 2
    rol size_qword %1, %2
%endmacro

%macro rotate_right 2
    ror %1, %2
%endmacro

%macro rotate_right_byte 2
    ror size_byte %1, %2
%endmacro

%macro rotate_right_word 2
    ror size_word %1, %2
%endmacro

%macro rotate_right_dword 2
    ror size_dword %1, %2
%endmacro

%macro rotate_right_qword 2
    ror size_qword %1, %2
%endmacro

%macro rotate_left_through_carry 2
    rcl %1, %2
%endmacro

%macro rotate_left_through_carry_byte 2
    rcl size_byte %1, %2
%endmacro

%macro rotate_left_through_carry_word 2
    rcl size_word %1, %2
%endmacro

%macro rotate_left_through_carry_dword 2
    rcl size_dword %1, %2
%endmacro

%macro rotate_left_through_carry_qword 2
    rcl size_qword %1, %2
%endmacro

%macro rotate_right_through_carry 2
    rcr %1, %2
%endmacro

%macro rotate_right_through_carry_byte 2
    rcr size_byte %1, %2
%endmacro

%macro rotate_right_through_carry_word 2
    rcr size_word %1, %2
%endmacro

%macro rotate_right_through_carry_dword 2
    rcr size_dword %1, %2
%endmacro

%macro rotate_right_through_carry_qword 2
    rcr size_qword %1, %2
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
