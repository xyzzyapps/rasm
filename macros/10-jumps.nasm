; ============================================================================
; 10-jumps.nasm - Control Flow Jump Instructions
; ============================================================================
; Naming: jump target, jump_if_equal/jump_if_not_equal,
;   jump_if_greater (jg), jump_if_less_or_equal (jle), jump_if_above (ja), ...
; Unsigned comparisons use above/below; signed use greater/less.

%macro jump 1
    jmp %1
%endmacro

%macro jump_if_equal 1
    je %1
%endmacro

%macro jump_if_zero 1
    jz %1
%endmacro

%macro jump_if_not_equal 1
    jne %1
%endmacro

%macro jump_if_not_zero 1
    jnz %1
%endmacro

%macro jump_if_greater 1
    jg %1
%endmacro

%macro jump_if_greater_or_equal 1
    jge %1
%endmacro

%macro jump_if_less 1
    jl %1
%endmacro

%macro jump_if_less_or_equal 1
    jle %1
%endmacro

%macro jump_if_above 1
    ja %1
%endmacro

%macro jump_if_above_or_equal 1
    jae %1
%endmacro

%macro jump_if_below 1
    jb %1
%endmacro

%macro jump_if_below_or_equal 1
    jbe %1
%endmacro

%macro jump_if_carry 1
    jc %1
%endmacro

%macro jump_if_not_carry 1
    jnc %1
%endmacro

%macro jump_if_overflow 1
    jo %1
%endmacro

%macro jump_if_not_overflow 1
    jno %1
%endmacro

%macro jump_if_sign 1
    js %1
%endmacro

%macro jump_if_not_sign 1
    jns %1
%endmacro

%macro jump_if_parity 1
    jp %1
%endmacro

%macro jump_if_parity_even 1
    jpe %1
%endmacro

%macro jump_if_no_parity 1
    jnp %1
%endmacro

%macro jump_if_parity_odd 1
    jpo %1
%endmacro

%macro jump_if_not_above 1
    jna %1
%endmacro

%macro jump_if_not_above_or_equal 1
    jnae %1
%endmacro

%macro jump_if_not_below 1
    jnb %1
%endmacro

%macro jump_if_not_below_or_equal 1
    jnbe %1
%endmacro

%macro jump_if_not_greater 1
    jng %1
%endmacro

%macro jump_if_not_greater_or_equal 1
    jnge %1
%endmacro

%macro jump_if_not_less 1
    jnl %1
%endmacro

%macro jump_if_not_less_or_equal 1
    jnle %1
%endmacro

%macro jump_if_cx_zero 1
    jcxz %1
%endmacro

%macro jump_if_ecx_zero 1
    jecxz %1
%endmacro

%macro jump_if_rcx_zero 1
    jrcxz %1
%endmacro

%macro end_branch_32 0
    endbr32
%endmacro

%macro end_branch_64 0
    endbr64
%endmacro
