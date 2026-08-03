; ============================================================================
; SECTION 40: AVX2 INSTRUCTIONS
; ============================================================================

%macro avx2_gather_dword_single 5
    vgatherdps %1, %2, %3, %4, %5
%endmacro

%macro avx2_gather_qword_single 5
    vgatherqps %1, %2, %3, %4, %5
%endmacro

%macro avx2_gather_dword_double 5
    vgatherdpd %1, %2, %3, %4, %5
%endmacro

%macro avx2_gather_qword_double 5
    vgatherqpd %1, %2, %3, %4, %5
%endmacro

%macro avx2_permute_2x128 4
    vperm2i128 %1, %2, %3, %4
%endmacro

%macro avx2_broadcast_i128 2
    vbroadcasti128 %1, %2
%endmacro

%macro avx2_extract_i128 3
    vextracti128 %1, %2, %3
%endmacro

%macro avx2_insert_i128 4
    vinserti128 %1, %2, %3, %4
%endmacro

%macro avx2_mask_load_dword 3
    vpmaskmovd %1, %2, %3
%endmacro

%macro avx2_mask_load_qword 3
    vpmaskmovq %1, %2, %3
%endmacro

%macro avx2_mask_store_dword 3
    vpmaskmovd %1, %2, %3
%endmacro

%macro avx2_mask_store_qword 3
    vpmaskmovq %1, %2, %3
%endmacro

%macro avx2_permute_variable_dword 3
    vpermd %1, %2, %3
%endmacro

%macro avx2_permute_variable_qword 3
    vpermq %1, %2, %3
%endmacro

%macro avx2_shift_left_variable_dword 3
    vpsllvd %1, %2, %3
%endmacro

%macro avx2_shift_left_variable_qword 3
    vpsllvq %1, %2, %3
%endmacro

%macro avx2_shift_right_arithmetic_variable_dword 3
    vpsravd %1, %2, %3
%endmacro

%macro avx2_shift_right_logical_variable_dword 3
    vpsrlvd %1, %2, %3
%endmacro

%macro avx2_shift_right_logical_variable_qword 3
    vpsrlvq %1, %2, %3
%endmacro

