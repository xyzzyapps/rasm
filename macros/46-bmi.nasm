; ============================================================================
; SECTION 46: BMI1/BMI2 (BIT MANIPULATION) INSTRUCTIONS
; ============================================================================

%macro bmi-and-not 3
    andn %1, %2, %3
%endmacro

%macro bmi-multiply-without-affecting-flags 3
    mulx %1, %2, %3
%endmacro

%macro bmi-parallel-bits-deposit 3
    pdep %1, %2, %3
%endmacro

%macro bmi-parallel-bits-extract 3
    pext %1, %2, %3
%endmacro

%macro bmi-rotate-right-without-affecting-flags 3
    rorx %1, %2, %3
%endmacro

%macro bmi-shift-left 3
    shlx %1, %2, %3
%endmacro

%macro bmi-shift-right-arithmetic 3
    sarx %1, %2, %3
%endmacro

%macro bmi-shift-right-logical 3
    shrx %1, %2, %3
%endmacro

