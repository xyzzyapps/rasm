; ============================================================================
; 06-arithmetic.nasm - Arithmetic Instructions
; ============================================================================

%macro add 2
    add %1, %2
%endmacro

%macro add-with-carry 2
    adc %1, %2
%endmacro

%macro add-with-carry-flag 2
    adcx %1, %2
%endmacro

%macro add-with-overflow-flag 2
    adox %1, %2
%endmacro

%macro subtract 2
    sub %1, %2
%endmacro

%macro subtract-with-borrow 2
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

%macro signed-multiply 1
    imul %1
%endmacro

%macro signed-multiply-immediate 2
    imul %1, %2
%endmacro

%macro signed-multiply-immediate-3 3
    imul %1, %2, %3
%endmacro

%macro multiply-without-affecting-flags 3
    mulx %1, %2, %3
%endmacro

%macro divide 1
    div %1
%endmacro

%macro signed-divide 1
    idiv %1
%endmacro

%macro negate 1
    neg %1
%endmacro

%macro compare 2
    cmp %1, %2
%endmacro

%macro ascii-adjust-after-add 0
    aaa
%endmacro

%macro ascii-adjust-before-div 0
    aad
%endmacro

%macro ascii-adjust-after-mul 0
    aam
%endmacro

%macro ascii-adjust-after-sub 0
    aas
%endmacro

%macro decimal-adjust-after-add 0
    daa
%endmacro

%macro decimal-adjust-after-sub 0
    das
%endmacro

%macro compute-crc32 2
    crc32 %1, %2
%endmacro
