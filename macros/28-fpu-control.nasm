; ============================================================================
; 28-fpu-control.nasm - FPU Control Instructions
; ============================================================================
; Merged from sections 28 and 48

%macro fpu_load_control_word 1
    fldcw %1
%endmacro

%macro fpu_store_control_word 1
    fstcw %1
%endmacro

%macro fpu_store_control_word_no_wait 1
    fnstcw %1
%endmacro

%macro fpu_load_environment 1
    fldenv %1
%endmacro

%macro fpu_store_environment 1
    fstenv %1
%endmacro

%macro fpu_store_environment_no_wait 1
    fnstenv %1
%endmacro

%macro fpu_store_status_word 1
    fstsw %1
%endmacro

%macro fpu_store_status_word_no_wait 1
    fnstsw %1
%endmacro

%macro fpu_store_status_word_to_ax 0
    fstsw ax
%endmacro

%macro fpu_store_status_word_to_ax_no_wait 0
    fnstsw ax
%endmacro

%macro fpu_save_state 1
    fsave %1
%endmacro

%macro fpu_save_state_no_wait 1
    fnsave %1
%endmacro

%macro fpu_restore_state 1
    frstor %1
%endmacro

%macro fpu_initialize 0
    finit
%endmacro

%macro fpu_initialize_no_wait 0
    fninit
%endmacro

%macro fpu_clear_exceptions 0
    fclex
%endmacro

%macro fpu_clear_exceptions_no_wait 0
    fnclex
%endmacro

%macro fpu_wait 0
    fwait
%endmacro

%macro fpu_no_operation 0
    fnop
%endmacro

%macro fpu_free_register 0-1
%if %0 = 1
    ffree %1
%else
    ffree
%endif
%endmacro

%macro fpu_decrement_stack_pointer 0
    fdecstp
%endmacro

%macro fpu_increment_stack_pointer 0
    fincstp
%endmacro

%macro fpu_extract_exponent_and_significand 0
    fxtract
%endmacro

%macro fpu_load_mxcsr 1
    ldmxcsr %1
%endmacro

%macro fpu_store_mxcsr 1
    stmxcsr %1
%endmacro

%macro mmx_empty 0
    emms
%endmacro
