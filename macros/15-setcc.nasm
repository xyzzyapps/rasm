; ============================================================================
; SECTION 15: SET CONDITION CODE INSTRUCTIONS (SETcc)
; ============================================================================

%macro set-if-equal 1
    sete %1
%endmacro

%macro set-if-zero 1
    setz %1
%endmacro

%macro set-if-not-equal 1
    setne %1
%endmacro

%macro set-if-not-zero 1
    setnz %1
%endmacro

%macro set-if-greater 1
    setg %1
%endmacro

%macro set-if-greater-or-equal 1
    setge %1
%endmacro

%macro set-if-less 1
    setl %1
%endmacro

%macro set-if-less-or-equal 1
    setle %1
%endmacro

%macro set-if-above 1
    seta %1
%endmacro

%macro set-if-above-or-equal 1
    setae %1
%endmacro

%macro set-if-below 1
    setb %1
%endmacro

%macro set-if-below-or-equal 1
    setbe %1
%endmacro

%macro set-if-carry 1
    setc %1
%endmacro

%macro set-if-not-carry 1
    setnc %1
%endmacro

%macro set-if-overflow 1
    seto %1
%endmacro

%macro set-if-not-overflow 1
    setno %1
%endmacro

%macro set-if-sign 1
    sets %1
%endmacro

%macro set-if-not-sign 1
    setns %1
%endmacro

%macro set-if-parity 1
    setp %1
%endmacro

%macro set-if-parity-even 1
    setpe %1
%endmacro

%macro set-if-no-parity 1
    setnp %1
%endmacro

%macro set-if-parity-odd 1
    setpo %1
%endmacro

%macro set-if-not-above 1
    setna %1
%endmacro

%macro set-if-not-above-or-equal 1
    setnae %1
%endmacro

%macro set-if-not-below 1
    setnb %1
%endmacro

%macro set-if-not-below-or-equal 1
    setnbe %1
%endmacro

%macro set-if-not-greater 1
    setng %1
%endmacro

%macro set-if-not-greater-or-equal 1
    setnge %1
%endmacro

%macro set-if-not-less 1
    setnl %1
%endmacro

%macro set-if-not-less-or-equal 1
    setnle %1
%endmacro

