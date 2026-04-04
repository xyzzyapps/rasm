; ============================================================================
; 14-flag-control.nasm - Flag Control Instructions
; ============================================================================

%macro clear-carry-flag 0
    clc
%endmacro

%macro set-carry-flag 0
    stc
%endmacro

%macro complement-carry-flag 0
    cmc
%endmacro

%macro clear-direction-flag 0
    cld
%endmacro

%macro set-direction-flag 0
    std
%endmacro

%macro clear-interrupt-flag 0
    cli
%endmacro

%macro set-interrupt-flag 0
    sti
%endmacro

%macro clear-ac-flag 0
    clac
%endmacro

%macro set-ac-flag 0
    stac
%endmacro

%macro clear-task-switched-flag 0
    clts
%endmacro

%macro clear-user-interrupt-flag 0
    clui
%endmacro
