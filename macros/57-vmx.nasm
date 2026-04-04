; ============================================================================
; SECTION 57: VMX VIRTUALIZATION INSTRUCTIONS
; ============================================================================

%macro vm-call 0
    vmcall
%endmacro

%macro vm-clear 1
    vmclear %1
%endmacro

%macro vm-launch 0
    vmlaunch
%endmacro

%macro vm-resume 0
    vmresume
%endmacro

%macro vm-off 0
    vmoff
%endmacro

%macro vm-on 0
    vmon
%endmacro

%macro vm-pointer-load 1
    vmptrld %1
%endmacro

%macro vm-pointer-store 1
    vmptrst %1
%endmacro

%macro vm-read-field 2
    vmread %1, %2
%endmacro

%macro vm-write-field 2
    vmwrite %1, %2
%endmacro

%macro vm-exit-interrupt-info 1
    vmxoff %1
%endmacro

