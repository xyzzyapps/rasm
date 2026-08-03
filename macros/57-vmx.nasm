; ============================================================================
; SECTION 57: VMX VIRTUALIZATION INSTRUCTIONS
; ============================================================================

%macro vm_call 0
    vmcall
%endmacro

%macro vm_clear 1
    vmclear %1
%endmacro

%macro vm_launch 0
    vmlaunch
%endmacro

%macro vm_resume 0
    vmresume
%endmacro

%macro vm_off 0
    vmoff
%endmacro

%macro vm_on 0
    vmon
%endmacro

%macro vm_pointer_load 1
    vmptrld %1
%endmacro

%macro vm_pointer_store 1
    vmptrst %1
%endmacro

%macro vm_read_field 2
    vmread %1, %2
%endmacro

%macro vm_write_field 2
    vmwrite %1, %2
%endmacro

%macro vm_exit_interrupt_info 1
    vmxoff %1
%endmacro

