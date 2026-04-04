; ============================================================================
; 52-xsave.nasm - XSAVE/XRSTOR State Management
; ============================================================================
; Merged from sections 52 and 58

; --- FXSAVE/FXRSTOR ---
%macro save-x87-mmx-sse-state 1
    fxsave %1
%endmacro

%macro restore-x87-mmx-sse-state 1
    fxrstor %1
%endmacro

; --- XSAVE/XRSTOR ---
%macro save-extended-state 1
    xsave %1
%endmacro

%macro restore-extended-state 1
    xrstor %1
%endmacro

%macro save-extended-state-compacted 1
    xsavec %1
%endmacro

%macro save-extended-state-optimized 1
    xsaveopt %1
%endmacro

%macro restore-extended-state-compacted 1
    xrstors %1
%endmacro

%macro save-extended-state-supervisor 1
    xsaves %1
%endmacro

%macro get-extended-state 2
    xgetbv %1, %2
%endmacro

%macro set-extended-state 2
    xsetbv %1, %2
%endmacro
