; ============================================================================
; SECTION 45: MPX (MEMORY PROTECTION EXTENSIONS) INSTRUCTIONS
; ============================================================================

%macro mpx_make_bounds 2
    bndmk %1, %2
%endmacro

%macro mpx_check_lower_bound 2
    bndcl %1, %2
%endmacro

%macro mpx_check_upper_bound 2
    bndcu %1, %2
%endmacro

%macro mpx_check_upper_bound_cn 2
    bndcn %1, %2
%endmacro

%macro mpx_move_bounds 2
    bndmov %1, %2
%endmacro

%macro mpx_load_extended_bounds 2
    bndldx %1, %2
%endmacro

%macro mpx_store_extended_bounds 2
    bndstx %1, %2
%endmacro

