; ============================================================================
; SECTION 30: MMX INSTRUCTIONS
; ============================================================================

%macro mmx_empty_state 0
    emms
%endmacro

%macro mmx_move_doubleword 2
    movd %1, %2
%endmacro

%macro mmx_move_quadword 2
    movq %1, %2
%endmacro

%macro mmx_pack_with_signed_saturation_word_to_byte 2
    packsswb %1, %2
%endmacro

%macro mmx_pack_with_signed_saturation_dword_to_word 2
    packssdw %1, %2
%endmacro

%macro mmx_pack_with_unsigned_saturation_word_to_byte 2
    packuswb %1, %2
%endmacro

%macro mmx_compare_equal_bytes 2
    pcmpeqb %1, %2
%endmacro

%macro mmx_compare_equal_words 2
    pcmpeqw %1, %2
%endmacro

%macro mmx_compare_equal_dwords 2
    pcmpeqd %1, %2
%endmacro

%macro mmx_compare_greater_than_bytes 2
    pcmpgtb %1, %2
%endmacro

%macro mmx_compare_greater_than_words 2
    pcmpgtw %1, %2
%endmacro

%macro mmx_compare_greater_than_dwords 2
    pcmpgtd %1, %2
%endmacro

%macro mmx_move_byte_mask 2
    pmovmskb %1, %2
%endmacro

%macro mmx_add_bytes_with_saturation 2
    paddsb %1, %2
%endmacro

%macro mmx_add_words_with_saturation 2
    paddsw %1, %2
%endmacro

%macro mmx_add_bytes_with_unsigned_saturation 2
    paddusb %1, %2
%endmacro

%macro mmx_add_words_with_unsigned_saturation 2
    paddusw %1, %2
%endmacro

%macro mmx_average_bytes 2
    pavgb %1, %2
%endmacro

%macro mmx_average_words 2
    pavgw %1, %2
%endmacro

%macro mmx_multiply_and_add_words 2
    pmaddwd %1, %2
%endmacro

%macro mmx_maximum_signed_bytes 2
    pmaxsb %1, %2
%endmacro

%macro mmx_maximum_signed_words 2
    pmaxsw %1, %2
%endmacro

%macro mmx_maximum_unsigned_bytes 2
    pmaxub %1, %2
%endmacro

%macro mmx_maximum_unsigned_words 2
    pmaxuw %1, %2
%endmacro

%macro mmx_minimum_signed_bytes 2
    pminsb %1, %2
%endmacro

%macro mmx_minimum_signed_words 2
    pminsw %1, %2
%endmacro

%macro mmx_minimum_unsigned_bytes 2
    pminub %1, %2
%endmacro

%macro mmx_minimum_unsigned_words 2
    pminuw %1, %2
%endmacro

%macro mmx_multiply_high_signed_words 2
    pmulhw %1, %2
%endmacro

%macro mmx_multiply_high_unsigned_words 2
    pmulhuw %1, %2
%endmacro

%macro mmx_multiply_low_words 2
    pmullw %1, %2
%endmacro

%macro mmx_shift_left_words 2
    psllw %1, %2
%endmacro

%macro mmx_shift_left_dwords 2
    pslld %1, %2
%endmacro

%macro mmx_shift_left_quadwords 2
    psllq %1, %2
%endmacro

%macro mmx_shift_right_arithmetic_words 2
    psraw %1, %2
%endmacro

%macro mmx_shift_right_arithmetic_dwords 2
    psrad %1, %2
%endmacro

%macro mmx_shift_right_logical_words 2
    psrlw %1, %2
%endmacro

%macro mmx_shift_right_logical_dwords 2
    psrld %1, %2
%endmacro

%macro mmx_shift_right_logical_quadwords 2
    psrlq %1, %2
%endmacro

%macro mmx_subtract_bytes_with_saturation 2
    psubsb %1, %2
%endmacro

%macro mmx_subtract_words_with_saturation 2
    psubsw %1, %2
%endmacro

%macro mmx_subtract_bytes_with_unsigned_saturation 2
    psubusb %1, %2
%endmacro

%macro mmx_subtract_words_with_unsigned_saturation 2
    psubusw %1, %2
%endmacro

%macro mmx_extract_word 3
    pextrw %1, %2, %3
%endmacro

%macro mmx_insert_word 3
    pinsrw %1, %2, %3
%endmacro

%macro mmx_mask_move_quadword 3
    maskmovq %1, %2, %3
%endmacro

%macro mmx_move_quadword_non_temporal 2
    movntq %1, %2
%endmacro

%macro mmx_move_from_xmm_to_mmx 2
    movdq2q %1, %2
%endmacro

%macro mmx_move_from_mmx_to_xmm 2
    movq2dq %1, %2
%endmacro

