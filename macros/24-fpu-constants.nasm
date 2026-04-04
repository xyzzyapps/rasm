; ============================================================================
; SECTION 24: X87 FPU - CONSTANT LOAD INSTRUCTIONS
; ============================================================================

%macro fpu-load-zero 0
    fldz
%endmacro

%macro fpu-load-one 0
    fld1
%endmacro

%macro fpu-load-pi 0
    fldpi
%endmacro

%macro fpu-load-log2-10 0
    fldl2t
%endmacro

%macro fpu-load-log2-e 0
    fldl2e
%endmacro

%macro fpu-load-log10-2 0
    fldlg2
%endmacro

%macro fpu-load-ln-2 0
    fldln2
%endmacro

