; ============================================================================
; 09-bit-manipulation.nasm - Bit Manipulation Instructions
; ============================================================================

%macro bit_scan_forward 2
    bsf %1, %2
%endmacro

%macro bit_scan_reverse 2
    bsr %1, %2
%endmacro

%macro byte_swap 1
    bswap %1
%endmacro

%macro bit_test 2
    bt %1, %2
%endmacro

%macro bit_test_and_complement 2
    btc %1, %2
%endmacro

%macro bit_test_and_reset 2
    btr %1, %2
%endmacro

%macro bit_test_and_set 2
    bts %1, %2
%endmacro

%macro bit_field_extract 3
    bextr %1, %2, %3
%endmacro

%macro extract_lowest_set_isolated_bit 2
    blsi %1, %2
%endmacro

%macro get_mask_up_to_lowest_set_bit 2
    blsmsk %1, %2
%endmacro

%macro reset_lowest_set_bit 2
    blsr %1, %2
%endmacro

%macro zero_high_bits 2
    bzhi %1, %2
%endmacro

%macro count_leading_zeros 2
    lzcnt %1, %2
%endmacro

%macro count_trailing_zeros 2
    tzcnt %1, %2
%endmacro

%macro population_count 2
    popcnt %1, %2
%endmacro

%macro parallel_bits_deposit 3
    pdep %1, %2, %3
%endmacro

%macro parallel_bits_extract 3
    pext %1, %2, %3
%endmacro
