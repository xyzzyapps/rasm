; ============================================================================
; SECTION 47: ADX (MULTI-PRECISION ADD) INSTRUCTIONS
; ============================================================================

%macro adx_add_with_carry_flag 2
    adcx %1, %2
%endmacro

%macro adx_add_with_overflow_flag 2
    adox %1, %2
%endmacro

