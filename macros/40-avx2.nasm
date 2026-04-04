; ============================================================================
; SECTION 40: AVX2 INSTRUCTIONS
; ============================================================================

%macro avx2-gather-dword-single 5
    vgatherdps %1, %2, %3, %4, %5
%endmacro

%macro avx2-gather-qword-single 5
    vgatherqps %1, %2, %3, %4, %5
%endmacro

%macro avx2-gather-dword-double 5
    vgatherdpd %1, %2, %3, %4, %5
%endmacro

%macro avx2-gather-qword-double 5
    vgatherqpd %1, %2, %3, %4, %5
%endmacro

%macro avx2-permute-2x128 4
    vperm2i128 %1, %2, %3, %4
%endmacro

%macro avx2-broadcast-i128 2
    vbroadcasti128 %1, %2
%endmacro

%macro avx2-extract-i128 3
    vextracti128 %1, %2, %3
%endmacro

%macro avx2-insert-i128 4
    vinserti128 %1, %2, %3, %4
%endmacro

%macro avx2-mask-load-dword 3
    vpmaskmovd %1, %2, %3
%endmacro

%macro avx2-mask-load-qword 3
    vpmaskmovq %1, %2, %3
%endmacro

%macro avx2-mask-store-dword 3
    vpmaskmovd %1, %2, %3
%endmacro

%macro avx2-mask-store-qword 3
    vpmaskmovq %1, %2, %3
%endmacro

%macro avx2-permute-variable-dword 3
    vpermd %1, %2, %3
%endmacro

%macro avx2-permute-variable-qword 3
    vpermq %1, %2, %3
%endmacro

%macro avx2-shift-left-variable-dword 3
    vpsllvd %1, %2, %3
%endmacro

%macro avx2-shift-left-variable-qword 3
    vpsllvq %1, %2, %3
%endmacro

%macro avx2-shift-right-arithmetic-variable-dword 3
    vpsravd %1, %2, %3
%endmacro

%macro avx2-shift-right-logical-variable-dword 3
    vpsrlvd %1, %2, %3
%endmacro

%macro avx2-shift-right-logical-variable-qword 3
    vpsrlvq %1, %2, %3
%endmacro

