; ============================================================================
; SECTION 24: X87 FPU - CONSTANT LOAD INSTRUCTIONS
; ============================================================================

%macro fpu_load_zero 0
    fldz
%endmacro

%macro fpu_load_one 0
    fld1
%endmacro

%macro fpu_load_pi 0
    fldpi
%endmacro

%macro fpu_load_log2_10 0
    fldl2t
%endmacro

%macro fpu_load_log2_e 0
    fldl2e
%endmacro

%macro fpu_load_log10_2 0
    fldlg2
%endmacro

%macro fpu_load_ln_2 0
    fldln2
%endmacro

