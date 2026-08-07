; ============================================================================
; 03-sizes.nasm - Operand Size Specifiers
; ============================================================================
; Two families of size constants:
;
; 1. size_*  - the operand-size QUALIFIER keywords used inside instructions
;              (e.g. `add size_dword [x], 1` expands to `add dword [x], 1`).
; 2. *_size  - the NUMERIC byte counts, so offsets are self-documenting:
;              `move accumulator_32, [base + dword_size]` instead of `[base + 4]`.
; ============================================================================

; --- Operand-size qualifier keywords ---
%define size_byte           byte
%define size_word           word
%define size_dword          dword
%define size_qword          qword
%define size_tword          tword
%define size_oword          oword
%define size_yword          yword
%define size_zword          zword

; --- Numeric sizes in bytes ---
%define byte_size           1
%define word_size           2
%define dword_size          4
%define qword_size          8
%define tword_size          10
%define oword_size          16
%define yword_size          32
%define zword_size          64
