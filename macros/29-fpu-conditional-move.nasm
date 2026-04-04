; ============================================================================
; SECTION 29: X87 FPU - CONDITIONAL MOVE INSTRUCTIONS
; ============================================================================

%macro fpu-conditional-move-if-below 0-1
%if %0 = 1
    fcmovb %1
%else
    fcmovb
%endif
%endmacro

%macro fpu-conditional-move-if-below-or-equal 0-1
%if %0 = 1
    fcmovbe %1
%else
    fcmovbe
%endif
%endmacro

%macro fpu-conditional-move-if-equal 0-1
%if %0 = 1
    fcmove %1
%else
    fcmove
%endif
%endmacro

%macro fpu-conditional-move-if-not-below-or-equal 0-1
%if %0 = 1
    fcmovnbe %1
%else
    fcmovnbe
%endif
%endmacro

%macro fpu-conditional-move-if-not-equal 0-1
%if %0 = 1
    fcmovne %1
%else
    fcmovne
%endif
%endmacro

%macro fpu-conditional-move-if-not-overflow 0-1
%if %0 = 1
    fcmovnu %1
%else
    fcmovnu
%endif
%endmacro

%macro fpu-conditional-move-if-overflow 0-1
%if %0 = 1
    fcmovu %1
%else
    fcmovu
%endif
%endmacro

