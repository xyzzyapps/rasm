; ============================================================================
; 06-arithmetic.nasm - Arithmetic Instructions
; ============================================================================
; Naming: `add dst, src`, `subtract dst, src`, etc. (Intel order).
;   increment/decrement take one operand; multiply/divide/signed_* are
;   the implicit-accumulator forms (mul rax).

%macro add 2
    add %1, %2
%endmacro

%macro add_byte 2
    add size_byte %1, %2
%endmacro

%macro add_word 2
    add size_word %1, %2
%endmacro

%macro add_dword 2
    add size_dword %1, %2
%endmacro

%macro add_qword 2
    add size_qword %1, %2
%endmacro

%macro add_with_carry 2
    adc %1, %2
%endmacro

%macro add_with_carry_byte 2
    adc size_byte %1, %2
%endmacro

%macro add_with_carry_word 2
    adc size_word %1, %2
%endmacro

%macro add_with_carry_dword 2
    adc size_dword %1, %2
%endmacro

%macro add_with_carry_qword 2
    adc size_qword %1, %2
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

%macro subtract_byte 2
    sub size_byte %1, %2
%endmacro

%macro subtract_word 2
    sub size_word %1, %2
%endmacro

%macro subtract_dword 2
    sub size_dword %1, %2
%endmacro

%macro subtract_qword 2
    sub size_qword %1, %2
%endmacro

%macro subtract_with_borrow 2
    sbb %1, %2
%endmacro

%macro subtract_with_borrow_byte 2
    sbb size_byte %1, %2
%endmacro

%macro subtract_with_borrow_word 2
    sbb size_word %1, %2
%endmacro

%macro subtract_with_borrow_dword 2
    sbb size_dword %1, %2
%endmacro

%macro subtract_with_borrow_qword 2
    sbb size_qword %1, %2
%endmacro

%macro increment 1
    inc %1
%endmacro

%macro increment_byte 1
    inc size_byte %1
%endmacro

%macro increment_word 1
    inc size_word %1
%endmacro

%macro increment_dword 1
    inc size_dword %1
%endmacro

%macro increment_qword 1
    inc size_qword %1
%endmacro

%macro decrement 1
    dec %1
%endmacro

%macro decrement_byte 1
    dec size_byte %1
%endmacro

%macro decrement_word 1
    dec size_word %1
%endmacro

%macro decrement_dword 1
    dec size_dword %1
%endmacro

%macro decrement_qword 1
    dec size_qword %1
%endmacro

%macro multiply 1
    mul %1
%endmacro

%macro multiply_byte 1
    mul size_byte %1
%endmacro

%macro multiply_word 1
    mul size_word %1
%endmacro

%macro multiply_dword 1
    mul size_dword %1
%endmacro

%macro multiply_qword 1
    mul size_qword %1
%endmacro

%macro signed_multiply 1
    imul %1
%endmacro

%macro signed_multiply_byte 1
    imul size_byte %1
%endmacro

%macro signed_multiply_word 1
    imul size_word %1
%endmacro

%macro signed_multiply_dword 1
    imul size_dword %1
%endmacro

%macro signed_multiply_qword 1
    imul size_qword %1
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

%macro divide_byte 1
    div size_byte %1
%endmacro

%macro divide_word 1
    div size_word %1
%endmacro

%macro divide_dword 1
    div size_dword %1
%endmacro

%macro divide_qword 1
    div size_qword %1
%endmacro

%macro signed_divide 1
    idiv %1
%endmacro

%macro signed_divide_byte 1
    idiv size_byte %1
%endmacro

%macro signed_divide_word 1
    idiv size_word %1
%endmacro

%macro signed_divide_dword 1
    idiv size_dword %1
%endmacro

%macro signed_divide_qword 1
    idiv size_qword %1
%endmacro

%macro negate 1
    neg %1
%endmacro

%macro negate_byte 1
    neg size_byte %1
%endmacro

%macro negate_word 1
    neg size_word %1
%endmacro

%macro negate_dword 1
    neg size_dword %1
%endmacro

%macro negate_qword 1
    neg size_qword %1
%endmacro

%macro compare 2
    cmp %1, %2
%endmacro

%macro compare_byte 2
    cmp size_byte %1, %2
%endmacro

%macro compare_word 2
    cmp size_word %1, %2
%endmacro

%macro compare_dword 2
    cmp size_dword %1, %2
%endmacro

%macro compare_qword 2
    cmp size_qword %1, %2
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
