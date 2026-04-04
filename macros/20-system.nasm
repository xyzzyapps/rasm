; ============================================================================
; 20-system.nasm - System and Privileged Instructions
; ============================================================================
; Merged from sections 20 and 61

%macro halt 0
    hlt
%endmacro

%macro no-operation 0
    nop
%endmacro

%macro lock-bus 0
    lock
%endmacro

%macro wait 0
    wait
%endmacro

%macro pause 0
    pause
%endmacro

%macro cpu-identification 0
    cpuid
%endmacro

%macro read-model-specific-register 0
    rdmsr
%endmacro

%macro write-model-specific-register 0
    wrmsr
%endmacro

%macro read-time-stamp-counter 0
    rdtsc
%endmacro

%macro read-time-stamp-counter-and-processor-id 0
    rdtscp
%endmacro

%macro read-processor-id 1
    rdpid %1
%endmacro

%macro invalidate-caches 0
    invd
%endmacro

%macro write-back-invalidate-caches 0
    wbinvd
%endmacro

%macro invalidate-tlb-entry 1
    invlpg %1
%endmacro

%macro invalidate-process-context-id 2
    invpcid %1, %2
%endmacro

%macro load-global-descriptor-table 1
    lgdt %1
%endmacro

%macro load-interrupt-descriptor-table 1
    lidt %1
%endmacro

%macro store-global-descriptor-table 1
    sgdt %1
%endmacro

%macro store-interrupt-descriptor-table 1
    sidt %1
%endmacro

%macro load-local-descriptor-table 1
    lldt %1
%endmacro

%macro store-local-descriptor-table 1
    sldt %1
%endmacro

%macro load-machine-status-word 1
    lmsw %1
%endmacro

%macro store-machine-status-word 1
    smsw %1
%endmacro

%macro load-task-register 1
    ltr %1
%endmacro

%macro store-task-register 1
    str %1
%endmacro

%macro load-access-rights 2
    lar %1, %2
%endmacro

%macro load-segment-limit 2
    lsl %1, %2
%endmacro

%macro verify-read 1
    verr %1
%endmacro

%macro verify-write 1
    verw %1
%endmacro

%macro swap-gs-base 0
    swapgs
%endmacro

%macro syscall-invoke 0
    syscall
%endmacro

%macro system-enter 0
    sysenter
%endmacro

%macro system-exit 0
    sysexit
%endmacro

%macro system-return 0
    sysret
%endmacro

%macro resume-from-system-management 0
    rsm
%endmacro

%macro adjust-rpl-field 2
    arpl %1, %2
%endmacro

%macro undefined-instruction 0
    ud2
%endmacro

%macro serialize-all 0
    serialize
%endmacro

%macro monitor 3
    monitor %1, %2, %3
%endmacro

%macro monitor-wait 0
    mwait
%endmacro

%macro read-performance-counter 1
    rdpmc %1
%endmacro

%macro wait-for-fpu 0
    wait
%endmacro

%macro user-mode-interrupt-prevention 0
    umip
%endmacro

%macro debug-breakpoint 0
    int3
%endmacro

%macro debug-ice-breakpoint 0
    int1
%endmacro
