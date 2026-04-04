; ============================================================================
; 51-sgx.nasm - Software Guard Extensions (SGX)
; ============================================================================
; Merged from sections 51 and 62

%macro sgx-enter-enclave 0
    eenter
%endmacro

%macro sgx-resume-enclave 0
    eresume
%endmacro

%macro sgx-enclave-leaf 1
    enclu %1
%endmacro

%macro sgx-provision-leaf 1
    encls %1
%endmacro
