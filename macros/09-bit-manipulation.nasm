; ============================================================================
; 09-bit-manipulation.nasm - Bit Manipulation Instructions
; ============================================================================

%macro bit-scan-forward 2
    bsf %1, %2
%endmacro

%macro bit-scan-reverse 2
    bsr %1, %2
%endmacro

%macro byte-swap 1
    bswap %1
%endmacro

%macro bit-test 2
    bt %1, %2
%endmacro

%macro bit-test-and-complement 2
    btc %1, %2
%endmacro

%macro bit-test-and-reset 2
    btr %1, %2
%endmacro

%macro bit-test-and-set 2
    bts %1, %2
%endmacro

%macro bit-field-extract 3
    bextr %1, %2, %3
%endmacro

%macro extract-lowest-set-isolated-bit 2
    blsi %1, %2
%endmacro

%macro get-mask-up-to-lowest-set-bit 2
    blsmsk %1, %2
%endmacro

%macro reset-lowest-set-bit 2
    blsr %1, %2
%endmacro

%macro zero-high-bits 2
    bzhi %1, %2
%endmacro

%macro count-leading-zeros 2
    lzcnt %1, %2
%endmacro

%macro count-trailing-zeros 2
    tzcnt %1, %2
%endmacro

%macro population-count 2
    popcnt %1, %2
%endmacro

%macro parallel-bits-deposit 3
    pdep %1, %2, %3
%endmacro

%macro parallel-bits-extract 3
    pext %1, %2, %3
%endmacro
