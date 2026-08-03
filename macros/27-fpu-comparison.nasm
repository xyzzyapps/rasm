; ============================================================================
; SECTION 27: X87 FPU - COMPARISON INSTRUCTIONS
; ============================================================================

%macro fpu_compare 0-1
%if %0 = 0
    fcom
%else
    fcom %1
%endif
%endmacro

%macro fpu_compare_and_pop 0-1
%if %0 = 0
    fcomp
%else
    fcomp %1
%endif
%endmacro

%macro fpu_compare_and_pop_twice 0
    fcompp
%endmacro

%macro fpu_compare_and_set_flags 0-1
%if %0 = 0
    fcomi
%else
    fcomi %1
%endif
%endmacro

%macro fpu_compare_set_flags_and_pop 0-1
%if %0 = 0
    fcomip
%else
    fcomip %1
%endif
%endmacro

%macro fpu_unordered_compare 0-1
%if %0 = 0
    fucom
%else
    fucom %1
%endif
%endmacro

%macro fpu_unordered_compare_and_pop 0-1
%if %0 = 0
    fucomp
%else
    fucomp %1
%endif
%endmacro

%macro fpu_unordered_compare_and_pop_twice 0
    fucompp
%endmacro

%macro fpu_unordered_compare_and_set_flags 0-1
%if %0 = 0
    fucomi
%else
    fucomi %1
%endif
%endmacro

%macro fpu_unordered_compare_set_flags_and_pop 0-1
%if %0 = 0
    fucomip
%else
    fucomip %1
%endif
%endmacro

%macro fpu_compare_integer 1
    ficom %1
%endmacro

%macro fpu_compare_integer_and_pop 1
    ficomp %1
%endmacro

%macro fpu_test 0
    ftst
%endmacro

%macro fpu_examine 0
    fxam
%endmacro

