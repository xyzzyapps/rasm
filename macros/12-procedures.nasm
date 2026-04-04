; ============================================================================
; 12-procedures.nasm - Procedure Calls
; ============================================================================

%macro call-procedure 1
    call %1
%endmacro

%macro return-from-procedure 0-1
%if %0 = 1
    ret %1
%else
    ret
%endif
%endmacro

%macro return-far 0-1
%if %0 = 1
    retf %1
%else
    retf
%endif
%endmacro
