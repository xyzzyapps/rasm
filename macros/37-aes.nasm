; ============================================================================
; SECTION 37: AES INSTRUCTIONS
; ============================================================================

%macro aes-encrypt-round 2
    aesenc %1, %2
%endmacro

%macro aes-encrypt-last-round 2
    aesenclast %1, %2
%endmacro

%macro aes-decrypt-round 2
    aesdec %1, %2
%endmacro

%macro aes-decrypt-last-round 2
    aesdeclast %1, %2
%endmacro

%macro aes-inverse-mix-column 2
    aesimc %1, %2
%endmacro

%macro aes-key-generation-assist 3
    aeskeygenassist %1, %2, %3
%endmacro

%macro aes-encrypt-128-key-locker 2
    aesenc128kl %1, %2
%endmacro

%macro aes-encrypt-256-key-locker 2
    aesenc256kl %1, %2
%endmacro

%macro aes-decrypt-128-key-locker 2
    aesdec128kl %1, %2
%endmacro

%macro aes-decrypt-256-key-locker 2
    aesdec256kl %1, %2
%endmacro

%macro aes-encrypt-wide-128-key-locker 2
    aesencwide128kl %1, %2
%endmacro

%macro aes-encrypt-wide-256-key-locker 2
    aesencwide256kl %1, %2
%endmacro

%macro aes-decrypt-wide-128-key-locker 2
    aesdecwide128kl %1, %2
%endmacro

%macro aes-decrypt-wide-256-key-locker 2
    aesdecwide256kl %1, %2
%endmacro

%macro encode-key-128 1
    encodekey128 %1
%endmacro

%macro encode-key-256 1
    encodekey256 %1
%endmacro

%macro load-internal-wrapping-key 1
    loadiwkey %1
%endmacro

