; ============================================================================
; SECTION 23: X87 FPU - DATA TRANSFER INSTRUCTIONS
; ============================================================================

%macro fpu-load 1
    fld %1
%endmacro

%macro fpu-store 1
    fst %1
%endmacro

%macro fpu-store-and-pop 1
    fstp %1
%endmacro

%macro fpu-load-integer 1
    fild %1
%endmacro

%macro fpu-store-integer 1
    fist %1
%endmacro

%macro fpu-store-integer-and-pop 1
    fistp %1
%endmacro

%macro fpu-store-integer-truncate-and-pop 1
    fisttp %1
%endmacro

%macro fpu-load-bcd 1
    fbld %1
%endmacro

%macro fpu-store-bcd-and-pop 1
    fbstp %1
%endmacro

%macro fpu-exchange 0-1
%if %0 = 1
    fxch %1
%else
    fxch
%endif
%endmacro

