; ============================================================================
; SECTION 18: I/O OPERATIONS
; ============================================================================

%macro input-from-port 2
    in %1, %2
%endmacro

%macro output-to-port 2
    out %1, %2
%endmacro

%macro input-string-from-port-byte 0
    insb
%endmacro

%macro input-string-from-port-word 0
    insw
%endmacro

%macro input-string-from-port-dword 0
    insd
%endmacro

%macro output-string-to-port-byte 0
    outsb
%endmacro

%macro output-string-to-port-word 0
    outsw
%endmacro

%macro output-string-to-port-dword 0
    outsd
%endmacro

