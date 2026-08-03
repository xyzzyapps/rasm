; ============================================================================
; SECTION 41: FMA (FUSED MULTIPLY-ADD) INSTRUCTIONS
; ============================================================================

%macro fma_add_subtract_packed_double 4
    vfmaddsubpd %1, %2, %3, %4
%endmacro

%macro fma_add_subtract_packed_single 4
    vfmaddsubps %1, %2, %3, %4
%endmacro

%macro fma_subtract_add_packed_double 4
    vfmsubaddpd %1, %2, %3, %4
%endmacro

%macro fma_subtract_add_packed_single 4
    vfmsubaddps %1, %2, %3, %4
%endmacro

%macro fma_multiply_add_packed_double 4
    vfmaddpd %1, %2, %3, %4
%endmacro

%macro fma_multiply_add_packed_single 4
    vfmaddps %1, %2, %3, %4
%endmacro

%macro fma_multiply_add_scalar_double 4
    vfmaddsd %1, %2, %3, %4
%endmacro

%macro fma_multiply_add_scalar_single 4
    vfmaddss %1, %2, %3, %4
%endmacro

%macro fma_multiply_subtract_packed_double 4
    vfmsubpd %1, %2, %3, %4
%endmacro

%macro fma_multiply_subtract_packed_single 4
    vfmsubps %1, %2, %3, %4
%endmacro

%macro fma_multiply_subtract_scalar_double 4
    vfmsubsd %1, %2, %3, %4
%endmacro

%macro fma_multiply_subtract_scalar_single 4
    vfmsubss %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_add_packed_double 4
    vfnmaddpd %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_add_packed_single 4
    vfnmaddps %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_add_scalar_double 4
    vfnmaddsd %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_add_scalar_single 4
    vfnmaddss %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_subtract_packed_double 4
    vfnmsubpd %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_subtract_packed_single 4
    vfnmsubps %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_subtract_scalar_double 4
    vfnmsubsd %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_subtract_scalar_single 4
    vfnmsubss %1, %2, %3, %4
%endmacro

