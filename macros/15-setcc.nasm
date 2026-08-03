; ============================================================================
; SECTION 15: SET CONDITION CODE INSTRUCTIONS (SETcc)
; ============================================================================

%macro set_if_equal 1
    sete %1
%endmacro

%macro set_if_zero 1
    setz %1
%endmacro

%macro set_if_not_equal 1
    setne %1
%endmacro

%macro set_if_not_zero 1
    setnz %1
%endmacro

%macro set_if_greater 1
    setg %1
%endmacro

%macro set_if_greater_or_equal 1
    setge %1
%endmacro

%macro set_if_less 1
    setl %1
%endmacro

%macro set_if_less_or_equal 1
    setle %1
%endmacro

%macro set_if_above 1
    seta %1
%endmacro

%macro set_if_above_or_equal 1
    setae %1
%endmacro

%macro set_if_below 1
    setb %1
%endmacro

%macro set_if_below_or_equal 1
    setbe %1
%endmacro

%macro set_if_carry 1
    setc %1
%endmacro

%macro set_if_not_carry 1
    setnc %1
%endmacro

%macro set_if_overflow 1
    seto %1
%endmacro

%macro set_if_not_overflow 1
    setno %1
%endmacro

%macro set_if_sign 1
    sets %1
%endmacro

%macro set_if_not_sign 1
    setns %1
%endmacro

%macro set_if_parity 1
    setp %1
%endmacro

%macro set_if_parity_even 1
    setpe %1
%endmacro

%macro set_if_no_parity 1
    setnp %1
%endmacro

%macro set_if_parity_odd 1
    setpo %1
%endmacro

%macro set_if_not_above 1
    setna %1
%endmacro

%macro set_if_not_above_or_equal 1
    setnae %1
%endmacro

%macro set_if_not_below 1
    setnb %1
%endmacro

%macro set_if_not_below_or_equal 1
    setnbe %1
%endmacro

%macro set_if_not_greater 1
    setng %1
%endmacro

%macro set_if_not_greater_or_equal 1
    setnge %1
%endmacro

%macro set_if_not_less 1
    setnl %1
%endmacro

%macro set_if_not_less_or_equal 1
    setnle %1
%endmacro

