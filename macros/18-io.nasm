; ============================================================================
; SECTION 18: I/O OPERATIONS
; ============================================================================

%macro input_from_port 2
    in %1, %2
%endmacro

%macro output_to_port 2
    out %1, %2
%endmacro

%macro input_string_from_port_byte 0
    insb
%endmacro

%macro input_string_from_port_word 0
    insw
%endmacro

%macro input_string_from_port_dword 0
    insd
%endmacro

%macro output_string_to_port_byte 0
    outsb
%endmacro

%macro output_string_to_port_word 0
    outsw
%endmacro

%macro output_string_to_port_dword 0
    outsd
%endmacro

