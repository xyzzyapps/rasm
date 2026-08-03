; ============================================================================
; 51-sgx.nasm - Software Guard Extensions (SGX)
; ============================================================================
; Merged from sections 51 and 62

%macro sgx_enter_enclave 0
    eenter
%endmacro

%macro sgx_resume_enclave 0
    eresume
%endmacro

%macro sgx_enclave_leaf 1
    enclu %1
%endmacro

%macro sgx_provision_leaf 1
    encls %1
%endmacro
