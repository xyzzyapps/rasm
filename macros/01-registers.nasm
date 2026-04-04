; ============================================================================
; 01-registers.nasm - Register Definitions
; ============================================================================
; General Purpose Registers (64-bit)
%define reg-rax rax
%define reg-rbx rbx
%define reg-rcx rcx
%define reg-rdx rdx
%define reg-rsi rsi
%define reg-rdi rdi
%define reg-rbp rbp
%define reg-rsp rsp
%define reg-r8  r8
%define reg-r9  r9
%define reg-r10 r10
%define reg-r11 r11
%define reg-r12 r12
%define reg-r13 r13
%define reg-r14 r14
%define reg-r15 r15

; General Purpose Registers (32-bit)
%define reg-eax eax
%define reg-ebx ebx
%define reg-ecx ecx
%define reg-edx edx
%define reg-esi esi
%define reg-edi edi
%define reg-ebp ebp
%define reg-esp esp
%define reg-r8d r8d
%define reg-r9d r9d
%define reg-r10d r10d
%define reg-r11d r11d
%define reg-r12d r12d
%define reg-r13d r13d
%define reg-r14d r14d
%define reg-r15d r15d

; General Purpose Registers (16-bit)
%define reg-ax ax
%define reg-bx bx
%define reg-cx cx
%define reg-dx dx
%define reg-si si
%define reg-di di
%define reg-bp bp
%define reg-sp sp
%define reg-r8w r8w
%define reg-r9w r9w
%define reg-r10w r10w
%define reg-r11w r11w
%define reg-r12w r12w
%define reg-r13w r13w
%define reg-r14w r14w
%define reg-r15w r15w

; General Purpose Registers (8-bit low)
%define reg-al al
%define reg-bl bl
%define reg-cl cl
%define reg-dl dl
%define reg-sil sil
%define reg-dil dil
%define reg-bpl bpl
%define reg-spl spl
%define reg-r8b r8b
%define reg-r9b r9b
%define reg-r10b r10b
%define reg-r11b r11b
%define reg-r12b r12b
%define reg-r13b r13b
%define reg-r14b r14b
%define reg-r15b r15b

; General Purpose Registers (8-bit high, legacy)
%define reg-ah ah
%define reg-bh bh
%define reg-ch ch
%define reg-dh dh

; Segment Registers
%define segment-cs cs
%define segment-ds ds
%define segment-es es
%define segment-fs fs
%define segment-gs gs
%define segment-ss ss

; Control Registers
%define control-cr0 cr0
%define control-cr2 cr2
%define control-cr3 cr3
%define control-cr4 cr4
%define control-cr8 cr8

; Debug Registers
%define debug-dr0 dr0
%define debug-dr1 dr1
%define debug-dr2 dr2
%define debug-dr3 dr3
%define debug-dr6 dr6
%define debug-dr7 dr7

; Special Registers
%define reg-rip rip
%define reg-eflags eflags
%define reg-rflags rflags
%define reg-mxcsr mxcsr

; XMM Registers
%define xmm-0 xmm0
%define xmm-1 xmm1
%define xmm-2 xmm2
%define xmm-3 xmm3
%define xmm-4 xmm4
%define xmm-5 xmm5
%define xmm-6 xmm6
%define xmm-7 xmm7
%define xmm-8 xmm8
%define xmm-9 xmm9
%define xmm-10 xmm10
%define xmm-11 xmm11
%define xmm-12 xmm12
%define xmm-13 xmm13
%define xmm-14 xmm14
%define xmm-15 xmm15

; YMM Registers
%define ymm-0 ymm0
%define ymm-1 ymm1
%define ymm-2 ymm2
%define ymm-3 ymm3
%define ymm-4 ymm4
%define ymm-5 ymm5
%define ymm-6 ymm6
%define ymm-7 ymm7
%define ymm-8 ymm8
%define ymm-9 ymm9
%define ymm-10 ymm10
%define ymm-11 ymm11
%define ymm-12 ymm12
%define ymm-13 ymm13
%define ymm-14 ymm14
%define ymm-15 ymm15

; ZMM Registers
%define zmm-0 zmm0
%define zmm-1 zmm1
%define zmm-2 zmm2
%define zmm-3 zmm3
%define zmm-4 zmm4
%define zmm-5 zmm5
%define zmm-6 zmm6
%define zmm-7 zmm7
%define zmm-8 zmm8
%define zmm-9 zmm9
%define zmm-10 zmm10
%define zmm-11 zmm11
%define zmm-12 zmm12
%define zmm-13 zmm13
%define zmm-14 zmm14
%define zmm-15 zmm15
%define zmm-16 zmm16
%define zmm-17 zmm17
%define zmm-18 zmm18
%define zmm-19 zmm19
%define zmm-20 zmm20
%define zmm-21 zmm21
%define zmm-22 zmm22
%define zmm-23 zmm23
%define zmm-24 zmm24
%define zmm-25 zmm25
%define zmm-26 zmm26
%define zmm-27 zmm27
%define zmm-28 zmm28
%define zmm-29 zmm29
%define zmm-30 zmm30
%define zmm-31 zmm31

; MMX Registers
%define mmx-0 mm0
%define mmx-1 mm1
%define mmx-2 mm2
%define mmx-3 mm3
%define mmx-4 mm4
%define mmx-5 mm5
%define mmx-6 mm6
%define mmx-7 mm7

; AVX-512 Mask Registers
%define mask-k0 k0
%define mask-k1 k1
%define mask-k2 k2
%define mask-k3 k3
%define mask-k4 k4
%define mask-k5 k5
%define mask-k6 k6
%define mask-k7 k7
