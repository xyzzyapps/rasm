; ============================================================================
; SECTION 27: X87 FPU - COMPARISON INSTRUCTIONS
; ============================================================================

%macro fpu-compare 0-1
%if %0 = 0
    fcom
%else
    fcom %1
%endif
%endmacro

%macro fpu-compare-and-pop 0-1
%if %0 = 0
    fcomp
%else
    fcomp %1
%endif
%endmacro

%macro fpu-compare-and-pop-twice 0
    fcompp
%endmacro

%macro fpu-compare-and-set-flags 0-1
%if %0 = 0
    fcomi
%else
    fcomi %1
%endif
%endmacro

%macro fpu-compare-set-flags-and-pop 0-1
%if %0 = 0
    fcomip
%else
    fcomip %1
%endif
%endmacro

%macro fpu-unordered-compare 0-1
%if %0 = 0
    fucom
%else
    fucom %1
%endif
%endmacro

%macro fpu-unordered-compare-and-pop 0-1
%if %0 = 0
    fucomp
%else
    fucomp %1
%endif
%endmacro

%macro fpu-unordered-compare-and-pop-twice 0
    fucompp
%endmacro

%macro fpu-unordered-compare-and-set-flags 0-1
%if %0 = 0
    fucomi
%else
    fucomi %1
%endif
%endmacro

%macro fpu-unordered-compare-set-flags-and-pop 0-1
%if %0 = 0
    fucomip
%else
    fucomip %1
%endif
%endmacro

%macro fpu-compare-integer 1
    ficom %1
%endmacro

%macro fpu-compare-integer-and-pop 1
    ficomp %1
%endmacro

%macro fpu-test 0
    ftst
%endmacro

%macro fpu-examine 0
    fxam
%endmacro

