; ============================================================================
; SECTION 60: CET SHADOW STACK WRITE INSTRUCTIONS
; ============================================================================

%macro write-shadow-stack-dword 2
    wrssd %1, %2
%endmacro

%macro write-shadow-stack-qword 2
    wrssq %1, %2
%endmacro

%macro write-user-shadow-stack-dword 2
    wrussd %1, %2
%endmacro

%macro write-user-shadow-stack-qword 2
    wrussq %1, %2
%endmacro

%macro save-previous-shadow-stack 0
    saveprevssp
%endmacro

%macro restore-shadow-stack 1
    rstorssp %1
%endmacro

%macro set-shadow-stack-busy 0
    setssbsy
%endmacro

