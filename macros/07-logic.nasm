; ============================================================================
; 07-logic.nasm - Logic Instructions
; ============================================================================
; Naming: logical_and / logical_or / logical_xor / logical_not,
;   plus logical_and_not (andn). All take Intel operand order.

%macro logical_and 2
    and %1, %2
%endmacro

%macro logical_and_byte 2
    and size_byte %1, %2
%endmacro

%macro logical_and_word 2
    and size_word %1, %2
%endmacro

%macro logical_and_dword 2
    and size_dword %1, %2
%endmacro

%macro logical_and_qword 2
    and size_qword %1, %2
%endmacro

%macro logical_and_not 2
    andn %1, %2
%endmacro

%macro logical_or 2
    or %1, %2
%endmacro

%macro logical_or_byte 2
    or size_byte %1, %2
%endmacro

%macro logical_or_word 2
    or size_word %1, %2
%endmacro

%macro logical_or_dword 2
    or size_dword %1, %2
%endmacro

%macro logical_or_qword 2
    or size_qword %1, %2
%endmacro

%macro logical_xor 2
    xor %1, %2
%endmacro

%macro logical_xor_byte 2
    xor size_byte %1, %2
%endmacro

%macro logical_xor_word 2
    xor size_word %1, %2
%endmacro

%macro logical_xor_dword 2
    xor size_dword %1, %2
%endmacro

%macro logical_xor_qword 2
    xor size_qword %1, %2
%endmacro

%macro logical_not 1
    not %1
%endmacro

%macro logical_not_byte 1
    not size_byte %1
%endmacro

%macro logical_not_word 1
    not size_word %1
%endmacro

%macro logical_not_dword 1
    not size_dword %1
%endmacro

%macro logical_not_qword 1
    not size_qword %1
%endmacro

%macro test 2
    test %1, %2
%endmacro
