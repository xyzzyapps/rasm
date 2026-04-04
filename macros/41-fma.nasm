; ============================================================================
; SECTION 41: FMA (FUSED MULTIPLY-ADD) INSTRUCTIONS
; ============================================================================

%macro fma-add-subtract-packed-double 4
    vfmaddsubpd %1, %2, %3, %4
%endmacro

%macro fma-add-subtract-packed-single 4
    vfmaddsubps %1, %2, %3, %4
%endmacro

%macro fma-subtract-add-packed-double 4
    vfmsubaddpd %1, %2, %3, %4
%endmacro

%macro fma-subtract-add-packed-single 4
    vfmsubaddps %1, %2, %3, %4
%endmacro

%macro fma-multiply-add-packed-double 4
    vfmaddpd %1, %2, %3, %4
%endmacro

%macro fma-multiply-add-packed-single 4
    vfmaddps %1, %2, %3, %4
%endmacro

%macro fma-multiply-add-scalar-double 4
    vfmaddsd %1, %2, %3, %4
%endmacro

%macro fma-multiply-add-scalar-single 4
    vfmaddss %1, %2, %3, %4
%endmacro

%macro fma-multiply-subtract-packed-double 4
    vfmsubpd %1, %2, %3, %4
%endmacro

%macro fma-multiply-subtract-packed-single 4
    vfmsubps %1, %2, %3, %4
%endmacro

%macro fma-multiply-subtract-scalar-double 4
    vfmsubsd %1, %2, %3, %4
%endmacro

%macro fma-multiply-subtract-scalar-single 4
    vfmsubss %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-add-packed-double 4
    vfnmaddpd %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-add-packed-single 4
    vfnmaddps %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-add-scalar-double 4
    vfnmaddsd %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-add-scalar-single 4
    vfnmaddss %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-subtract-packed-double 4
    vfnmsubpd %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-subtract-packed-single 4
    vfnmsubps %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-subtract-scalar-double 4
    vfnmsubsd %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-subtract-scalar-single 4
    vfnmsubss %1, %2, %3, %4
%endmacro

