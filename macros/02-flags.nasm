; ============================================================================
; 02-flags.nasm - Flag Definitions
; ============================================================================

; Flag bit positions
%define flag_carry          0
%define flag_parity         2
%define flag_adjust         4
%define flag_zero           6
%define flag_sign           7
%define flag_trap           8
%define flag_interrupt      9
%define flag_direction      10
%define flag_overflow       11
%define flag_io_privilege   12
%define flag_nested_task    14
%define flag_resume         16
%define flag_virtual_8086   17
%define flag_alignment      18
%define flag_virtual_interrupt 19
%define flag_virtual_interrupt_pending 20
%define flag_id             21

; Flag symbolic names
%define zero_flag           ZF
%define carry_flag          CF
%define sign_flag           SF
%define overflow_flag       OF
%define parity_flag         PF
%define adjust_flag         AF
%define direction_flag      DF
%define interrupt_flag      IF
%define trap_flag           TF
