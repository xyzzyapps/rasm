; ============================================================================
; 14-flag-control.nasm - Flag Control Instructions
; ============================================================================

%macro clear_carry_flag 0
    clc
%endmacro

%macro set_carry_flag 0
    stc
%endmacro

%macro complement_carry_flag 0
    cmc
%endmacro

%macro clear_direction_flag 0
    cld
%endmacro

%macro set_direction_flag 0
    std
%endmacro

%macro clear_interrupt_flag 0
    cli
%endmacro

%macro set_interrupt_flag 0
    sti
%endmacro

%macro clear_ac_flag 0
    clac
%endmacro

%macro set_ac_flag 0
    stac
%endmacro

%macro clear_task_switched_flag 0
    clts
%endmacro

%macro clear_user_interrupt_flag 0
    clui
%endmacro
