; ============================================================================
; 13-stack.nasm - Stack Operations
; ============================================================================

%macro push 1
    push %1
%endmacro

%macro push_onto_stack 1
    push %1
%endmacro

%macro pop 1
    pop %1
%endmacro

%macro pop_from_stack 1
    pop %1
%endmacro

%macro push_all 0
    pusha
%endmacro

%macro pop_all 0
    popa
%endmacro

%macro push_flags 0
    pushf
%endmacro

%macro push_flags_word 0
    pushfw
%endmacro

%macro push_flags_dword 0
    pushfd
%endmacro

%macro push_flags_qword 0
    pushfq
%endmacro

%macro pop_flags 0
    popf
%endmacro

%macro pop_flags_word 0
    popfw
%endmacro

%macro pop_flags_dword 0
    popfd
%endmacro

%macro pop_flags_qword 0
    popfq
%endmacro

%macro enter_stack_frame 2
    enter %1, %2
%endmacro

%macro leave_stack_frame 0
    leave
%endmacro
