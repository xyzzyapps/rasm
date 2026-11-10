; ============================================================================
; SECTION 41: FMA (FUSED MULTIPLY-ADD) INSTRUCTIONS
; ============================================================================
; Intel FMA is three operands. The result register must be one of the
; three inputs. The readable call stays four names:
;   result = left * right + addend
; and the macro picks vfmadd231, vfmadd213, or vfmadd132.

%macro _fma3 6
    %ifidni %3, %6
        v %+ %1 %+ 231 %+ %2 %3, %4, %5
    %elifidni %3, %4
        v %+ %1 %+ 213 %+ %2 %3, %5, %6
    %elifidni %3, %5
        v %+ %1 %+ 132 %+ %2 %3, %6, %4
    %else
        %error FMA result must be the same register as one input
    %endif
%endmacro

%macro fma_add_subtract_packed_double 4
    _fma3 fmaddsub, pd, %1, %2, %3, %4
%endmacro

%macro fma_add_subtract_packed_single 4
    _fma3 fmaddsub, ps, %1, %2, %3, %4
%endmacro

%macro fma_subtract_add_packed_double 4
    _fma3 fmsubadd, pd, %1, %2, %3, %4
%endmacro

%macro fma_subtract_add_packed_single 4
    _fma3 fmsubadd, ps, %1, %2, %3, %4
%endmacro

%macro fma_multiply_add_packed_double 4
    _fma3 fmadd, pd, %1, %2, %3, %4
%endmacro

%macro fma_multiply_add_packed_single 4
    _fma3 fmadd, ps, %1, %2, %3, %4
%endmacro

%macro fma_multiply_add_scalar_double 4
    _fma3 fmadd, sd, %1, %2, %3, %4
%endmacro

%macro fma_multiply_add_scalar_single 4
    _fma3 fmadd, ss, %1, %2, %3, %4
%endmacro

%macro fma_multiply_subtract_packed_double 4
    _fma3 fmsub, pd, %1, %2, %3, %4
%endmacro

%macro fma_multiply_subtract_packed_single 4
    _fma3 fmsub, ps, %1, %2, %3, %4
%endmacro

%macro fma_multiply_subtract_scalar_double 4
    _fma3 fmsub, sd, %1, %2, %3, %4
%endmacro

%macro fma_multiply_subtract_scalar_single 4
    _fma3 fmsub, ss, %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_add_packed_double 4
    _fma3 fnmadd, pd, %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_add_packed_single 4
    _fma3 fnmadd, ps, %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_add_scalar_double 4
    _fma3 fnmadd, sd, %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_add_scalar_single 4
    _fma3 fnmadd, ss, %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_subtract_packed_double 4
    _fma3 fnmsub, pd, %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_subtract_packed_single 4
    _fma3 fnmsub, ps, %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_subtract_scalar_double 4
    _fma3 fnmsub, sd, %1, %2, %3, %4
%endmacro

%macro fma_negative_multiply_subtract_scalar_single 4
    _fma3 fnmsub, ss, %1, %2, %3, %4
%endmacro
