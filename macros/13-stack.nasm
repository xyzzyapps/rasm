; ============================================================================
; 13-stack.nasm - Stack Operations
; ============================================================================

%macro push 1
    push %1
%endmacro

%macro pop 1
    pop %1
%endmacro

%macro push-all 0
    pusha
%endmacro

%macro pop-all 0
    popa
%endmacro

%macro push-flags 0
    pushf
%endmacro

%macro push-flags-word 0
    pushfw
%endmacro

%macro push-flags-dword 0
    pushfd
%endmacro

%macro push-flags-qword 0
    pushfq
%endmacro

%macro pop-flags 0
    popf
%endmacro

%macro pop-flags-word 0
    popfw
%endmacro

%macro pop-flags-dword 0
    popfd
%endmacro

%macro pop-flags-qword 0
    popfq
%endmacro

%macro enter-stack-frame 2
    enter %1, %2
%endmacro

%macro leave-stack-frame 0
    leave
%endmacro
