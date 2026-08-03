; ============================================================================
; SECTION 26: X87 FPU - TRANSCENDENTAL INSTRUCTIONS
; ============================================================================

%macro fpu_sine 0
    fsin
%endmacro

%macro fpu_cosine 0
    fcos
%endmacro

%macro fpu_sine_and_cosine 0
    fsincos
%endmacro

%macro fpu_partial_tangent 0
    fptan
%endmacro

%macro fpu_partial_arctangent 0
    fpatan
%endmacro

%macro fpu_compute_2x_minus_1 0
    f2xm1
%endmacro

%macro fpu_compute_y_times_log2_x 0
    fyl2x
%endmacro

%macro fpu_compute_y_times_log2_x_plus_1 0
    fyl2xp1
%endmacro

