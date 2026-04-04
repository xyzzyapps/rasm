; ============================================================================
; SECTION 47: ADX (MULTI-PRECISION ADD) INSTRUCTIONS
; ============================================================================

%macro adx-add-with-carry-flag 2
    adcx %1, %2
%endmacro

%macro adx-add-with-overflow-flag 2
    adox %1, %2
%endmacro

