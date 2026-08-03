; ============================================================================
; 52-xsave.nasm - XSAVE/XRSTOR State Management
; ============================================================================
; Merged from sections 52 and 58

; --- FXSAVE/FXRSTOR ---
%macro save_x87_mmx_sse_state 1
    fxsave %1
%endmacro

%macro restore_x87_mmx_sse_state 1
    fxrstor %1
%endmacro

; --- XSAVE/XRSTOR ---
%macro save_extended_state 1
    xsave %1
%endmacro

%macro restore_extended_state 1
    xrstor %1
%endmacro

%macro save_extended_state_compacted 1
    xsavec %1
%endmacro

%macro save_extended_state_optimized 1
    xsaveopt %1
%endmacro

%macro restore_extended_state_compacted 1
    xrstors %1
%endmacro

%macro save_extended_state_supervisor 1
    xsaves %1
%endmacro

%macro get_extended_state 2
    xgetbv %1, %2
%endmacro

%macro set_extended_state 2
    xsetbv %1, %2
%endmacro
