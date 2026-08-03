; ============================================================================
; SECTION 50: NEWER EXTENSION INSTRUCTIONS
; ============================================================================

; --- CET (Control-flow Enforcement Technology) ---
%macro increment_shadow_stack_pointer_dword 0
    incsspd
%endmacro

%macro increment_shadow_stack_pointer_qword 0
    incsspq
%endmacro

%macro clear_shadow_stack_busy 1
    clrssbsy %1
%endmacro

; --- AMX (Advanced Matrix Extensions) ---
%macro amx_load_tile_config 1
    ldtilecfg %1
%endmacro

%macro amx_store_tile_config 1
    sttilecfg %1
%endmacro

%macro amx_tile_release 0
    tilerelease
%endmacro

%macro amx_tile_zero 1
    tilezero %1
%endmacro

%macro amx_tile_compute_dp_16_bit 4
    tdpbf16ps %1, %2, %3, %4
%endmacro

%macro amx_tile_compute_dp_8_bit 4
    tdpbssd %1, %2, %3, %4
%endmacro

%macro amx_tile_compute_dp_8_bit_unsigned 4
    tdpbusd %1, %2, %3, %4
%endmacro

; --- WaitPKG ---
%macro waitpkg_user_monitor 1
    umonitor %1
%endmacro

%macro waitpkg_user_mwait 3
    umwait %1, %2, %3
%endmacro

%macro waitpkg_timed_pause 2
    tpause %1, %2
%endmacro

; --- Miscellaneous Newer ---
%macro history_reset 0
    hreset
%endmacro

%macro platform_configuration 0
    pconfig
%endmacro

; --- Random Number Generation ---
%macro read_random_value 1
    rdrand %1
%endmacro

%macro read_seed_value 1
    rdseed %1
%endmacro

