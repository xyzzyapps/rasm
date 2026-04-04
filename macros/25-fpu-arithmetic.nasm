; ============================================================================
; SECTION 25: X87 FPU - ARITHMETIC INSTRUCTIONS
; ============================================================================

%macro fpu-add 0-2
%if %0 = 0
    fadd
%elif %0 = 1
    fadd %1
%else
    fadd %1, %2
%endif
%endmacro

%macro fpu-add-and-pop 0-2
%if %0 = 0
    faddp
%elif %0 = 1
    faddp %1
%else
    faddp %1, %2
%endif
%endmacro

%macro fpu-add-integer 1
    fiadd %1
%endmacro

%macro fpu-subtract 0-2
%if %0 = 0
    fsub
%elif %0 = 1
    fsub %1
%else
    fsub %1, %2
%endif
%endmacro

%macro fpu-subtract-and-pop 0-2
%if %0 = 0
    fsubp
%elif %0 = 1
    fsubp %1
%else
    fsubp %1, %2
%endif
%endmacro

%macro fpu-subtract-integer 1
    fisub %1
%endmacro

%macro fpu-reverse-subtract 0-2
%if %0 = 0
    fsubr
%elif %0 = 1
    fsubr %1
%else
    fsubr %1, %2
%endif
%endmacro

%macro fpu-reverse-subtract-and-pop 0-2
%if %0 = 0
    fsubrp
%elif %0 = 1
    fsubrp %1
%else
    fsubrp %1, %2
%endif
%endmacro

%macro fpu-reverse-subtract-integer 1
    fisubr %1
%endmacro

%macro fpu-multiply 0-2
%if %0 = 0
    fmul
%elif %0 = 1
    fmul %1
%else
    fmul %1, %2
%endif
%endmacro

%macro fpu-multiply-and-pop 0-2
%if %0 = 0
    fmulp
%elif %0 = 1
    fmulp %1
%else
    fmulp %1, %2
%endif
%endmacro

%macro fpu-multiply-integer 1
    fimul %1
%endmacro

%macro fpu-divide 0-2
%if %0 = 0
    fdiv
%elif %0 = 1
    fdiv %1
%else
    fdiv %1, %2
%endif
%endmacro

%macro fpu-divide-and-pop 0-2
%if %0 = 0
    fdivp
%elif %0 = 1
    fdivp %1
%else
    fdivp %1, %2
%endif
%endmacro

%macro fpu-divide-integer 1
    fidiv %1
%endmacro

%macro fpu-reverse-divide 0-2
%if %0 = 0
    fdivr
%elif %0 = 1
    fdivr %1
%else
    fdivr %1, %2
%endif
%endmacro

%macro fpu-reverse-divide-and-pop 0-2
%if %0 = 0
    fdivrp
%elif %0 = 1
    fdivrp %1
%else
    fdivrp %1, %2
%endif
%endmacro

%macro fpu-reverse-divide-integer 1
    fidivr %1
%endmacro

%macro fpu-absolute-value 0
    fabs
%endmacro

%macro fpu-change-sign 0
    fchs
%endmacro

%macro fpu-square-root 0
    fsqrt
%endmacro

%macro fpu-scale 0
    fscale
%endmacro

%macro fpu-partial-remainder 0
    fprem
%endmacro

%macro fpu-partial-remainder-ieee 0
    fprem1
%endmacro

%macro fpu-round-to-integer 0
    frndint
%endmacro

