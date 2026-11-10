; ============================================================================
; SECTION 22: FLAG TRANSFER
; ============================================================================

%macro load_flags_into_ah 0
    lahf
%endmacro

%macro store_ah_into_flags 0
    sahf
%endmacro

%macro load_flags_into_accumulator_8_high 0
    lahf
%endmacro

%macro store_accumulator_8_high_into_flags 0
    sahf
%endmacro

