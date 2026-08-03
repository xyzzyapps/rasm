; ============================================================================
; 01-registers.nasm - Register Definitions
; ============================================================================
; NOTE: use the `register_*` aliases defined further below for readable code
; (register_ax = rax, register_eax = eax, register_al = al, register_ax16 = ax).
; Raw register names (rax, eax, ax, al, ...) always work as well.

; Segment Registers
%define segment_cs cs
%define segment_ds ds
%define segment_es es
%define segment_fs fs
%define segment_gs gs
%define segment_ss ss

; Control Registers
%define control_cr0 cr0
%define control_cr2 cr2
%define control_cr3 cr3
%define control_cr4 cr4
%define control_cr8 cr8

; Debug Registers
%define debug_dr0 dr0
%define debug_dr1 dr1
%define debug_dr2 dr2
%define debug_dr3 dr3
%define debug_dr6 dr6
%define debug_dr7 dr7

; Readable register aliases (defined in full below)

; XMM Registers
%define xmm_0 xmm0
%define xmm_1 xmm1
%define xmm_2 xmm2
%define xmm_3 xmm3
%define xmm_4 xmm4
%define xmm_5 xmm5
%define xmm_6 xmm6
%define xmm_7 xmm7
%define xmm_8 xmm8
%define xmm_9 xmm9
%define xmm_10 xmm10
%define xmm_11 xmm11
%define xmm_12 xmm12
%define xmm_13 xmm13
%define xmm_14 xmm14
%define xmm_15 xmm15

; YMM Registers
%define ymm_0 ymm0
%define ymm_1 ymm1
%define ymm_2 ymm2
%define ymm_3 ymm3
%define ymm_4 ymm4
%define ymm_5 ymm5
%define ymm_6 ymm6
%define ymm_7 ymm7
%define ymm_8 ymm8
%define ymm_9 ymm9
%define ymm_10 ymm10
%define ymm_11 ymm11
%define ymm_12 ymm12
%define ymm_13 ymm13
%define ymm_14 ymm14
%define ymm_15 ymm15

; ZMM Registers
%define zmm_0 zmm0
%define zmm_1 zmm1
%define zmm_2 zmm2
%define zmm_3 zmm3
%define zmm_4 zmm4
%define zmm_5 zmm5
%define zmm_6 zmm6
%define zmm_7 zmm7
%define zmm_8 zmm8
%define zmm_9 zmm9
%define zmm_10 zmm10
%define zmm_11 zmm11
%define zmm_12 zmm12
%define zmm_13 zmm13
%define zmm_14 zmm14
%define zmm_15 zmm15
%define zmm_16 zmm16
%define zmm_17 zmm17
%define zmm_18 zmm18
%define zmm_19 zmm19
%define zmm_20 zmm20
%define zmm_21 zmm21
%define zmm_22 zmm22
%define zmm_23 zmm23
%define zmm_24 zmm24
%define zmm_25 zmm25
%define zmm_26 zmm26
%define zmm_27 zmm27
%define zmm_28 zmm28
%define zmm_29 zmm29
%define zmm_30 zmm30
%define zmm_31 zmm31

; MMX Registers
%define mmx_0 mm0
%define mmx_1 mm1
%define mmx_2 mm2
%define mmx_3 mm3
%define mmx_4 mm4
%define mmx_5 mm5
%define mmx_6 mm6
%define mmx_7 mm7

; AVX-512 Mask Registers
%define mask_k0 k0
%define mask_k1 k1
%define mask_k2 k2
%define mask_k3 k3
%define mask_k4 k4
%define mask_k5 k5
%define mask_k6 k6
%define mask_k7 k7

; ============================================================================
; Readable Register Aliases
; ============================================================================
; Traditional register names with the width explicit in the name:
;   accumulator        -> rax   accumulator_32 -> eax
;   accumulator_64     -> rax   accumulator_16 -> ax
;                              accumulator_8  -> al
;                              accumulator_8_high -> ah  (high byte)
;
;   base              -> rbx   counter  -> rcx   data -> rdx
;   source_index      -> rsi   destination_index -> rdi
;   base_pointer      -> rbp   stack_pointer -> rsp
;   (each with the same _64/_32/_16/_8/_8_high forms)
;
; The extended set keeps the explicit spelling: register_r8 .. register_r15
; with register_r8_64 / _32 / _16 / _8 (r8d, r8w, r8b).
; ============================================================================
; --- Accumulator (A register) ---
%define accumulator rax
%define accumulator_64 rax
%define accumulator_32 eax
%define accumulator_16 ax
%define accumulator_8 al
%define accumulator_8_high ah

; --- Base (B register) ---
%define base rbx
%define base_64 rbx
%define base_32 ebx
%define base_16 bx
%define base_8 bl
%define base_8_high bh

; --- Counter (C register) ---
%define counter rcx
%define counter_64 rcx
%define counter_32 ecx
%define counter_16 cx
%define counter_8 cl
%define counter_8_high ch

; --- Data (D register) ---
%define data rdx
%define data_64 rdx
%define data_32 edx
%define data_16 dx
%define data_8 dl
%define data_8_high dh

; --- Source index (SI) ---
%define source_index rsi
%define source_index_64 rsi
%define source_index_32 esi
%define source_index_16 si
%define source_index_8 sil

; --- Destination index (DI) ---
%define destination_index rdi
%define destination_index_64 rdi
%define destination_index_32 edi
%define destination_index_16 di
%define destination_index_8 dil

; --- Base pointer (BP) ---
%define base_pointer rbp
%define base_pointer_64 rbp
%define base_pointer_32 ebp
%define base_pointer_16 bp
%define base_pointer_8 bpl

; --- Stack pointer (SP) ---
%define stack_pointer rsp
%define stack_pointer_64 rsp
%define stack_pointer_32 esp
%define stack_pointer_16 sp
%define stack_pointer_8 spl

; --- Extended registers r8-r15 ---
%define register_r8 r8
%define register_r9 r9
%define register_r10 r10
%define register_r11 r11
%define register_r12 r12
%define register_r13 r13
%define register_r14 r14
%define register_r15 r15

%define register_r8_64 r8
%define register_r8_32 r8d
%define register_r8_16 r8w
%define register_r8_8 r8b

%define register_r9_64 r9
%define register_r9_32 r9d
%define register_r9_16 r9w
%define register_r9_8 r9b

%define register_r10_64 r10
%define register_r10_32 r10d
%define register_r10_16 r10w
%define register_r10_8 r10b

%define register_r11_64 r11
%define register_r11_32 r11d
%define register_r11_16 r11w
%define register_r11_8 r11b

%define register_r12_64 r12
%define register_r12_32 r12d
%define register_r12_16 r12w
%define register_r12_8 r12b

%define register_r13_64 r13
%define register_r13_32 r13d
%define register_r13_16 r13w
%define register_r13_8 r13b

%define register_r14_64 r14
%define register_r14_32 r14d
%define register_r14_16 r14w
%define register_r14_8 r14b

%define register_r15_64 r15
%define register_r15_32 r15d
%define register_r15_16 r15w
%define register_r15_8 r15b

; --- Legacy aliases (register_ax / eax / al spellings) ---
%define register_ax rax
%define register_bx rbx
%define register_cx rcx
%define register_dx rdx
%define register_si rsi
%define register_di rdi
%define register_bp rbp
%define register_sp rsp

%define register_ax_64 rax
%define register_ax_32 eax
%define register_ax_16 ax
%define register_ax_8 al
%define register_ax_8_high ah

%define register_bx_64 rbx
%define register_bx_32 ebx
%define register_bx_16 bx
%define register_bx_8 bl
%define register_bx_8_high bh

%define register_cx_64 rcx
%define register_cx_32 ecx
%define register_cx_16 cx
%define register_cx_8 cl
%define register_cx_8_high ch

%define register_dx_64 rdx
%define register_dx_32 edx
%define register_dx_16 dx
%define register_dx_8 dl
%define register_dx_8_high dh

%define register_si_64 rsi
%define register_si_32 esi
%define register_si_16 si
%define register_si_8 sil

%define register_di_64 rdi
%define register_di_32 edi
%define register_di_16 di
%define register_di_8 dil

%define register_bp_64 rbp
%define register_bp_32 ebp
%define register_bp_16 bp
%define register_bp_8 bpl

%define register_sp_64 rsp
%define register_sp_32 esp
%define register_sp_16 sp
%define register_sp_8 spl

%define register_rax rax
%define register_rbx rbx
%define register_rcx rcx
%define register_rdx rdx
%define register_rsi rsi
%define register_rdi rdi
%define register_rbp rbp
%define register_rsp rsp
%define register_rip rip

%define register_eax eax
%define register_ebx ebx
%define register_ecx ecx
%define register_edx edx
%define register_esi esi
%define register_edi edi
%define register_ebp ebp
%define register_esp esp

%define register_ax16 ax
%define register_bx16 bx
%define register_cx16 cx
%define register_dx16 dx
%define register_si16 si
%define register_di16 di
%define register_bp16 bp
%define register_sp16 sp

%define register_al al
%define register_bl bl
%define register_cl cl
%define register_dl dl
%define register_sil sil
%define register_dil dil
%define register_bpl bpl
%define register_spl spl

%define register_ah ah
%define register_bh bh
%define register_ch ch
%define register_dh dh

%define register_r8d r8d
%define register_r9d r9d
%define register_r10d r10d
%define register_r11d r11d
%define register_r12d r12d
%define register_r13d r13d
%define register_r14d r14d
%define register_r15d r15d

%define register_r8w r8w
%define register_r9w r9w
%define register_r10w r10w
%define register_r11w r11w
%define register_r12w r12w
%define register_r13w r13w
%define register_r14w r14w
%define register_r15w r15w

%define register_r8b r8b
%define register_r9b r9b
%define register_r10b r10b
%define register_r11b r11b
%define register_r12b r12b
%define register_r13b r13b
%define register_r14b r14b
%define register_r15b r15b

; Flags and special
%define register_eflags eflags
%define register_rflags rflags
%define register_mxcsr mxcsr
