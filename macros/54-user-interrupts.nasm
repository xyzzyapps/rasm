; ============================================================================
; SECTION 54: USER INTERRUPT INSTRUCTIONS
; ============================================================================

%macro send-user-interrupt 2
    senduipi %1, %2
%endmacro

%macro user-interrupt-return 0
    uiret
%endmacro

%macro set-user-interrupt-request 1
    stui %1
%endmacro

%macro clear-user-interrupt-request 0
    clui
%endmacro

