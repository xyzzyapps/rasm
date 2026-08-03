; ============================================================================
; SECTION 16: STRING OPERATIONS
; ============================================================================

%macro compare_string 0
    cmps
%endmacro

%macro compare_string_byte 0
    cmpsb
%endmacro

%macro compare_string_word 0
    cmpsw
%endmacro

%macro compare_string_dword 0
    cmpsd
%endmacro

%macro compare_string_qword 0
    cmpsq
%endmacro

%macro scan_string 0
    scas
%endmacro

%macro scan_string_byte 0
    scasb
%endmacro

%macro scan_string_word 0
    scasw
%endmacro

%macro scan_string_dword 0
    scasd
%endmacro

%macro scan_string_qword 0
    scasq
%endmacro

%macro load_string 0
    lods
%endmacro

%macro load_string_byte 0
    lodsb
%endmacro

%macro load_string_word 0
    lodsw
%endmacro

%macro load_string_dword 0
    lodsd
%endmacro

%macro load_string_qword 0
    lodsq
%endmacro

%macro store_string 0
    stos
%endmacro

%macro store_string_byte 0
    stosb
%endmacro

%macro store_string_word 0
    stosw
%endmacro

%macro store_string_dword 0
    stosd
%endmacro

%macro store_string_qword 0
    stosq
%endmacro

