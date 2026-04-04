; ============================================================================
; SECTION 50: NEWER EXTENSION INSTRUCTIONS
; ============================================================================

; --- CET (Control-flow Enforcement Technology) ---
%macro increment-shadow-stack-pointer-dword 0
    incsspd
%endmacro

%macro increment-shadow-stack-pointer-qword 0
    incsspq
%endmacro

%macro clear-shadow-stack-busy 1
    clrssbsy %1
%endmacro

; --- AMX (Advanced Matrix Extensions) ---
%macro amx-load-tile-config 1
    ldtilecfg %1
%endmacro

%macro amx-store-tile-config 1
    sttilecfg %1
%endmacro

%macro amx-tile-release 0
    tilerelease
%endmacro

%macro amx-tile-zero 1
    tilezero %1
%endmacro

%macro amx-tile-compute-dp-16-bit 4
    tdpbf16ps %1, %2, %3, %4
%endmacro

%macro amx-tile-compute-dp-8-bit 4
    tdpbssd %1, %2, %3, %4
%endmacro

%macro amx-tile-compute-dp-8-bit-unsigned 4
    tdpbusd %1, %2, %3, %4
%endmacro

; --- WaitPKG ---
%macro waitpkg-user-monitor 1
    umonitor %1
%endmacro

%macro waitpkg-user-mwait 3
    umwait %1, %2, %3
%endmacro

%macro waitpkg-timed-pause 2
    tpause %1, %2
%endmacro

; --- Miscellaneous Newer ---
%macro history-reset 0
    hreset
%endmacro

%macro platform-configuration 0
    pconfig
%endmacro

%macro pt-write 1
    ptwrite %1
%endmacro

; --- Random Number Generation ---
%macro read-random-value 1
    rdrand %1
%endmacro

%macro read-seed-value 1
    rdseed %1
%endmacro

