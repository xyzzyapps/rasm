; ============================================================================
; 10-jumps.nasm - Control Flow Jump Instructions
; ============================================================================

%macro jump 1
    jmp %1
%endmacro

%macro jump-if-equal 1
    je %1
%endmacro

%macro jump-if-zero 1
    jz %1
%endmacro

%macro jump-if-not-equal 1
    jne %1
%endmacro

%macro jump-if-not-zero 1
    jnz %1
%endmacro

%macro jump-if-greater 1
    jg %1
%endmacro

%macro jump-if-greater-or-equal 1
    jge %1
%endmacro

%macro jump-if-less 1
    jl %1
%endmacro

%macro jump-if-less-or-equal 1
    jle %1
%endmacro

%macro jump-if-above 1
    ja %1
%endmacro

%macro jump-if-above-or-equal 1
    jae %1
%endmacro

%macro jump-if-below 1
    jb %1
%endmacro

%macro jump-if-below-or-equal 1
    jbe %1
%endmacro

%macro jump-if-carry 1
    jc %1
%endmacro

%macro jump-if-not-carry 1
    jnc %1
%endmacro

%macro jump-if-overflow 1
    jo %1
%endmacro

%macro jump-if-not-overflow 1
    jno %1
%endmacro

%macro jump-if-sign 1
    js %1
%endmacro

%macro jump-if-not-sign 1
    jns %1
%endmacro

%macro jump-if-parity 1
    jp %1
%endmacro

%macro jump-if-parity-even 1
    jpe %1
%endmacro

%macro jump-if-no-parity 1
    jnp %1
%endmacro

%macro jump-if-parity-odd 1
    jpo %1
%endmacro

%macro jump-if-not-above 1
    jna %1
%endmacro

%macro jump-if-not-above-or-equal 1
    jnae %1
%endmacro

%macro jump-if-not-below 1
    jnb %1
%endmacro

%macro jump-if-not-below-or-equal 1
    jnbe %1
%endmacro

%macro jump-if-not-greater 1
    jng %1
%endmacro

%macro jump-if-not-greater-or-equal 1
    jnge %1
%endmacro

%macro jump-if-not-less 1
    jnl %1
%endmacro

%macro jump-if-not-less-or-equal 1
    jnle %1
%endmacro

%macro jump-if-cx-zero 1
    jcxz %1
%endmacro

%macro jump-if-ecx-zero 1
    jecxz %1
%endmacro

%macro jump-if-rcx-zero 1
    jrcxz %1
%endmacro

%macro end-branch-32 0
    endbr32
%endmacro

%macro end-branch-64 0
    endbr64
%endmacro
