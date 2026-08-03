; ============================================================================
; SECTION 37: AES INSTRUCTIONS
; ============================================================================

%macro aes_encrypt_round 2
    aesenc %1, %2
%endmacro

%macro aes_encrypt_last_round 2
    aesenclast %1, %2
%endmacro

%macro aes_decrypt_round 2
    aesdec %1, %2
%endmacro

%macro aes_decrypt_last_round 2
    aesdeclast %1, %2
%endmacro

%macro aes_inverse_mix_column 2
    aesimc %1, %2
%endmacro

%macro aes_key_generation_assist 3
    aeskeygenassist %1, %2, %3
%endmacro

%macro aes_encrypt_128_key_locker 2
    aesenc128kl %1, %2
%endmacro

%macro aes_encrypt_256_key_locker 2
    aesenc256kl %1, %2
%endmacro

%macro aes_decrypt_128_key_locker 2
    aesdec128kl %1, %2
%endmacro

%macro aes_decrypt_256_key_locker 2
    aesdec256kl %1, %2
%endmacro

%macro aes_encrypt_wide_128_key_locker 2
    aesencwide128kl %1, %2
%endmacro

%macro aes_encrypt_wide_256_key_locker 2
    aesencwide256kl %1, %2
%endmacro

%macro aes_decrypt_wide_128_key_locker 2
    aesdecwide128kl %1, %2
%endmacro

%macro aes_decrypt_wide_256_key_locker 2
    aesdecwide256kl %1, %2
%endmacro

%macro encode_key_128 1
    encodekey128 %1
%endmacro

%macro encode_key_256 1
    encodekey256 %1
%endmacro

%macro load_internal_wrapping_key 1
    loadiwkey %1
%endmacro

