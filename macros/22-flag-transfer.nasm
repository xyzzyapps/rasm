; ============================================================================
; SECTION 22: FLAG TRANSFER
; ============================================================================

%macro load-flags-into-ah 0
    lahf
%endmacro

%macro store-ah-into-flags 0
    sahf
%endmacro

