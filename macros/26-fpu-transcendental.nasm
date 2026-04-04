; ============================================================================
; SECTION 26: X87 FPU - TRANSCENDENTAL INSTRUCTIONS
; ============================================================================

%macro fpu-sine 0
    fsin
%endmacro

%macro fpu-cosine 0
    fcos
%endmacro

%macro fpu-sine-and-cosine 0
    fsincos
%endmacro

%macro fpu-partial-tangent 0
    fptan
%endmacro

%macro fpu-partial-arctangent 0
    fpatan
%endmacro

%macro fpu-compute-2x-minus-1 0
    f2xm1
%endmacro

%macro fpu-compute-y-times-log2-x 0
    fyl2x
%endmacro

%macro fpu-compute-y-times-log2-x-plus-1 0
    fyl2xp1
%endmacro

