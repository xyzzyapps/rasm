; ============================================================================
; SECTION 32: SSE2 INSTRUCTIONS
; ============================================================================

%macro sse2_add_packed_double 2
    addpd %1, %2
%endmacro

%macro sse2_add_scalar_double 2
    addsd %1, %2
%endmacro

%macro sse2_add_packed_dword 2
    paddd %1, %2
%endmacro

%macro sse2_add_packed_qword 2
    paddq %1, %2
%endmacro

%macro sse2_add_packed_word 2
    paddw %1, %2
%endmacro

%macro sse2_add_packed_byte 2
    paddb %1, %2
%endmacro

%macro sse2_and_not_packed_double 2
    andnpd %1, %2
%endmacro

%macro sse2_and_packed_double 2
    andpd %1, %2
%endmacro

%macro sse2_compare_packed_double 3
    cmppd %1, %2, %3
%endmacro

%macro sse2_compare_scalar_double 3
    cmpsd %1, %2, %3
%endmacro

%macro sse2_compare_ordered_scalar_double 2
    comisd %1, %2
%endmacro

%macro sse2_divide_packed_double 2
    divpd %1, %2
%endmacro

%macro sse2_divide_scalar_double 2
    divsd %1, %2
%endmacro

%macro sse2_load_aligned_double 2
    movapd %1, %2
%endmacro

%macro sse2_load_unaligned_double 2
    movupd %1, %2
%endmacro

%macro sse2_move_scalar_double 2
    movsd %1, %2
%endmacro

%macro sse2_move_high_packed_double 2
    movhpd %1, %2
%endmacro

%macro sse2_move_low_packed_double 2
    movlpd %1, %2
%endmacro

%macro sse2_move_mask_packed_double 2
    movmskpd %1, %2
%endmacro

%macro sse2_move_aligned_packed_integer 2
    movdqa %1, %2
%endmacro

%macro sse2_move_unaligned_packed_integer 2
    movdqu %1, %2
%endmacro

%macro sse2_move_double_duplicate 2
    movddup %1, %2
%endmacro

%macro sse2_move_high_and_duplicate 2
    movshdup %1, %2
%endmacro

%macro sse2_move_low_and_duplicate 2
    movsldup %1, %2
%endmacro

%macro sse2_maximum_packed_double 2
    maxpd %1, %2
%endmacro

%macro sse2_maximum_scalar_double 2
    maxsd %1, %2
%endmacro

%macro sse2_minimum_packed_double 2
    minpd %1, %2
%endmacro

%macro sse2_minimum_scalar_double 2
    minsd %1, %2
%endmacro

%macro sse2_multiply_packed_double 2
    mulpd %1, %2
%endmacro

%macro sse2_multiply_scalar_double 2
    mulsd %1, %2
%endmacro

%macro sse2_or_packed_double 2
    orpd %1, %2
%endmacro

%macro sse2_pack_with_signed_saturation_dword 2
    packssdw %1, %2
%endmacro

%macro sse2_pack_with_signed_saturation_word 2
    packsswb %1, %2
%endmacro

%macro sse2_pack_with_unsigned_saturation_dword 2
    packusdw %1, %2
%endmacro

%macro sse2_pack_with_unsigned_saturation_word 2
    packuswb %1, %2
%endmacro

%macro sse2_compare_equal_qword 2
    pcmpeqq %1, %2
%endmacro

%macro sse2_compare_greater_than_qword 2
    pcmpgtq %1, %2
%endmacro

%macro sse2_extract_byte 3
    pextrb %1, %2, %3
%endmacro

%macro sse2_extract_dword 3
    pextrd %1, %2, %3
%endmacro

%macro sse2_extract_qword 3
    pextrq %1, %2, %3
%endmacro

%macro sse2_insert_byte 3
    pinsrb %1, %2, %3
%endmacro

%macro sse2_insert_dword 3
    pinsrd %1, %2, %3
%endmacro

%macro sse2_insert_qword 3
    pinsrq %1, %2, %3
%endmacro

%macro sse2_maximum_signed_dword 2
    pmaxsd %1, %2
%endmacro

%macro sse2_maximum_signed_word 2
    pmaxsw %1, %2
%endmacro

%macro sse2_maximum_unsigned_dword 2
    pmaxud %1, %2
%endmacro

%macro sse2_maximum_unsigned_word 2
    pmaxuw %1, %2
%endmacro

%macro sse2_minimum_signed_dword 2
    pminsd %1, %2
%endmacro

%macro sse2_minimum_signed_word 2
    pminsw %1, %2
%endmacro

%macro sse2_minimum_unsigned_dword 2
    pminud %1, %2
%endmacro

%macro sse2_minimum_unsigned_word 2
    pminuw %1, %2
%endmacro

%macro sse2_move_byte_mask_from_packed 2
    pmovmskb %1, %2
%endmacro

%macro sse2_multiply_packed_dword 2
    pmuludq %1, %2
%endmacro

%macro sse2_multiply_low_packed_dword 2
    pmulld %1, %2
%endmacro

%macro sse2_multiply_high_rounded_and_scale 2
    pmulhrsw %1, %2
%endmacro

%macro sse2_multiply_and_add_packed_signed_unsigned_bytes 2
    pmaddubsw %1, %2
%endmacro

%macro sse2_horizontal_add_packed_words 2
    phaddw %1, %2
%endmacro

%macro sse2_horizontal_add_packed_dwords 2
    phaddd %1, %2
%endmacro

%macro sse2_horizontal_add_and_saturate_packed_words 2
    phaddsw %1, %2
%endmacro

%macro sse2_horizontal_subtract_packed_words 2
    phsubw %1, %2
%endmacro

%macro sse2_horizontal_subtract_packed_dwords 2
    phsubd %1, %2
%endmacro

%macro sse2_horizontal_subtract_and_saturate_packed_words 2
    phsubsw %1, %2
%endmacro

%macro sse2_align_right_packed 3
    palignr %1, %2, %3
%endmacro

%macro sse2_absolute_value_packed_bytes 1
    pabsb %1
%endmacro

%macro sse2_absolute_value_packed_words 1
    pabsw %1
%endmacro

%macro sse2_absolute_value_packed_dwords 1
    pabsd %1
%endmacro

%macro sse2_sign_extend_packed_word_to_dword 2
    pmovsxwd %1, %2
%endmacro

%macro sse2_sign_extend_packed_byte_to_word 2
    pmovsxbw %1, %2
%endmacro

%macro sse2_sign_extend_packed_byte_to_dword 2
    pmovsxbd %1, %2
%endmacro

%macro sse2_sign_extend_packed_byte_to_qword 2
    pmovsxbq %1, %2
%endmacro

%macro sse2_sign_extend_packed_word_to_qword 2
    pmovsxwq %1, %2
%endmacro

%macro sse2_sign_extend_packed_dword_to_qword 2
    pmovsxdq %1, %2
%endmacro

%macro sse2_zero_extend_packed_word_to_dword 2
    pmovzxwd %1, %2
%endmacro

%macro sse2_zero_extend_packed_byte_to_word 2
    pmovzxbw %1, %2
%endmacro

%macro sse2_zero_extend_packed_byte_to_dword 2
    pmovzxbd %1, %2
%endmacro

%macro sse2_zero_extend_packed_byte_to_qword 2
    pmovzxbq %1, %2
%endmacro

%macro sse2_zero_extend_packed_word_to_qword 2
    pmovzxwq %1, %2
%endmacro

%macro sse2_zero_extend_packed_dword_to_qword 2
    pmovzxdq %1, %2
%endmacro

%macro sse2_shuffle_packed_double 3
    shufpd %1, %2, %3
%endmacro

%macro sse2_square_root_packed_double 1
    sqrtpd %1
%endmacro

%macro sse2_square_root_scalar_double 1
    sqrtsd %1
%endmacro

%macro sse2_store_non_temporal_dword 2
    movnti %1, %2
%endmacro

%macro sse2_store_non_temporal_double 2
    movntpd %1, %2
%endmacro

%macro sse2_subtract_packed_double 2
    subpd %1, %2
%endmacro

%macro sse2_subtract_scalar_double 2
    subsd %1, %2
%endmacro

%macro sse2_unpack_high_packed_double 2
    unpckhpd %1, %2
%endmacro

%macro sse2_unpack_low_packed_double 2
    unpcklpd %1, %2
%endmacro

%macro sse2_xor_packed_double 2
    xorpd %1, %2
%endmacro

