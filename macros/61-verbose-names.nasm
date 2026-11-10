; =============================================================================
; 61-verbose-names.nasm
; Verbose aliases for size words inside macro names.
; dword -> double_word, qword -> quad_word, tword -> ten_byte,
; oword -> octa_word, yword -> thirty_two_byte, zword -> sixty_four_byte.
; The short names remain valid.
; =============================================================================

%macro move_double_word 2
    move_dword %1, %2
%endmacro

%macro move_quad_word 2
    move_qword %1, %2
%endmacro

%macro move_with_sign_extend_double_word 2
    move_with_sign_extend_dword %1, %2
%endmacro

%macro convert_word_to_double_word 0
    convert_word_to_dword
%endmacro

%macro convert_double_word_to_quad_word 0
    convert_dword_to_qword
%endmacro

%macro convert_word_to_double_word_pair 0
    convert_word_to_dword_pair
%endmacro

%macro convert_double_word_to_quad_word_pair 0
    convert_dword_to_qword_pair
%endmacro

%macro convert_quad_word_to_octa_word_pair 0
    convert_qword_to_oword_pair
%endmacro

%macro move_string_double_word 0
    move_string_dword
%endmacro

%macro move_string_quad_word 0
    move_string_qword
%endmacro

%macro define_double_word 1+
    define_dword %1
%endmacro

%macro define_quad_word 1+
    define_qword %1
%endmacro

%macro define_ten_byte 1+
    define_tword %1
%endmacro

%macro define_octa_word 1+
    define_oword %1
%endmacro

%macro define_thirty_two_byte 1+
    define_yword %1
%endmacro

%macro define_sixty_four_byte 1+
    define_zword %1
%endmacro

%macro reserve_double_word 1
    reserve_dword %1
%endmacro

%macro reserve_quad_word 1
    reserve_qword %1
%endmacro

%macro reserve_ten_byte 1
    reserve_tword %1
%endmacro

%macro reserve_octa_word 1
    reserve_oword %1
%endmacro

%macro reserve_thirty_two_byte 1
    reserve_yword %1
%endmacro

%macro reserve_sixty_four_byte 1
    reserve_zword %1
%endmacro

%macro add_double_word 2
    add_dword %1, %2
%endmacro

%macro add_quad_word 2
    add_qword %1, %2
%endmacro

%macro add_with_carry_double_word 2
    add_with_carry_dword %1, %2
%endmacro

%macro add_with_carry_quad_word 2
    add_with_carry_qword %1, %2
%endmacro

%macro subtract_double_word 2
    subtract_dword %1, %2
%endmacro

%macro subtract_quad_word 2
    subtract_qword %1, %2
%endmacro

%macro subtract_with_borrow_double_word 2
    subtract_with_borrow_dword %1, %2
%endmacro

%macro subtract_with_borrow_quad_word 2
    subtract_with_borrow_qword %1, %2
%endmacro

%macro increment_double_word 1
    increment_dword %1
%endmacro

%macro increment_quad_word 1
    increment_qword %1
%endmacro

%macro decrement_double_word 1
    decrement_dword %1
%endmacro

%macro decrement_quad_word 1
    decrement_qword %1
%endmacro

%macro multiply_double_word 1
    multiply_dword %1
%endmacro

%macro multiply_quad_word 1
    multiply_qword %1
%endmacro

%macro signed_multiply_double_word 1
    signed_multiply_dword %1
%endmacro

%macro signed_multiply_quad_word 1
    signed_multiply_qword %1
%endmacro

%macro divide_double_word 1
    divide_dword %1
%endmacro

%macro divide_quad_word 1
    divide_qword %1
%endmacro

%macro signed_divide_double_word 1
    signed_divide_dword %1
%endmacro

%macro signed_divide_quad_word 1
    signed_divide_qword %1
%endmacro

%macro negate_double_word 1
    negate_dword %1
%endmacro

%macro negate_quad_word 1
    negate_qword %1
%endmacro

%macro compare_double_word 2
    compare_dword %1, %2
%endmacro

%macro compare_quad_word 2
    compare_qword %1, %2
%endmacro

%macro logical_and_double_word 2
    logical_and_dword %1, %2
%endmacro

%macro logical_and_quad_word 2
    logical_and_qword %1, %2
%endmacro

%macro logical_or_double_word 2
    logical_or_dword %1, %2
%endmacro

%macro logical_or_quad_word 2
    logical_or_qword %1, %2
%endmacro

%macro logical_xor_double_word 2
    logical_xor_dword %1, %2
%endmacro

%macro logical_xor_quad_word 2
    logical_xor_qword %1, %2
%endmacro

%macro logical_not_double_word 1
    logical_not_dword %1
%endmacro

%macro logical_not_quad_word 1
    logical_not_qword %1
%endmacro

%macro shift_logical_left_double_word 2
    shift_logical_left_dword %1, %2
%endmacro

%macro shift_logical_left_quad_word 2
    shift_logical_left_qword %1, %2
%endmacro

%macro shift_arithmetic_left_double_word 2
    shift_arithmetic_left_dword %1, %2
%endmacro

%macro shift_arithmetic_left_quad_word 2
    shift_arithmetic_left_qword %1, %2
%endmacro

%macro shift_logical_right_double_word 2
    shift_logical_right_dword %1, %2
%endmacro

%macro shift_logical_right_quad_word 2
    shift_logical_right_qword %1, %2
%endmacro

%macro shift_arithmetic_right_double_word 2
    shift_arithmetic_right_dword %1, %2
%endmacro

%macro shift_arithmetic_right_quad_word 2
    shift_arithmetic_right_qword %1, %2
%endmacro

%macro rotate_left_double_word 2
    rotate_left_dword %1, %2
%endmacro

%macro rotate_left_quad_word 2
    rotate_left_qword %1, %2
%endmacro

%macro rotate_right_double_word 2
    rotate_right_dword %1, %2
%endmacro

%macro rotate_right_quad_word 2
    rotate_right_qword %1, %2
%endmacro

%macro rotate_left_through_carry_double_word 2
    rotate_left_through_carry_dword %1, %2
%endmacro

%macro rotate_left_through_carry_quad_word 2
    rotate_left_through_carry_qword %1, %2
%endmacro

%macro rotate_right_through_carry_double_word 2
    rotate_right_through_carry_dword %1, %2
%endmacro

%macro rotate_right_through_carry_quad_word 2
    rotate_right_through_carry_qword %1, %2
%endmacro

%macro push_flags_double_word 0
    push_flags_dword
%endmacro

%macro push_flags_quad_word 0
    push_flags_qword
%endmacro

%macro pop_flags_double_word 0
    pop_flags_dword
%endmacro

%macro pop_flags_quad_word 0
    pop_flags_qword
%endmacro

%macro compare_string_double_word 0
    compare_string_dword
%endmacro

%macro compare_string_quad_word 0
    compare_string_qword
%endmacro

%macro scan_string_double_word 0
    scan_string_dword
%endmacro

%macro scan_string_quad_word 0
    scan_string_qword
%endmacro

%macro load_string_double_word 0
    load_string_dword
%endmacro

%macro load_string_quad_word 0
    load_string_qword
%endmacro

%macro store_string_double_word 0
    store_string_dword
%endmacro

%macro store_string_quad_word 0
    store_string_qword
%endmacro

%macro input_string_from_port_double_word 0
    input_string_from_port_dword
%endmacro

%macro output_string_to_port_double_word 0
    output_string_to_port_dword
%endmacro

%macro return_from_interrupt_double_word 0
    return_from_interrupt_dword
%endmacro

%macro return_from_interrupt_quad_word 0
    return_from_interrupt_qword
%endmacro

%macro mmx_pack_with_signed_saturation_double_word_to_word 2
    mmx_pack_with_signed_saturation_dword_to_word %1, %2
%endmacro

%macro mmx_compare_equal_double_words 2
    mmx_compare_equal_dwords %1, %2
%endmacro

%macro mmx_compare_greater_than_double_words 2
    mmx_compare_greater_than_dwords %1, %2
%endmacro

%macro mmx_shift_left_double_words 2
    mmx_shift_left_dwords %1, %2
%endmacro

%macro mmx_shift_right_arithmetic_double_words 2
    mmx_shift_right_arithmetic_dwords %1, %2
%endmacro

%macro mmx_shift_right_logical_double_words 2
    mmx_shift_right_logical_dwords %1, %2
%endmacro

%macro mmx_subtract_double_words 2
    mmx_subtract_dwords %1, %2
%endmacro

%macro mmx_unpack_high_double_words 2
    mmx_unpack_high_dwords %1, %2
%endmacro

%macro mmx_unpack_low_double_words 2
    mmx_unpack_low_dwords %1, %2
%endmacro

%macro sse2_add_packed_double_word 2
    sse2_add_packed_dword %1, %2
%endmacro

%macro sse2_add_packed_quad_word 2
    sse2_add_packed_qword %1, %2
%endmacro

%macro sse2_pack_with_signed_saturation_double_word 2
    sse2_pack_with_signed_saturation_dword %1, %2
%endmacro

%macro sse2_pack_with_unsigned_saturation_double_word 2
    sse2_pack_with_unsigned_saturation_dword %1, %2
%endmacro

%macro sse2_compare_equal_quad_word 2
    sse2_compare_equal_qword %1, %2
%endmacro

%macro sse2_compare_greater_than_quad_word 2
    sse2_compare_greater_than_qword %1, %2
%endmacro

%macro sse2_extract_double_word 3
    sse2_extract_dword %1, %2, %3
%endmacro

%macro sse2_extract_quad_word 3
    sse2_extract_qword %1, %2, %3
%endmacro

%macro sse2_insert_double_word 3
    sse2_insert_dword %1, %2, %3
%endmacro

%macro sse2_insert_quad_word 3
    sse2_insert_qword %1, %2, %3
%endmacro

%macro sse2_maximum_signed_double_word 2
    sse2_maximum_signed_dword %1, %2
%endmacro

%macro sse2_maximum_unsigned_double_word 2
    sse2_maximum_unsigned_dword %1, %2
%endmacro

%macro sse2_minimum_signed_double_word 2
    sse2_minimum_signed_dword %1, %2
%endmacro

%macro sse2_minimum_unsigned_double_word 2
    sse2_minimum_unsigned_dword %1, %2
%endmacro

%macro sse2_multiply_packed_double_word 2
    sse2_multiply_packed_dword %1, %2
%endmacro

%macro sse2_multiply_low_packed_double_word 2
    sse2_multiply_low_packed_dword %1, %2
%endmacro

%macro sse2_horizontal_add_packed_double_words 2
    sse2_horizontal_add_packed_dwords %1, %2
%endmacro

%macro sse2_horizontal_subtract_packed_double_words 2
    sse2_horizontal_subtract_packed_dwords %1, %2
%endmacro

%macro sse2_absolute_value_packed_double_words 1
    sse2_absolute_value_packed_dwords %1
%endmacro

%macro sse2_sign_extend_packed_word_to_double_word 2
    sse2_sign_extend_packed_word_to_dword %1, %2
%endmacro

%macro sse2_sign_extend_packed_byte_to_double_word 2
    sse2_sign_extend_packed_byte_to_dword %1, %2
%endmacro

%macro sse2_sign_extend_packed_byte_to_quad_word 2
    sse2_sign_extend_packed_byte_to_qword %1, %2
%endmacro

%macro sse2_sign_extend_packed_word_to_quad_word 2
    sse2_sign_extend_packed_word_to_qword %1, %2
%endmacro

%macro sse2_sign_extend_packed_double_word_to_quad_word 2
    sse2_sign_extend_packed_dword_to_qword %1, %2
%endmacro

%macro sse2_zero_extend_packed_word_to_double_word 2
    sse2_zero_extend_packed_word_to_dword %1, %2
%endmacro

%macro sse2_zero_extend_packed_byte_to_double_word 2
    sse2_zero_extend_packed_byte_to_dword %1, %2
%endmacro

%macro sse2_zero_extend_packed_byte_to_quad_word 2
    sse2_zero_extend_packed_byte_to_qword %1, %2
%endmacro

%macro sse2_zero_extend_packed_word_to_quad_word 2
    sse2_zero_extend_packed_word_to_qword %1, %2
%endmacro

%macro sse2_zero_extend_packed_double_word_to_quad_word 2
    sse2_zero_extend_packed_dword_to_qword %1, %2
%endmacro

%macro sse2_store_non_temporal_double_word 2
    sse2_store_non_temporal_dword %1, %2
%endmacro

%macro sse2_shuffle_packed_double_words 3
    sse2_shuffle_packed_dwords %1, %2, %3
%endmacro

%macro sse2_unpack_high_double_words 2
    sse2_unpack_high_dwords %1, %2
%endmacro

%macro sse2_unpack_low_double_words 2
    sse2_unpack_low_dwords %1, %2
%endmacro

%macro sse2_convert_packed_double_words_to_packed_doubles 2
    sse2_convert_packed_dwords_to_packed_doubles %1, %2
%endmacro

%macro sse2_convert_packed_double_words_to_packed_singles 2
    sse2_convert_packed_dwords_to_packed_singles %1, %2
%endmacro

%macro sse2_convert_packed_doubles_to_packed_double_words 2
    sse2_convert_packed_doubles_to_packed_dwords %1, %2
%endmacro

%macro sse2_convert_packed_singles_to_packed_double_words 2
    sse2_convert_packed_singles_to_packed_dwords %1, %2
%endmacro

%macro sse2_convert_packed_doubles_to_packed_double_words_truncate 2
    sse2_convert_packed_doubles_to_packed_dwords_truncate %1, %2
%endmacro

%macro sse2_convert_packed_singles_to_packed_double_words_truncate 2
    sse2_convert_packed_singles_to_packed_dwords_truncate %1, %2
%endmacro

%macro ssse3_sign_packed_double_words 2
    ssse3_sign_packed_dwords %1, %2
%endmacro

%macro sse41_mask_move_packed_double_word 3
    sse41_mask_move_packed_dword %1, %2, %3
%endmacro

%macro sse41_pack_with_unsigned_saturation_double_word 2
    sse41_pack_with_unsigned_saturation_dword %1, %2
%endmacro

%macro sse41_multiply_packed_double_words 2
    sse41_multiply_packed_dwords %1, %2
%endmacro

%macro avx2_gather_double_word_single 5
    avx2_gather_dword_single %1, %2, %3, %4, %5
%endmacro

%macro avx2_gather_quad_word_single 5
    avx2_gather_qword_single %1, %2, %3, %4, %5
%endmacro

%macro avx2_gather_double_word_double 5
    avx2_gather_dword_double %1, %2, %3, %4, %5
%endmacro

%macro avx2_gather_quad_word_double 5
    avx2_gather_qword_double %1, %2, %3, %4, %5
%endmacro

%macro avx2_mask_load_double_word 3
    avx2_mask_load_dword %1, %2, %3
%endmacro

%macro avx2_mask_load_quad_word 3
    avx2_mask_load_qword %1, %2, %3
%endmacro

%macro avx2_mask_store_double_word 3
    avx2_mask_store_dword %1, %2, %3
%endmacro

%macro avx2_mask_store_quad_word 3
    avx2_mask_store_qword %1, %2, %3
%endmacro

%macro avx2_permute_variable_double_word 3
    avx2_permute_variable_dword %1, %2, %3
%endmacro

%macro avx2_permute_variable_quad_word 3
    avx2_permute_variable_qword %1, %2, %3
%endmacro

%macro avx2_shift_left_variable_double_word 3
    avx2_shift_left_variable_dword %1, %2, %3
%endmacro

%macro avx2_shift_left_variable_quad_word 3
    avx2_shift_left_variable_qword %1, %2, %3
%endmacro

%macro avx2_shift_right_arithmetic_variable_double_word 3
    avx2_shift_right_arithmetic_variable_dword %1, %2, %3
%endmacro

%macro avx2_shift_right_logical_variable_double_word 3
    avx2_shift_right_logical_variable_dword %1, %2, %3
%endmacro

%macro avx2_shift_right_logical_variable_quad_word 3
    avx2_shift_right_logical_variable_qword %1, %2, %3
%endmacro

%macro avx512_mask_add_double_word 3
    avx512_mask_add_dword %1, %2, %3
%endmacro

%macro avx512_mask_add_quad_word 3
    avx512_mask_add_qword %1, %2, %3
%endmacro

%macro avx512_mask_and_double_word 3
    avx512_mask_and_dword %1, %2, %3
%endmacro

%macro avx512_mask_and_quad_word 3
    avx512_mask_and_qword %1, %2, %3
%endmacro

%macro avx512_mask_and_not_double_word 3
    avx512_mask_and_not_dword %1, %2, %3
%endmacro

%macro avx512_mask_and_not_quad_word 3
    avx512_mask_and_not_qword %1, %2, %3
%endmacro

%macro avx512_mask_move_double_word 2
    avx512_mask_move_dword %1, %2
%endmacro

%macro avx512_mask_move_quad_word 2
    avx512_mask_move_qword %1, %2
%endmacro

%macro avx512_mask_not_double_word 2
    avx512_mask_not_dword %1, %2
%endmacro

%macro avx512_mask_not_quad_word 2
    avx512_mask_not_qword %1, %2
%endmacro

%macro avx512_mask_or_double_word 3
    avx512_mask_or_dword %1, %2, %3
%endmacro

%macro avx512_mask_or_quad_word 3
    avx512_mask_or_qword %1, %2, %3
%endmacro

%macro avx512_mask_or_test_double_word 2
    avx512_mask_or_test_dword %1, %2
%endmacro

%macro avx512_mask_or_test_quad_word 2
    avx512_mask_or_test_qword %1, %2
%endmacro

%macro avx512_mask_shift_left_double_word 3
    avx512_mask_shift_left_dword %1, %2, %3
%endmacro

%macro avx512_mask_shift_left_quad_word 3
    avx512_mask_shift_left_qword %1, %2, %3
%endmacro

%macro avx512_mask_shift_right_double_word 3
    avx512_mask_shift_right_dword %1, %2, %3
%endmacro

%macro avx512_mask_shift_right_quad_word 3
    avx512_mask_shift_right_qword %1, %2, %3
%endmacro

%macro avx512_mask_test_double_word 2
    avx512_mask_test_dword %1, %2
%endmacro

%macro avx512_mask_test_quad_word 2
    avx512_mask_test_qword %1, %2
%endmacro

%macro avx512_mask_unpack_word_double_word 3
    avx512_mask_unpack_word_dword %1, %2, %3
%endmacro

%macro avx512_mask_unpack_double_word_quad_word 3
    avx512_mask_unpack_dword_qword %1, %2, %3
%endmacro

%macro avx512_mask_xnor_double_word 3
    avx512_mask_xnor_dword %1, %2, %3
%endmacro

%macro avx512_mask_xnor_quad_word 3
    avx512_mask_xnor_qword %1, %2, %3
%endmacro

%macro avx512_mask_xor_double_word 3
    avx512_mask_xor_dword %1, %2, %3
%endmacro

%macro avx512_mask_xor_quad_word 3
    avx512_mask_xor_qword %1, %2, %3
%endmacro

%macro avx512_move_aligned_double_word 2
    avx512_move_aligned_dword %1, %2
%endmacro

%macro avx512_move_aligned_quad_word 2
    avx512_move_aligned_qword %1, %2
%endmacro

%macro avx512_move_unaligned_double_word 2
    avx512_move_unaligned_dword %1, %2
%endmacro

%macro avx512_move_unaligned_quad_word 2
    avx512_move_unaligned_qword %1, %2
%endmacro

%macro avx512_ternary_logic_double_word 4
    avx512_ternary_logic_dword %1, %2, %3, %4
%endmacro

%macro avx512_ternary_logic_quad_word 4
    avx512_ternary_logic_qword %1, %2, %3, %4
%endmacro

%macro avx512_scatter_double_word_single 5
    avx512_scatter_dword_single %1, %2, %3, %4, %5
%endmacro

%macro avx512_scatter_quad_word_single 5
    avx512_scatter_qword_single %1, %2, %3, %4, %5
%endmacro

%macro avx512_scatter_double_word_double 5
    avx512_scatter_dword_double %1, %2, %3, %4, %5
%endmacro

%macro avx512_scatter_quad_word_double 5
    avx512_scatter_qword_double %1, %2, %3, %4, %5
%endmacro

%macro avx512_abs_packed_double_word 2
    avx512_abs_packed_dword %1, %2
%endmacro

%macro avx512_abs_packed_quad_word 2
    avx512_abs_packed_qword %1, %2
%endmacro

%macro avx512_add_packed_double_word 3
    avx512_add_packed_dword %1, %2, %3
%endmacro

%macro avx512_add_packed_quad_word 3
    avx512_add_packed_qword %1, %2, %3
%endmacro

%macro avx512_compare_equal_double_word 4
    avx512_compare_equal_dword %1, %2, %3, %4
%endmacro

%macro avx512_compare_equal_quad_word 4
    avx512_compare_equal_qword %1, %2, %3, %4
%endmacro

%macro avx512_compare_greater_than_double_word 4
    avx512_compare_greater_than_dword %1, %2, %3, %4
%endmacro

%macro avx512_compare_greater_than_quad_word 4
    avx512_compare_greater_than_qword %1, %2, %3, %4
%endmacro

%macro struct_double_word 1-2
%if %0 = 0
    struct_dword
%elif %0 = 1
    struct_dword %1
%else
    struct_dword %1, %2
%endif
%endmacro

%macro struct_quad_word 1-2
%if %0 = 0
    struct_qword
%elif %0 = 1
    struct_qword %1
%else
    struct_qword %1, %2
%endif
%endmacro

%macro increment_shadow_stack_pointer_double_word 0
    increment_shadow_stack_pointer_dword
%endmacro

%macro increment_shadow_stack_pointer_quad_word 0
    increment_shadow_stack_pointer_qword
%endmacro

%macro write_shadow_stack_double_word 2
    write_shadow_stack_dword %1, %2
%endmacro

%macro write_shadow_stack_quad_word 2
    write_shadow_stack_qword %1, %2
%endmacro

%macro write_user_shadow_stack_double_word 2
    write_user_shadow_stack_dword %1, %2
%endmacro

%macro write_user_shadow_stack_quad_word 2
    write_user_shadow_stack_qword %1, %2
%endmacro

%macro read_shadow_stack_pointer_double_word 1
    read_shadow_stack_pointer_dword %1
%endmacro

%macro read_shadow_stack_pointer_quad_word 1
    read_shadow_stack_pointer_qword %1
%endmacro

