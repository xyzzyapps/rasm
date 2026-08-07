; ============================================================================
; 48-structs.nasm - C-like structs and nested structs
; ============================================================================
; Defines preprocessor macros for C-style structs so field offsets are
; computed automatically - no manual offset arithmetic.
;
; Usage:
;   begin_struct point
;       struct_dword field_x
;       struct_dword field_y
;   end_struct                          ; point.field_x = 0, point.field_y = 4,
;                                       ; point_size = 8
;
;   begin_struct rect
;       struct_nested field_topleft,     point
;       struct_nested field_bottomright, point
;       struct_byte   field_name, 32
;   end_struct                          ; rect.field_topleft = 0,
;                                       ; rect.field_bottomright = 8,
;                                       ; rect.field_name = 16, rect_size = 40
;
; Instantiate in data (like C: `rect my_rect;`):
;   section .bss
;       rect_storage: reserve_byte rect_size
;
; Access fields by name - no manual offsets:
;   move accumulator_32, [base + rect.field_bottomright + point.field_y]
;   move accumulator_32, [base + rect.field_name]
;
; Field macros (all take the field name, optionally a count):
;   struct_byte   name [, count]    ; 1 byte each
;   struct_word   name [, count]    ; 2 bytes each
;   struct_dword  name [, count]    ; 4 bytes each
;   struct_qword  name [, count]    ; 8 bytes each
;   struct_field  name, size        ; raw size in bytes
;   struct_nested name, struct_type ; embeds another struct (type must be
;                                   ; defined before this one)
;
; Implementation: mirrors NASM's built-in struc/endstruc. The struct is laid
; out in an [absolute 0] section so every field label is a plain constant
; offset, and end_struct publishes Type_size. Zero runtime overhead - structs
; emit no instructions and no data.
; ============================================================================

%macro begin_struct 1
    %push struct
    %define %$structname %1
    [absolute 0]
    %$structname:
%endmacro

%macro end_struct 0
    %ifnctx struct
        %error "end_struct without matching begin_struct"
    %endif
    %{$structname}_size equ ($ - %$structname)
    %pop struct
    [warning push]
    [warning -other]
    __?SECT?__
    [warning pop]
%endmacro

%macro struct_field 2
    ; struct_field <name>, <size>
    .%1: resb %2
%endmacro

%macro struct_byte 1-2 1
    struct_field %1, byte_size * %2
%endmacro

%macro struct_word 1-2 1
    struct_field %1, word_size * %2
%endmacro

%macro struct_dword 1-2 1
    struct_field %1, dword_size * %2
%endmacro

%macro struct_qword 1-2 1
    struct_field %1, qword_size * %2
%endmacro

%macro struct_nested 2
    ; struct_nested <name>, <struct_type>
    struct_field %1, %2_size
%endmacro
