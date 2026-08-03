; ============================================================================
; 01-registers.nasm - Register Definitions
; ============================================================================
; General Purpose Registers (64-bit)
%define reg_rax rax
%define reg_rbx rbx
%define reg_rcx rcx
%define reg_rdx rdx
%define reg_rsi rsi
%define reg_rdi rdi
%define reg_rbp rbp
%define reg_rsp rsp
%define reg_r8  r8
%define reg_r9  r9
%define reg_r10 r10
%define reg_r11 r11
%define reg_r12 r12
%define reg_r13 r13
%define reg_r14 r14
%define reg_r15 r15

; General Purpose Registers (32-bit)
%define reg_eax eax
%define reg_ebx ebx
%define reg_ecx ecx
%define reg_edx edx
%define reg_esi esi
%define reg_edi edi
%define reg_ebp ebp
%define reg_esp esp
%define reg_r8d r8d
%define reg_r9d r9d
%define reg_r10d r10d
%define reg_r11d r11d
%define reg_r12d r12d
%define reg_r13d r13d
%define reg_r14d r14d
%define reg_r15d r15d

; General Purpose Registers (16-bit)
%define reg_ax ax
%define reg_bx bx
%define reg_cx cx
%define reg_dx dx
%define reg_si si
%define reg_di di
%define reg_bp bp
%define reg_sp sp
%define reg_r8w r8w
%define reg_r9w r9w
%define reg_r10w r10w
%define reg_r11w r11w
%define reg_r12w r12w
%define reg_r13w r13w
%define reg_r14w r14w
%define reg_r15w r15w

; General Purpose Registers (8-bit low)
%define reg_al al
%define reg_bl bl
%define reg_cl cl
%define reg_dl dl
%define reg_sil sil
%define reg_dil dil
%define reg_bpl bpl
%define reg_spl spl
%define reg_r8b r8b
%define reg_r9b r9b
%define reg_r10b r10b
%define reg_r11b r11b
%define reg_r12b r12b
%define reg_r13b r13b
%define reg_r14b r14b
%define reg_r15b r15b

; General Purpose Registers (8-bit high, legacy)
%define reg_ah ah
%define reg_bh bh
%define reg_ch ch
%define reg_dh dh

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

; Special Registers
%define reg_rip rip
%define reg_eflags eflags
%define reg_rflags rflags
%define reg_mxcsr mxcsr

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
; Readable Register Aliases (register-ax = the A register, 64-bit)
; These provide the self-documenting names used in examples and demos:
;   register-ax  -> rax   register-eax -> eax   register-al -> al
; ============================================================================
; 64-bit general purpose (readable names)
%define register_ax rax
%define register_bx rbx
%define register_cx rcx
%define register_dx rdx
%define register_si rsi
%define register_di rdi
%define register_bp rbp
%define register_sp rsp

; Explicit 64-bit names
%define register_rax rax
%define register_rbx rbx
%define register_rcx rcx
%define register_rdx rdx
%define register_rsi rsi
%define register_rdi rdi
%define register_rbp rbp
%define register_rsp rsp
%define register_rip rip

; 32-bit
%define register_eax eax
%define register_ebx ebx
%define register_ecx ecx
%define register_edx edx
%define register_esi esi
%define register_edi edi
%define register_ebp ebp
%define register_esp esp

; 16-bit
%define register_ax16 ax
%define register_bx16 bx
%define register_cx16 cx
%define register_dx16 dx
%define register_si16 si
%define register_di16 di
%define register_bp16 bp
%define register_sp16 sp

; 8-bit low
%define register_al al
%define register_bl bl
%define register_cl cl
%define register_dl dl
%define register_sil sil
%define register_dil dil
%define register_bpl bpl
%define register_spl spl

; 8-bit high (legacy)
%define register_ah ah
%define register_bh bh
%define register_ch ch
%define register_dh dh

; Extended registers r8-r15 (64-bit)
%define register_r8 r8
%define register_r9 r9
%define register_r10 r10
%define register_r11 r11
%define register_r12 r12
%define register_r13 r13
%define register_r14 r14
%define register_r15 r15

; Extended registers (32-bit)
%define register_r8d r8d
%define register_r9d r9d
%define register_r10d r10d
%define register_r11d r11d
%define register_r12d r12d
%define register_r13d r13d
%define register_r14d r14d
%define register_r15d r15d

; Extended registers (16-bit)
%define register_r8w r8w
%define register_r9w r9w
%define register_r10w r10w
%define register_r11w r11w
%define register_r12w r12w
%define register_r13w r13w
%define register_r14w r14w
%define register_r15w r15w

; Extended registers (8-bit)
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
