; ============================================================================
; SECTION 60: CET SHADOW STACK WRITE INSTRUCTIONS
; ============================================================================

%macro write_shadow_stack_dword 2
    wrssd %1, %2
%endmacro

%macro write_shadow_stack_qword 2
    wrssq %1, %2
%endmacro

%macro write_user_shadow_stack_dword 2
    wrussd %1, %2
%endmacro

%macro write_user_shadow_stack_qword 2
    wrussq %1, %2
%endmacro

%macro save_previous_shadow_stack 0
    saveprevssp
%endmacro

%macro restore_shadow_stack 1
    rstorssp %1
%endmacro

%macro set_shadow_stack_busy 0
    setssbsy
%endmacro

