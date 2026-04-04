; ============================================================================
; SECTION 19: INTERRUPT INSTRUCTIONS
; ============================================================================

%macro interrupt 1
    int %1
%endmacro

%macro interrupt-3 0
    int3
%endmacro

%macro interrupt-1 0
    int1
%endmacro

%macro interrupt-on-overflow 0
    into
%endmacro

%macro return-from-interrupt 0
    iret
%endmacro

%macro return-from-interrupt-dword 0
    iretd
%endmacro

%macro return-from-interrupt-qword 0
    iretq
%endmacro

