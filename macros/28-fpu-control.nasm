; ============================================================================
; 28-fpu-control.nasm - FPU Control Instructions
; ============================================================================
; Merged from sections 28 and 48

%macro fpu-load-control-word 1
    fldcw %1
%endmacro

%macro fpu-store-control-word 1
    fstcw %1
%endmacro

%macro fpu-store-control-word-no-wait 1
    fnstcw %1
%endmacro

%macro fpu-load-environment 1
    fldenv %1
%endmacro

%macro fpu-store-environment 1
    fstenv %1
%endmacro

%macro fpu-store-environment-no-wait 1
    fnstenv %1
%endmacro

%macro fpu-store-status-word 1
    fstsw %1
%endmacro

%macro fpu-store-status-word-no-wait 1
    fnstsw %1
%endmacro

%macro fpu-store-status-word-to-ax 0
    fstsw ax
%endmacro

%macro fpu-store-status-word-to-ax-no-wait 0
    fnstsw ax
%endmacro

%macro fpu-save-state 1
    fsave %1
%endmacro

%macro fpu-save-state-no-wait 1
    fnsave %1
%endmacro

%macro fpu-restore-state 1
    frstor %1
%endmacro

%macro fpu-initialize 0
    finit
%endmacro

%macro fpu-initialize-no-wait 0
    fninit
%endmacro

%macro fpu-clear-exceptions 0
    fclex
%endmacro

%macro fpu-clear-exceptions-no-wait 0
    fnclex
%endmacro

%macro fpu-wait 0
    fwait
%endmacro

%macro fpu-no-operation 0
    fnop
%endmacro

%macro fpu-free-register 0-1
%if %0 = 1
    ffree %1
%else
    ffree
%endif
%endmacro

%macro fpu-decrement-stack-pointer 0
    fdecstp
%endmacro

%macro fpu-increment-stack-pointer 0
    fincstp
%endmacro

%macro fpu-extract-exponent-and-significand 0
    fxtract
%endmacro

%macro fpu-load-mxcsr 1
    ldmxcsr %1
%endmacro

%macro fpu-store-mxcsr 1
    stmxcsr %1
%endmacro

%macro mmx-empty 0
    emms
%endmacro
