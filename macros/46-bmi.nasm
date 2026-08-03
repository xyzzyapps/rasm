; ============================================================================
; SECTION 46: BMI1/BMI2 (BIT MANIPULATION) INSTRUCTIONS
; ============================================================================

%macro bmi_and_not 3
    andn %1, %2, %3
%endmacro

%macro bmi_multiply_without_affecting_flags 3
    mulx %1, %2, %3
%endmacro

%macro bmi_parallel_bits_deposit 3
    pdep %1, %2, %3
%endmacro

%macro bmi_parallel_bits_extract 3
    pext %1, %2, %3
%endmacro

%macro bmi_rotate_right_without_affecting_flags 3
    rorx %1, %2, %3
%endmacro

%macro bmi_shift_left 3
    shlx %1, %2, %3
%endmacro

%macro bmi_shift_right_arithmetic 3
    sarx %1, %2, %3
%endmacro

%macro bmi_shift_right_logical 3
    shrx %1, %2, %3
%endmacro

