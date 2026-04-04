; ============================================================================
; SECTION 16: STRING OPERATIONS
; ============================================================================

%macro compare-string 0
    cmps
%endmacro

%macro compare-string-byte 0
    cmpsb
%endmacro

%macro compare-string-word 0
    cmpsw
%endmacro

%macro compare-string-dword 0
    cmpsd
%endmacro

%macro compare-string-qword 0
    cmpsq
%endmacro

%macro scan-string 0
    scas
%endmacro

%macro scan-string-byte 0
    scasb
%endmacro

%macro scan-string-word 0
    scasw
%endmacro

%macro scan-string-dword 0
    scasd
%endmacro

%macro scan-string-qword 0
    scasq
%endmacro

%macro load-string 0
    lods
%endmacro

%macro load-string-byte 0
    lodsb
%endmacro

%macro load-string-word 0
    lodsw
%endmacro

%macro load-string-dword 0
    lodsd
%endmacro

%macro load-string-qword 0
    lodsq
%endmacro

%macro store-string 0
    stos
%endmacro

%macro store-string-byte 0
    stosb
%endmacro

%macro store-string-word 0
    stosw
%endmacro

%macro store-string-dword 0
    stosd
%endmacro

%macro store-string-qword 0
    stosq
%endmacro

