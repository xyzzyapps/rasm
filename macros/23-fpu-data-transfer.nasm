; ============================================================================
; SECTION 23: X87 FPU - DATA TRANSFER INSTRUCTIONS
; ============================================================================

%macro fpu_load 1
    fld %1
%endmacro

%macro fpu_store 1
    fst %1
%endmacro

%macro fpu_store_and_pop 1
    fstp %1
%endmacro

%macro fpu_load_integer 1
    fild %1
%endmacro

%macro fpu_store_integer 1
    fist %1
%endmacro

%macro fpu_store_integer_and_pop 1
    fistp %1
%endmacro

%macro fpu_store_integer_truncate_and_pop 1
    fisttp %1
%endmacro

%macro fpu_load_bcd 1
    fbld %1
%endmacro

%macro fpu_store_bcd_and_pop 1
    fbstp %1
%endmacro

%macro fpu_exchange 0-1
%if %0 = 1
    fxch %1
%else
    fxch
%endif
%endmacro

