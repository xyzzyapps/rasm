; ============================================================================
; 06-arithmetic.nasm - Arithmetic Instructions
; ============================================================================

%macro add 2
    add %1, %2
%endmacro

%macro add_with_carry 2
    adc %1, %2
%endmacro

%macro add_with_carry_flag 2
    adcx %1, %2
%endmacro

%macro add_with_overflow_flag 2
    adox %1, %2
%endmacro

%macro subtract 2
    sub %1, %2
%endmacro

%macro subtract_with_borrow 2
    sbb %1, %2
%endmacro

%macro increment 1
    inc %1
%endmacro

%macro decrement 1
    dec %1
%endmacro

%macro multiply 1
    mul %1
%endmacro

%macro signed_multiply 1
    imul %1
%endmacro

%macro signed_multiply_immediate 2
    imul %1, %2
%endmacro

%macro signed_multiply_immediate_3 3
    imul %1, %2, %3
%endmacro

%macro multiply_without_affecting_flags 3
    mulx %1, %2, %3
%endmacro

%macro divide 1
    div %1
%endmacro

%macro signed_divide 1
    idiv %1
%endmacro

%macro negate 1
    neg %1
%endmacro

%macro compare 2
    cmp %1, %2
%endmacro

%macro ascii_adjust_after_add 0
    aaa
%endmacro

%macro ascii_adjust_before_div 0
    aad
%endmacro

%macro ascii_adjust_after_mul 0
    aam
%endmacro

%macro ascii_adjust_after_sub 0
    aas
%endmacro

%macro decimal_adjust_after_add 0
    daa
%endmacro

%macro decimal_adjust_after_sub 0
    das
%endmacro

%macro compute_crc32 2
    crc32 %1, %2
%endmacro
