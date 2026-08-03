; ============================================================================
; SECTION 31: SSE INSTRUCTIONS
; ============================================================================

%macro sse_add_packed_single 2
    addps %1, %2
%endmacro

%macro sse_add_scalar_single 2
    addss %1, %2
%endmacro

%macro sse_and_packed_single 2
    andps %1, %2
%endmacro

%macro sse_and_not_packed_single 2
    andnps %1, %2
%endmacro

%macro sse_compare_packed_single 3
    cmpps %1, %2, %3
%endmacro

%macro sse_compare_scalar_single 3
    cmpss %1, %2, %3
%endmacro

%macro sse_compare_ordered_scalar_single 2
    comiss %1, %2
%endmacro

%macro sse_divide_packed_single 2
    divps %1, %2
%endmacro

%macro sse_divide_scalar_single 2
    divss %1, %2
%endmacro

%macro sse_load_unaligned_single 2
    movups %1, %2
%endmacro

%macro sse_load_aligned_single 2
    movaps %1, %2
%endmacro

%macro sse_move_scalar_single 2
    movss %1, %2
%endmacro

%macro sse_move_high_to_low 2
    movhlps %1, %2
%endmacro

%macro sse_move_low_to_high 2
    movlhps %1, %2
%endmacro

%macro sse_move_high_packed_single 2
    movhps %1, %2
%endmacro

%macro sse_move_low_packed_single 2
    movlps %1, %2
%endmacro

%macro sse_move_mask_packed_single 2
    movmskps %1, %2
%endmacro

%macro sse_move_non_temporal_single 2
    movntps %1, %2
%endmacro

%macro sse_maximum_packed_single 2
    maxps %1, %2
%endmacro

%macro sse_maximum_scalar_single 2
    maxss %1, %2
%endmacro

%macro sse_minimum_packed_single 2
    minps %1, %2
%endmacro

%macro sse_minimum_scalar_single 2
    minss %1, %2
%endmacro

%macro sse_multiply_packed_single 2
    mulps %1, %2
%endmacro

%macro sse_multiply_scalar_single 2
    mulss %1, %2
%endmacro

%macro sse_or_packed_single 2
    orps %1, %2
%endmacro

%macro sse_reciprocal_packed_single 1
    rcpps %1
%endmacro

%macro sse_reciprocal_scalar_single 1
    rcpss %1
%endmacro

%macro sse_reciprocal_square_root_packed_single 1
    rsqrtps %1
%endmacro

%macro sse_reciprocal_square_root_scalar_single 1
    rsqrtss %1
%endmacro

%macro sse_shuffle_packed_single 3
    shufps %1, %2, %3
%endmacro

%macro sse_square_root_packed_single 1
    sqrtps %1
%endmacro

%macro sse_square_root_scalar_single 1
    sqrtss %1
%endmacro

%macro sse_subtract_packed_single 2
    subps %1, %2
%endmacro

%macro sse_subtract_scalar_single 2
    subss %1, %2
%endmacro

%macro sse_unpack_high_packed_single 2
    unpckhps %1, %2
%endmacro

%macro sse_unpack_low_packed_single 2
    unpcklps %1, %2
%endmacro

%macro sse_xor_packed_single 2
    xorps %1, %2
%endmacro

