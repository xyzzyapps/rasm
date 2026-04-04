; ============================================================================
; 53-tsx.nasm - Transactional Synchronization Extensions (TSX)
; ============================================================================
; Merged from sections 53 and 59

%macro transactional-suspend 0
    xsuspend
%endmacro

%macro transaction-begin 1
    xbegin %1
%endmacro

%macro transaction-end 0
    xend
%endmacro

%macro transaction-abort 1
    xabort %1
%endmacro

%macro restricted-transaction-begin 1
    xbegin %1
%endmacro

%macro restricted-transaction-end 0
    xend
%endmacro
