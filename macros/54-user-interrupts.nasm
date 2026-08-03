; ============================================================================
; SECTION 54: USER INTERRUPT INSTRUCTIONS
; ============================================================================

%macro send_user_interrupt 2
    senduipi %1, %2
%endmacro

%macro user_interrupt_return 0
    uiret
%endmacro

%macro set_user_interrupt_request 1
    stui %1
%endmacro

%macro clear_user_interrupt_request 0
    clui
%endmacro

