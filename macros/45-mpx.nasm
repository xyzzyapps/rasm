; ============================================================================
; SECTION 45: MPX (MEMORY PROTECTION EXTENSIONS) INSTRUCTIONS
; ============================================================================

%macro mpx-make-bounds 2
    bndmk %1, %2
%endmacro

%macro mpx-check-lower-bound 2
    bndcl %1, %2
%endmacro

%macro mpx-check-upper-bound 2
    bndcu %1, %2
%endmacro

%macro mpx-check-upper-bound-cn 2
    bndcn %1, %2
%endmacro

%macro mpx-move-bounds 2
    bndmov %1, %2
%endmacro

%macro mpx-load-extended-bounds 2
    bndldx %1, %2
%endmacro

%macro mpx-store-extended-bounds 2
    bndstx %1, %2
%endmacro

