; ============================================================================
; 12-procedures.nasm - Procedure Calls
; ============================================================================

%macro call_procedure 1
    call %1
%endmacro

%macro return_from_procedure 0-1
%if %0 = 1
    ret %1
%else
    ret
%endif
%endmacro

%macro call_far_procedure 1
    call far %1
%endmacro

%macro jump_far 1
    jmp far %1
%endmacro

%macro return_far 0-1
%if %0 = 1
    retf %1
%else
    retf
%endif
%endmacro
