; ============================================================================
; SECTION 19: INTERRUPT INSTRUCTIONS
; ============================================================================

%macro interrupt 1
    int %1
%endmacro

%macro interrupt_3 0
    int3
%endmacro

%macro interrupt_1 0
    int1
%endmacro

%macro interrupt_on_overflow 0
    into
%endmacro

%macro return_from_interrupt 0
    iret
%endmacro

%macro return_from_interrupt_dword 0
    iretd
%endmacro

%macro return_from_interrupt_qword 0
    iretq
%endmacro

