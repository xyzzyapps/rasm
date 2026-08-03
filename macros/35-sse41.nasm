; ============================================================================
; SECTION 35: SSE4.1 INSTRUCTIONS
; ============================================================================

%macro sse41_blend_packed_bytes 3
    pblendvb %1, %2, %3
%endmacro

%macro sse41_blend_packed_words 3
    pblendw %1, %2, %3
%endmacro

%macro sse41_blend_packed_double 3
    blendpd %1, %2, %3
%endmacro

%macro sse41_blend_packed_single 3
    blendps %1, %2, %3
%endmacro

%macro sse41_dot_product_packed_double 3
    dppd %1, %2, %3
%endmacro

%macro sse41_dot_product_packed_single 3
    dpps %1, %2, %3
%endmacro

%macro sse41_extract_packed_single 3
    extractps %1, %2, %3
%endmacro

%macro sse41_insert_packed_single 4
    insertps %1, %2, %3, %4
%endmacro

%macro sse41_mask_move_packed_dword 3
    maskmovdqu %1, %2, %3
%endmacro

%macro sse41_pack_with_unsigned_saturation_dword 2
    packusdw %1, %2
%endmacro

%macro sse41_test_packed 2
    ptest %1, %2
%endmacro

%macro sse41_round_scalar_double 3
    roundsd %1, %2, %3
%endmacro

%macro sse41_round_scalar_single 3
    roundss %1, %2, %3
%endmacro

%macro sse41_round_packed_double 3
    roundpd %1, %2, %3
%endmacro

%macro sse41_round_packed_single 3
    roundps %1, %2, %3
%endmacro

%macro sse41_compare_implicit_length_string_return_index 3
    pcmpistri %1, %2, %3
%endmacro

%macro sse41_compare_implicit_length_string_return_mask 3
    pcmpistrm %1, %2, %3
%endmacro

%macro sse41_compare_explicit_length_string_return_index 3
    pcmpestri %1, %2, %3
%endmacro

%macro sse41_compare_explicit_length_string_return_mask 3
    pcmpestrm %1, %2, %3
%endmacro

