; ============================================================================
; 02-flags.nasm - Flag Definitions
; ============================================================================

; Flag bit positions
%define flag-carry          0
%define flag-parity         2
%define flag-adjust         4
%define flag-zero           6
%define flag-sign           7
%define flag-trap           8
%define flag-interrupt      9
%define flag-direction      10
%define flag-overflow       11
%define flag-io-privilege   12
%define flag-nested-task    14
%define flag-resume         16
%define flag-virtual-8086   17
%define flag-alignment      18
%define flag-virtual-interrupt 19
%define flag-virtual-interrupt-pending 20
%define flag-id             21

; Flag symbolic names
%define zero-flag           ZF
%define carry-flag          CF
%define sign-flag           SF
%define overflow-flag       OF
%define parity-flag         PF
%define adjust-flag         AF
%define direction-flag      DF
%define interrupt-flag      IF
%define trap-flag           TF
