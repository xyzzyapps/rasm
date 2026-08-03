; ============================================================================
; 53-tsx.nasm - Transactional Synchronization Extensions (TSX)
; ============================================================================
; Merged from sections 53 and 59

%macro transactional_suspend 0
    xsuspend
%endmacro

%macro transaction_begin 1
    xbegin %1
%endmacro

%macro transaction_end 0
    xend
%endmacro

%macro transaction_abort 1
    xabort %1
%endmacro

%macro restricted_transaction_begin 1
    xbegin %1
%endmacro

%macro restricted_transaction_end 0
    xend
%endmacro
