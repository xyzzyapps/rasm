; ============================================================================
; 20-system.nasm - System and Privileged Instructions
; ============================================================================
; Merged from sections 20 and 61

%macro halt 0
    hlt
%endmacro

%macro no_operation 0
    nop
%endmacro

%macro lock_bus 0
    lock
%endmacro

%macro wait 0
    wait
%endmacro

%macro pause 0
    pause
%endmacro

%macro cpu_identification 0
    cpuid
%endmacro

%macro read_model_specific_register 0
    rdmsr
%endmacro

%macro write_model_specific_register 0
    wrmsr
%endmacro

%macro read_time_stamp_counter 0
    rdtsc
%endmacro

%macro read_time_stamp_counter_and_processor_id 0
    rdtscp
%endmacro

%macro read_processor_id 1
    rdpid %1
%endmacro

%macro invalidate_caches 0
    invd
%endmacro

%macro write_back_invalidate_caches 0
    wbinvd
%endmacro

%macro invalidate_tlb_entry 1
    invlpg %1
%endmacro

%macro invalidate_process_context_id 2
    invpcid %1, %2
%endmacro

%macro load_global_descriptor_table 1
    lgdt %1
%endmacro

%macro load_interrupt_descriptor_table 1
    lidt %1
%endmacro

%macro store_global_descriptor_table 1
    sgdt %1
%endmacro

%macro store_interrupt_descriptor_table 1
    sidt %1
%endmacro

%macro load_local_descriptor_table 1
    lldt %1
%endmacro

%macro store_local_descriptor_table 1
    sldt %1
%endmacro

%macro load_machine_status_word 1
    lmsw %1
%endmacro

%macro store_machine_status_word 1
    smsw %1
%endmacro

%macro load_task_register 1
    ltr %1
%endmacro

%macro store_task_register 1
    str %1
%endmacro

%macro load_access_rights 2
    lar %1, %2
%endmacro

%macro load_segment_limit 2
    lsl %1, %2
%endmacro

%macro verify_read 1
    verr %1
%endmacro

%macro verify_write 1
    verw %1
%endmacro

%macro swap_gs_base 0
    swapgs
%endmacro

%macro syscall_invoke 0
    syscall
%endmacro

%macro system_enter 0
    sysenter
%endmacro

%macro system_exit 0
    sysexit
%endmacro

%macro system_return 0
    sysret
%endmacro

%macro resume_from_system_management 0
    rsm
%endmacro

%macro adjust_rpl_field 2
    arpl %1, %2
%endmacro

%macro undefined_instruction 0
    ud2
%endmacro

%macro serialize_all 0
    serialize
%endmacro

%macro monitor 3
    monitor %1, %2, %3
%endmacro

%macro monitor_wait 0
    mwait
%endmacro

%macro read_performance_counter 1
    rdpmc %1
%endmacro

%macro wait_for_fpu 0
    wait
%endmacro

%macro user_mode_interrupt_prevention 0
    umip
%endmacro

%macro debug_breakpoint 0
    int3
%endmacro

%macro debug_ice_breakpoint 0
    int1
%endmacro
