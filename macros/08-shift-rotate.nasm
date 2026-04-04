; ============================================================================
; 08-shift-rotate.nasm - Shift and Rotate Instructions
; ============================================================================

%macro shift-logical-left 2
    shl %1, %2
%endmacro

%macro shift-arithmetic-left 2
    sal %1, %2
%endmacro

%macro shift-logical-right 2
    shr %1, %2
%endmacro

%macro shift-arithmetic-right 2
    sar %1, %2
%endmacro

%macro rotate-left 2
    rol %1, %2
%endmacro

%macro rotate-right 2
    ror %1, %2
%endmacro

%macro rotate-left-through-carry 2
    rcl %1, %2
%endmacro

%macro rotate-right-through-carry 2
    rcr %1, %2
%endmacro

%macro shift-left-double 3
    shld %1, %2, %3
%endmacro

%macro shift-right-double 3
    shrd %1, %2, %3
%endmacro

%macro rotate-right-without-affecting-flags 3
    rorx %1, %2, %3
%endmacro

%macro shift-left-without-affecting-flags 3
    shlx %1, %2, %3
%endmacro

%macro shift-right-arithmetic-without-affecting-flags 3
    sarx %1, %2, %3
%endmacro

%macro shift-right-logical-without-affecting-flags 3
    shrx %1, %2, %3
%endmacro
