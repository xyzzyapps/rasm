; ============================================================================
; READABLE MACROS - Complete x86-64 NASM Preprocessor Macros
; ============================================================================
; Comprehensive English-hyphenated macro names for ALL x86-64 instructions.
; Covers 1000+ instruction mnemonics across all categories.
;
; Usage: %include "readable_macros.nasm"
; ============================================================================

; ============================================================================
; SECTION 1: REGISTER MACROS
; ============================================================================

; --- General Purpose Registers (64-bit) ---
%define register-rax rax
%define register-rbx rbx
%define register-rcx rcx
%define register-rdx rdx
%define register-rsi rsi
%define register-rdi rdi
%define register-rbp rbp
%define register-rsp rsp
%define register-r8  r8
%define register-r9  r9
%define register-r10 r10
%define register-r11 r11
%define register-r12 r12
%define register-r13 r13
%define register-r14 r14
%define register-r15 r15

; --- General Purpose Registers (32-bit) ---
%define register-eax eax
%define register-ebx ebx
%define register-ecx ecx
%define register-edx edx
%define register-esi esi
%define register-edi edi
%define register-ebp ebp
%define register-esp esp
%define register-r8d r8d
%define register-r9d r9d
%define register-r10d r10d
%define register-r11d r11d
%define register-r12d r12d
%define register-r13d r13d
%define register-r14d r14d
%define register-r15d r15d

; --- General Purpose Registers (16-bit) ---
%define register-ax ax
%define register-bx bx
%define register-cx cx
%define register-dx dx
%define register-si si
%define register-di di
%define register-bp bp
%define register-sp sp
%define register-r8w r8w
%define register-r9w r9w
%define register-r10w r10w
%define register-r11w r11w
%define register-r12w r12w
%define register-r13w r13w
%define register-r14w r14w
%define register-r15w r15w

; --- General Purpose Registers (8-bit low) ---
%define register-al al
%define register-bl bl
%define register-cl cl
%define register-dl dl
%define register-sil sil
%define register-dil dil
%define register-bpl bpl
%define register-spl spl
%define register-r8b r8b
%define register-r9b r9b
%define register-r10b r10b
%define register-r11b r11b
%define register-r12b r12b
%define register-r13b r13b
%define register-r14b r14b
%define register-r15b r15b

; --- General Purpose Registers (8-bit high, legacy) ---
%define register-ah ah
%define register-bh bh
%define register-ch ch
%define register-dh dh

; --- Segment Registers ---
%define segment-register-cs cs
%define segment-register-ds ds
%define segment-register-es es
%define segment-register-fs fs
%define segment-register-gs gs
%define segment-register-ss ss

; --- Control Registers ---
%define control-register-cr0 cr0
%define control-register-cr2 cr2
%define control-register-cr3 cr3
%define control-register-cr4 cr4
%define control-register-cr8 cr8

; --- Debug Registers ---
%define debug-register-dr0 dr0
%define debug-register-dr1 dr1
%define debug-register-dr2 dr2
%define debug-register-dr3 dr3
%define debug-register-dr6 dr6
%define debug-register-dr7 dr7

; --- Special Registers ---
%define register-rip rip
%define register-eflags eflags
%define register-rflags rflags
%define register-mxcsr mxcsr

; --- XMM Registers ---
%define xmm-register-0 xmm0
%define xmm-register-1 xmm1
%define xmm-register-2 xmm2
%define xmm-register-3 xmm3
%define xmm-register-4 xmm4
%define xmm-register-5 xmm5
%define xmm-register-6 xmm6
%define xmm-register-7 xmm7
%define xmm-register-8 xmm8
%define xmm-register-9 xmm9
%define xmm-register-10 xmm10
%define xmm-register-11 xmm11
%define xmm-register-12 xmm12
%define xmm-register-13 xmm13
%define xmm-register-14 xmm14
%define xmm-register-15 xmm15

; --- YMM Registers ---
%define ymm-register-0 ymm0
%define ymm-register-1 ymm1
%define ymm-register-2 ymm2
%define ymm-register-3 ymm3
%define ymm-register-4 ymm4
%define ymm-register-5 ymm5
%define ymm-register-6 ymm6
%define ymm-register-7 ymm7
%define ymm-register-8 ymm8
%define ymm-register-9 ymm9
%define ymm-register-10 ymm10
%define ymm-register-11 ymm11
%define ymm-register-12 ymm12
%define ymm-register-13 ymm13
%define ymm-register-14 ymm14
%define ymm-register-15 ymm15

; --- ZMM Registers ---
%define zmm-register-0 zmm0
%define zmm-register-1 zmm1
%define zmm-register-2 zmm2
%define zmm-register-3 zmm3
%define zmm-register-4 zmm4
%define zmm-register-5 zmm5
%define zmm-register-6 zmm6
%define zmm-register-7 zmm7
%define zmm-register-8 zmm8
%define zmm-register-9 zmm9
%define zmm-register-10 zmm10
%define zmm-register-11 zmm11
%define zmm-register-12 zmm12
%define zmm-register-13 zmm13
%define zmm-register-14 zmm14
%define zmm-register-15 zmm15
%define zmm-register-16 zmm16
%define zmm-register-17 zmm17
%define zmm-register-18 zmm18
%define zmm-register-19 zmm19
%define zmm-register-20 zmm20
%define zmm-register-21 zmm21
%define zmm-register-22 zmm22
%define zmm-register-23 zmm23
%define zmm-register-24 zmm24
%define zmm-register-25 zmm25
%define zmm-register-26 zmm26
%define zmm-register-27 zmm27
%define zmm-register-28 zmm28
%define zmm-register-29 zmm29
%define zmm-register-30 zmm30
%define zmm-register-31 zmm31

; --- MMX Registers ---
%define mmx-register-0 mm0
%define mmx-register-1 mm1
%define mmx-register-2 mm2
%define mmx-register-3 mm3
%define mmx-register-4 mm4
%define mmx-register-5 mm5
%define mmx-register-6 mm6
%define mmx-register-7 mm7

; --- AVX-512 Mask Registers ---
%define mask-register-k0 k0
%define mask-register-k1 k1
%define mask-register-k2 k2
%define mask-register-k3 k3
%define mask-register-k4 k4
%define mask-register-k5 k5
%define mask-register-k6 k6
%define mask-register-k7 k7

; ============================================================================
; SECTION 2: FLAG MACROS
; ============================================================================

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

%define zero-flag           ZF
%define carry-flag          CF
%define sign-flag           SF
%define overflow-flag       OF
%define parity-flag         PF
%define adjust-flag         AF
%define direction-flag      DF
%define interrupt-flag      IF
%define trap-flag           TF

; ============================================================================
; SECTION 3: OPERAND SIZE SPECIFIERS
; ============================================================================

%define byte-size           byte
%define word-size           word
%define dword-size          dword
%define qword-size          qword
%define tword-size          tword
%define oword-size          oword
%define yword-size          yword
%define zword-size          zword

; ============================================================================
; SECTION 4: SEGMENT OVERRIDES
; ============================================================================

%define segment-cs          cs:
%define segment-ds          ds:
%define segment-es          es:
%define segment-fs          fs:
%define segment-gs          gs:
%define segment-ss          ss:

; ============================================================================
; SECTION 5: DATA MOVEMENT INSTRUCTIONS
; ============================================================================

; --- Basic Move ---
%macro move 2
    mov %1, %2
%endmacro

%macro move-byte 2
    mov byte %1, %2
%endmacro

%macro move-word 2
    mov word %1, %2
%endmacro

%macro move-dword 2
    mov dword %1, %2
%endmacro

%macro move-qword 2
    mov qword %1, %2
%endmacro

%macro move-with-sign-extension 2
    movsx %1, %2
%endmacro

%macro move-with-sign-extend-dword 2
    movsxd %1, %2
%endmacro

%macro move-with-zero-extension 2
    movzx %1, %2
%endmacro

%macro move-with-byte-swap 2
    movbe %1, %2
%endmacro

%macro exchange 2
    xchg %1, %2
%endmacro

%macro swap 2
    xchg %1, %2
%endmacro

%macro exchange-and-add 2
    xadd %1, %2
%endmacro

%macro load-effective-address 2
    lea %1, %2
%endmacro

%macro load-pointer-ds 2
    lds %1, %2
%endmacro

%macro load-pointer-es 2
    les %1, %2
%endmacro

%macro load-pointer-fs 2
    lfs %1, %2
%endmacro

%macro load-pointer-gs 2
    lgs %1, %2
%endmacro

%macro load-pointer-ss 2
    lss %1, %2
%endmacro

%macro convert-byte-to-word 0
    cbw
%endmacro

%macro convert-word-to-dword 0
    cwd
%endmacro

%macro convert-dword-to-qword 0
    cdq
%endmacro

%macro convert-qword-to-oword 0
    cqo
%endmacro

%macro convert-byte-to-dword 0
    cwde
%endmacro

%macro convert-word-to-qword 0
    cdqe
%endmacro

%macro move-string 0
    movs
%endmacro

%macro move-string-byte 0
    movsb
%endmacro

%macro move-string-word 0
    movsw
%endmacro

%macro move-string-dword 0
    movsd
%endmacro

%macro move-string-qword 0
    movsq
%endmacro

%macro translate-byte 0
    xlat
%endmacro

; --- Conditional Move ---
%macro move-if-equal 2
    cmove %1, %2
%endmacro

%macro move-if-zero 2
    cmovz %1, %2
%endmacro

%macro move-if-not-equal 2
    cmovne %1, %2
%endmacro

%macro move-if-not-zero 2
    cmovnz %1, %2
%endmacro

%macro move-if-greater 2
    cmovg %1, %2
%endmacro

%macro move-if-greater-or-equal 2
    cmovge %1, %2
%endmacro

%macro move-if-less 2
    cmovl %1, %2
%endmacro

%macro move-if-less-or-equal 2
    cmovle %1, %2
%endmacro

%macro move-if-above 2
    cmova %1, %2
%endmacro

%macro move-if-above-or-equal 2
    cmovae %1, %2
%endmacro

%macro move-if-below 2
    cmovb %1, %2
%endmacro

%macro move-if-below-or-equal 2
    cmovbe %1, %2
%endmacro

%macro move-if-carry 2
    cmovc %1, %2
%endmacro

%macro move-if-not-carry 2
    cmovnc %1, %2
%endmacro

%macro move-if-overflow 2
    cmovo %1, %2
%endmacro

%macro move-if-not-overflow 2
    cmovno %1, %2
%endmacro

%macro move-if-sign 2
    cmovs %1, %2
%endmacro

%macro move-if-not-sign 2
    cmovns %1, %2
%endmacro

%macro move-if-parity 2
    cmovp %1, %2
%endmacro

%macro move-if-parity-even 2
    cmovpe %1, %2
%endmacro

%macro move-if-no-parity 2
    cmovnp %1, %2
%endmacro

%macro move-if-parity-odd 2
    cmovpo %1, %2
%endmacro

%macro move-if-not-above 2
    cmovna %1, %2
%endmacro

%macro move-if-not-above-or-equal 2
    cmovnae %1, %2
%endmacro

%macro move-if-not-below 2
    cmovnb %1, %2
%endmacro

%macro move-if-not-below-or-equal 2
    cmovnbe %1, %2
%endmacro

%macro move-if-not-greater 2
    cmovng %1, %2
%endmacro

%macro move-if-not-greater-or-equal 2
    cmovnge %1, %2
%endmacro

%macro move-if-not-less 2
    cmovnl %1, %2
%endmacro

%macro move-if-not-less-or-equal 2
    cmovnle %1, %2
%endmacro

; --- Compare and Exchange ---
%macro compare-and-exchange 2
    cmpxchg %1, %2
%endmacro

%macro compare-and-exchange-8-byte 1
    cmpxchg8b %1
%endmacro

%macro compare-and-exchange-16-byte 1
    cmpxchg16b %1
%endmacro

; --- Move Direct ---
%macro move-direct-indirect 2
    movdiri %1, %2
%endmacro

%macro move-direct-64-byte 2
    movdir64b %1, %2
%endmacro

; --- Enqueue ---
%macro enqueue-command 2
    enqcmd %1, %2
%endmacro

%macro enqueue-command-supervisor 2
    enqcmds %1, %2
%endmacro

; ============================================================================
; SECTION 6: ARITHMETIC INSTRUCTIONS
; ============================================================================

%macro add 2
    add %1, %2
%endmacro

%macro add-with-carry 2
    adc %1, %2
%endmacro

%macro add-with-carry-flag 2
    adcx %1, %2
%endmacro

%macro add-with-overflow-flag 2
    adox %1, %2
%endmacro

%macro subtract 2
    sub %1, %2
%endmacro

%macro subtract-with-borrow 2
    sbb %1, %2
%endmacro

%macro increment 1
    inc %1
%endmacro

%macro decrement 1
    dec %1
%endmacro

%macro multiply 1
    mul %1
%endmacro

%macro signed-multiply 1
    imul %1
%endmacro

%macro signed-multiply-immediate 2
    imul %1, %2
%endmacro

%macro signed-multiply-immediate-3 3
    imul %1, %2, %3
%endmacro

%macro multiply-without-affecting-flags 3
    mulx %1, %2, %3
%endmacro

%macro divide 1
    div %1
%endmacro

%macro signed-divide 1
    idiv %1
%endmacro

%macro negate 1
    neg %1
%endmacro

%macro compare 2
    cmp %1, %2
%endmacro

%macro ascii-adjust-after-add 0
    aaa
%endmacro

%macro ascii-adjust-before-div 0
    aad
%endmacro

%macro ascii-adjust-after-mul 0
    aam
%endmacro

%macro ascii-adjust-after-sub 0
    aas
%endmacro

%macro decimal-adjust-after-add 0
    daa
%endmacro

%macro decimal-adjust-after-sub 0
    das
%endmacro

%macro compute-crc32 2
    crc32 %1, %2
%endmacro

; ============================================================================
; SECTION 7: LOGIC INSTRUCTIONS
; ============================================================================

%macro logical-and 2
    and %1, %2
%endmacro

%macro logical-and-not 2
    andn %1, %2
%endmacro

%macro logical-or 2
    or %1, %2
%endmacro

%macro logical-xor 2
    xor %1, %2
%endmacro

%macro logical-not 1
    not %1
%endmacro

%macro test 2
    test %1, %2
%endmacro

; ============================================================================
; SECTION 8: SHIFT AND ROTATE INSTRUCTIONS
; ============================================================================

%macro shift-logical-left 2
    shl %1, %2
%endmacro

%macro shift-arithmetic-left 2
    sal %1, %2
%endmacro

%macro shift-logical-right 2
    shr %1, %2
%endmacro

%macro shift-arithmetic-right 2
    sar %1, %2
%endmacro

%macro rotate-left 2
    rol %1, %2
%endmacro

%macro rotate-right 2
    ror %1, %2
%endmacro

%macro rotate-left-through-carry 2
    rcl %1, %2
%endmacro

%macro rotate-right-through-carry 2
    rcr %1, %2
%endmacro

%macro shift-left-double 3
    shld %1, %2, %3
%endmacro

%macro shift-right-double 3
    shrd %1, %2, %3
%endmacro

%macro rotate-right-without-affecting-flags 3
    rorx %1, %2, %3
%endmacro

%macro shift-left-without-affecting-flags 3
    shlx %1, %2, %3
%endmacro

%macro shift-right-arithmetic-without-affecting-flags 3
    sarx %1, %2, %3
%endmacro

%macro shift-right-logical-without-affecting-flags 3
    shrx %1, %2, %3
%endmacro

; ============================================================================
; SECTION 9: BIT MANIPULATION INSTRUCTIONS
; ============================================================================

%macro bit-scan-forward 2
    bsf %1, %2
%endmacro

%macro bit-scan-reverse 2
    bsr %1, %2
%endmacro

%macro byte-swap 1
    bswap %1
%endmacro

%macro bit-test 2
    bt %1, %2
%endmacro

%macro bit-test-and-complement 2
    btc %1, %2
%endmacro

%macro bit-test-and-reset 2
    btr %1, %2
%endmacro

%macro bit-test-and-set 2
    bts %1, %2
%endmacro

%macro bit-field-extract 3
    bextr %1, %2, %3
%endmacro

%macro extract-lowest-set-isolated-bit 2
    blsi %1, %2
%endmacro

%macro get-mask-up-to-lowest-set-bit 2
    blsmsk %1, %2
%endmacro

%macro reset-lowest-set-bit 2
    blsr %1, %2
%endmacro

%macro zero-high-bits 2
    bzhi %1, %2
%endmacro

%macro count-leading-zeros 2
    lzcnt %1, %2
%endmacro

%macro count-trailing-zeros 2
    tzcnt %1, %2
%endmacro

%macro population-count 2
    popcnt %1, %2
%endmacro

%macro parallel-bits-deposit 3
    pdep %1, %2, %3
%endmacro

%macro parallel-bits-extract 3
    pext %1, %2, %3
%endmacro

; ============================================================================
; SECTION 10: CONTROL FLOW - JUMP INSTRUCTIONS
; ============================================================================

%macro jump 1
    jmp %1
%endmacro

%macro jump-if-equal 1
    je %1
%endmacro

%macro jump-if-zero 1
    jz %1
%endmacro

%macro jump-if-not-equal 1
    jne %1
%endmacro

%macro jump-if-not-zero 1
    jnz %1
%endmacro

%macro jump-if-greater 1
    jg %1
%endmacro

%macro jump-if-greater-or-equal 1
    jge %1
%endmacro

%macro jump-if-less 1
    jl %1
%endmacro

%macro jump-if-less-or-equal 1
    jle %1
%endmacro

%macro jump-if-above 1
    ja %1
%endmacro

%macro jump-if-above-or-equal 1
    jae %1
%endmacro

%macro jump-if-below 1
    jb %1
%endmacro

%macro jump-if-below-or-equal 1
    jbe %1
%endmacro

%macro jump-if-carry 1
    jc %1
%endmacro

%macro jump-if-not-carry 1
    jnc %1
%endmacro

%macro jump-if-overflow 1
    jo %1
%endmacro

%macro jump-if-not-overflow 1
    jno %1
%endmacro

%macro jump-if-sign 1
    js %1
%endmacro

%macro jump-if-not-sign 1
    jns %1
%endmacro

%macro jump-if-parity 1
    jp %1
%endmacro

%macro jump-if-parity-even 1
    jpe %1
%endmacro

%macro jump-if-no-parity 1
    jnp %1
%endmacro

%macro jump-if-parity-odd 1
    jpo %1
%endmacro

%macro jump-if-not-above 1
    jna %1
%endmacro

%macro jump-if-not-above-or-equal 1
    jnae %1
%endmacro

%macro jump-if-not-below 1
    jnb %1
%endmacro

%macro jump-if-not-below-or-equal 1
    jnbe %1
%endmacro

%macro jump-if-not-greater 1
    jng %1
%endmacro

%macro jump-if-not-greater-or-equal 1
    jnge %1
%endmacro

%macro jump-if-not-less 1
    jnl %1
%endmacro

%macro jump-if-not-less-or-equal 1
    jnle %1
%endmacro

%macro jump-if-cx-zero 1
    jcxz %1
%endmacro

%macro jump-if-ecx-zero 1
    jecxz %1
%endmacro

%macro jump-if-rcx-zero 1
    jrcxz %1
%endmacro

%macro end-branch-32 0
    endbr32
%endmacro

%macro end-branch-64 0
    endbr64
%endmacro

; ============================================================================
; SECTION 11: LOOP INSTRUCTIONS
; ============================================================================

%macro loop 1
    loop %1
%endmacro

%macro loop-if-equal 1
    loope %1
%endmacro

%macro loop-if-zero 1
    loopz %1
%endmacro

%macro loop-if-not-equal 1
    loopne %1
%endmacro

%macro loop-if-not-zero 1
    loopnz %1
%endmacro

; ============================================================================
; SECTION 12: PROCEDURE CALLS
; ============================================================================

%macro call-procedure 1
    call %1
%endmacro

%macro return-from-procedure 0-1
%if %0 = 1
    ret %1
%else
    ret
%endif
%endmacro

%macro return-far 0-1
%if %0 = 1
    retf %1
%else
    retf
%endif
%endmacro

; ============================================================================
; SECTION 13: STACK OPERATIONS
; ============================================================================

%macro push-onto-stack 1
    push %1
%endmacro

%macro pop-from-stack 1
    pop %1
%endmacro

%macro push-all-registers 0
    pusha
%endmacro

%macro pop-all-registers 0
    popa
%endmacro

%macro push-flags 0
    pushf
%endmacro

%macro push-flags-word 0
    pushfw
%endmacro

%macro push-flags-dword 0
    pushfd
%endmacro

%macro push-flags-qword 0
    pushfq
%endmacro

%macro pop-flags 0
    popf
%endmacro

%macro pop-flags-word 0
    popfw
%endmacro

%macro pop-flags-dword 0
    popfd
%endmacro

%macro pop-flags-qword 0
    popfq
%endmacro

%macro enter-stack-frame 2
    enter %1, %2
%endmacro

%macro leave-stack-frame 0
    leave
%endmacro

; ============================================================================
; SECTION 14: FLAG CONTROL INSTRUCTIONS
; ============================================================================

%macro clear-carry-flag 0
    clc
%endmacro

%macro set-carry-flag 0
    stc
%endmacro

%macro complement-carry-flag 0
    cmc
%endmacro

%macro clear-direction-flag 0
    cld
%endmacro

%macro set-direction-flag 0
    std
%endmacro

%macro clear-interrupt-flag 0
    cli
%endmacro

%macro set-interrupt-flag 0
    sti
%endmacro

%macro clear-ac-flag 0
    clac
%endmacro

%macro set-ac-flag 0
    stac
%endmacro

%macro clear-task-switched-flag 0
    clts
%endmacro

%macro clear-user-interrupt-flag 0
    clui
%endmacro

; ============================================================================
; SECTION 15: SET CONDITION CODE INSTRUCTIONS (SETcc)
; ============================================================================

%macro set-if-equal 1
    sete %1
%endmacro

%macro set-if-zero 1
    setz %1
%endmacro

%macro set-if-not-equal 1
    setne %1
%endmacro

%macro set-if-not-zero 1
    setnz %1
%endmacro

%macro set-if-greater 1
    setg %1
%endmacro

%macro set-if-greater-or-equal 1
    setge %1
%endmacro

%macro set-if-less 1
    setl %1
%endmacro

%macro set-if-less-or-equal 1
    setle %1
%endmacro

%macro set-if-above 1
    seta %1
%endmacro

%macro set-if-above-or-equal 1
    setae %1
%endmacro

%macro set-if-below 1
    setb %1
%endmacro

%macro set-if-below-or-equal 1
    setbe %1
%endmacro

%macro set-if-carry 1
    setc %1
%endmacro

%macro set-if-not-carry 1
    setnc %1
%endmacro

%macro set-if-overflow 1
    seto %1
%endmacro

%macro set-if-not-overflow 1
    setno %1
%endmacro

%macro set-if-sign 1
    sets %1
%endmacro

%macro set-if-not-sign 1
    setns %1
%endmacro

%macro set-if-parity 1
    setp %1
%endmacro

%macro set-if-parity-even 1
    setpe %1
%endmacro

%macro set-if-no-parity 1
    setnp %1
%endmacro

%macro set-if-parity-odd 1
    setpo %1
%endmacro

%macro set-if-not-above 1
    setna %1
%endmacro

%macro set-if-not-above-or-equal 1
    setnae %1
%endmacro

%macro set-if-not-below 1
    setnb %1
%endmacro

%macro set-if-not-below-or-equal 1
    setnbe %1
%endmacro

%macro set-if-not-greater 1
    setng %1
%endmacro

%macro set-if-not-greater-or-equal 1
    setnge %1
%endmacro

%macro set-if-not-less 1
    setnl %1
%endmacro

%macro set-if-not-less-or-equal 1
    setnle %1
%endmacro

; ============================================================================
; SECTION 16: STRING OPERATIONS
; ============================================================================

%macro compare-string 0
    cmps
%endmacro

%macro compare-string-byte 0
    cmpsb
%endmacro

%macro compare-string-word 0
    cmpsw
%endmacro

%macro compare-string-dword 0
    cmpsd
%endmacro

%macro compare-string-qword 0
    cmpsq
%endmacro

%macro scan-string 0
    scas
%endmacro

%macro scan-string-byte 0
    scasb
%endmacro

%macro scan-string-word 0
    scasw
%endmacro

%macro scan-string-dword 0
    scasd
%endmacro

%macro scan-string-qword 0
    scasq
%endmacro

%macro load-string 0
    lods
%endmacro

%macro load-string-byte 0
    lodsb
%endmacro

%macro load-string-word 0
    lodsw
%endmacro

%macro load-string-dword 0
    lodsd
%endmacro

%macro load-string-qword 0
    lodsq
%endmacro

%macro store-string 0
    stos
%endmacro

%macro store-string-byte 0
    stosb
%endmacro

%macro store-string-word 0
    stosw
%endmacro

%macro store-string-dword 0
    stosd
%endmacro

%macro store-string-qword 0
    stosq
%endmacro

; ============================================================================
; SECTION 17: REPEAT PREFIXES
; ============================================================================

%macro repeat 1
    rep %1
%endmacro

%macro repeat-if-equal 1
    repe %1
%endmacro

%macro repeat-if-zero 1
    repz %1
%endmacro

%macro repeat-if-not-equal 1
    repne %1
%endmacro

%macro repeat-if-not-zero 1
    repnz %1
%endmacro

; ============================================================================
; SECTION 18: I/O OPERATIONS
; ============================================================================

%macro input-from-port 2
    in %1, %2
%endmacro

%macro output-to-port 2
    out %1, %2
%endmacro

%macro input-string-from-port-byte 0
    insb
%endmacro

%macro input-string-from-port-word 0
    insw
%endmacro

%macro input-string-from-port-dword 0
    insd
%endmacro

%macro output-string-to-port-byte 0
    outsb
%endmacro

%macro output-string-to-port-word 0
    outsw
%endmacro

%macro output-string-to-port-dword 0
    outsd
%endmacro

; ============================================================================
; SECTION 19: INTERRUPT INSTRUCTIONS
; ============================================================================

%macro interrupt 1
    int %1
%endmacro

%macro interrupt-3 0
    int3
%endmacro

%macro interrupt-1 0
    int1
%endmacro

%macro interrupt-on-overflow 0
    into
%endmacro

%macro return-from-interrupt 0
    iret
%endmacro

%macro return-from-interrupt-dword 0
    iretd
%endmacro

%macro return-from-interrupt-qword 0
    iretq
%endmacro

; ============================================================================
; SECTION 20: SYSTEM AND PRIVILEGED INSTRUCTIONS
; ============================================================================

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

%macro load-machine-status-word 1
    lmsw %1
%endmacro

%macro load-task-register 1
    ltr %1
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

%macro undefined-instruction-2 0
    ud2
%endmacro

%macro serialize-instructions 0
    serialize
%endmacro

%macro monitor 3
    monitor %1, %2, %3
%endmacro

%macro monitor-wait 0
    mwait
%endmacro

; ============================================================================
; SECTION 21: CACHE AND MEMORY MANAGEMENT
; ============================================================================

%macro flush-cache-line 1
    clflush %1
%endmacro

%macro flush-cache-line-optimized 1
    clflushopt %1
%endmacro

%macro cache-line-write-back 1
    clwb %1
%endmacro

%macro cache-line-demote 1
    cldemote %1
%endmacro

%macro load-fence 0
    lfence
%endmacro

%macro store-fence 0
    sfence
%endmacro

%macro memory-fence 0
    mfence
%endmacro

%macro prefetch-t0 1
    prefetcht0 %1
%endmacro

%macro prefetch-t1 1
    prefetcht1 %1
%endmacro

%macro prefetch-t2 1
    prefetcht2 %1
%endmacro

%macro prefetch-nta 1
    prefetchnta %1
%endmacro

%macro prefetch-write 1
    prefetchw %1
%endmacro

; ============================================================================
; SECTION 22: FLAG TRANSFER
; ============================================================================

%macro load-flags-into-ah 0
    lahf
%endmacro

%macro store-ah-into-flags 0
    sahf
%endmacro

; ============================================================================
; SECTION 23: X87 FPU - DATA TRANSFER INSTRUCTIONS
; ============================================================================

%macro fpu-load 1
    fld %1
%endmacro

%macro fpu-store 1
    fst %1
%endmacro

%macro fpu-store-and-pop 1
    fstp %1
%endmacro

%macro fpu-load-integer 1
    fild %1
%endmacro

%macro fpu-store-integer 1
    fist %1
%endmacro

%macro fpu-store-integer-and-pop 1
    fistp %1
%endmacro

%macro fpu-store-integer-truncate-and-pop 1
    fisttp %1
%endmacro

%macro fpu-load-bcd 1
    fbld %1
%endmacro

%macro fpu-store-bcd-and-pop 1
    fbstp %1
%endmacro

%macro fpu-exchange 0-1
%if %0 = 1
    fxch %1
%else
    fxch
%endif
%endmacro

; ============================================================================
; SECTION 24: X87 FPU - CONSTANT LOAD INSTRUCTIONS
; ============================================================================

%macro fpu-load-zero 0
    fldz
%endmacro

%macro fpu-load-one 0
    fld1
%endmacro

%macro fpu-load-pi 0
    fldpi
%endmacro

%macro fpu-load-log2-10 0
    fldl2t
%endmacro

%macro fpu-load-log2-e 0
    fldl2e
%endmacro

%macro fpu-load-log10-2 0
    fldlg2
%endmacro

%macro fpu-load-ln-2 0
    fldln2
%endmacro

; ============================================================================
; SECTION 25: X87 FPU - ARITHMETIC INSTRUCTIONS
; ============================================================================

%macro fpu-add 0-2
%if %0 = 0
    fadd
%elif %0 = 1
    fadd %1
%else
    fadd %1, %2
%endif
%endmacro

%macro fpu-add-and-pop 0-2
%if %0 = 0
    faddp
%elif %0 = 1
    faddp %1
%else
    faddp %1, %2
%endif
%endmacro

%macro fpu-add-integer 1
    fiadd %1
%endmacro

%macro fpu-subtract 0-2
%if %0 = 0
    fsub
%elif %0 = 1
    fsub %1
%else
    fsub %1, %2
%endif
%endmacro

%macro fpu-subtract-and-pop 0-2
%if %0 = 0
    fsubp
%elif %0 = 1
    fsubp %1
%else
    fsubp %1, %2
%endif
%endmacro

%macro fpu-subtract-integer 1
    fisub %1
%endmacro

%macro fpu-reverse-subtract 0-2
%if %0 = 0
    fsubr
%elif %0 = 1
    fsubr %1
%else
    fsubr %1, %2
%endif
%endmacro

%macro fpu-reverse-subtract-and-pop 0-2
%if %0 = 0
    fsubrp
%elif %0 = 1
    fsubrp %1
%else
    fsubrp %1, %2
%endif
%endmacro

%macro fpu-reverse-subtract-integer 1
    fisubr %1
%endmacro

%macro fpu-multiply 0-2
%if %0 = 0
    fmul
%elif %0 = 1
    fmul %1
%else
    fmul %1, %2
%endif
%endmacro

%macro fpu-multiply-and-pop 0-2
%if %0 = 0
    fmulp
%elif %0 = 1
    fmulp %1
%else
    fmulp %1, %2
%endif
%endmacro

%macro fpu-multiply-integer 1
    fimul %1
%endmacro

%macro fpu-divide 0-2
%if %0 = 0
    fdiv
%elif %0 = 1
    fdiv %1
%else
    fdiv %1, %2
%endif
%endmacro

%macro fpu-divide-and-pop 0-2
%if %0 = 0
    fdivp
%elif %0 = 1
    fdivp %1
%else
    fdivp %1, %2
%endif
%endmacro

%macro fpu-divide-integer 1
    fidiv %1
%endmacro

%macro fpu-reverse-divide 0-2
%if %0 = 0
    fdivr
%elif %0 = 1
    fdivr %1
%else
    fdivr %1, %2
%endif
%endmacro

%macro fpu-reverse-divide-and-pop 0-2
%if %0 = 0
    fdivrp
%elif %0 = 1
    fdivrp %1
%else
    fdivrp %1, %2
%endif
%endmacro

%macro fpu-reverse-divide-integer 1
    fidivr %1
%endmacro

%macro fpu-absolute-value 0
    fabs
%endmacro

%macro fpu-change-sign 0
    fchs
%endmacro

%macro fpu-square-root 0
    fsqrt
%endmacro

%macro fpu-scale 0
    fscale
%endmacro

%macro fpu-partial-remainder 0
    fprem
%endmacro

%macro fpu-partial-remainder-ieee 0
    fprem1
%endmacro

%macro fpu-round-to-integer 0
    frndint
%endmacro

; ============================================================================
; SECTION 26: X87 FPU - TRANSCENDENTAL INSTRUCTIONS
; ============================================================================

%macro fpu-sine 0
    fsin
%endmacro

%macro fpu-cosine 0
    fcos
%endmacro

%macro fpu-sine-and-cosine 0
    fsincos
%endmacro

%macro fpu-partial-tangent 0
    fptan
%endmacro

%macro fpu-partial-arctangent 0
    fpatan
%endmacro

%macro fpu-compute-2x-minus-1 0
    f2xm1
%endmacro

%macro fpu-compute-y-times-log2-x 0
    fyl2x
%endmacro

%macro fpu-compute-y-times-log2-x-plus-1 0
    fyl2xp1
%endmacro

; ============================================================================
; SECTION 27: X87 FPU - COMPARISON INSTRUCTIONS
; ============================================================================

%macro fpu-compare 0-1
%if %0 = 0
    fcom
%else
    fcom %1
%endif
%endmacro

%macro fpu-compare-and-pop 0-1
%if %0 = 0
    fcomp
%else
    fcomp %1
%endif
%endmacro

%macro fpu-compare-and-pop-twice 0
    fcompp
%endmacro

%macro fpu-compare-and-set-flags 0-1
%if %0 = 0
    fcomi
%else
    fcomi %1
%endif
%endmacro

%macro fpu-compare-set-flags-and-pop 0-1
%if %0 = 0
    fcomip
%else
    fcomip %1
%endif
%endmacro

%macro fpu-unordered-compare 0-1
%if %0 = 0
    fucom
%else
    fucom %1
%endif
%endmacro

%macro fpu-unordered-compare-and-pop 0-1
%if %0 = 0
    fucomp
%else
    fucomp %1
%endif
%endmacro

%macro fpu-unordered-compare-and-pop-twice 0
    fucompp
%endmacro

%macro fpu-unordered-compare-and-set-flags 0-1
%if %0 = 0
    fucomi
%else
    fucomi %1
%endif
%endmacro

%macro fpu-unordered-compare-set-flags-and-pop 0-1
%if %0 = 0
    fucomip
%else
    fucomip %1
%endif
%endmacro

%macro fpu-compare-integer 1
    ficom %1
%endmacro

%macro fpu-compare-integer-and-pop 1
    ficomp %1
%endmacro

%macro fpu-test 0
    ftst
%endmacro

%macro fpu-examine 0
    fxam
%endmacro

; ============================================================================
; SECTION 28: X87 FPU - CONTROL INSTRUCTIONS
; ============================================================================

%macro fpu-load-control-word 1
    fldcw %1
%endmacro

%macro fpu-store-control-word 1
    fstcw %1
%endmacro

%macro fpu-store-control-word-no-wait 1
    fnstcw %1
%endmacro

%macro fpu-load-environment 1
    fldenv %1
%endmacro

%macro fpu-store-environment 1
    fstenv %1
%endmacro

%macro fpu-store-environment-no-wait 1
    fnstenv %1
%endmacro

%macro fpu-store-status-word 1
    fstsw %1
%endmacro

%macro fpu-store-status-word-no-wait 1
    fnstsw %1
%endmacro

%macro fpu-store-status-word-to-ax 0
    fstsw ax
%endmacro

%macro fpu-store-status-word-to-ax-no-wait 0
    fnstsw ax
%endmacro

%macro fpu-save-state 1
    fsave %1
%endmacro

%macro fpu-save-state-no-wait 1
    fnsave %1
%endmacro

%macro fpu-restore-state 1
    frstor %1
%endmacro

%macro fpu-initialize 0
    finit
%endmacro

%macro fpu-initialize-no-wait 0
    fninit
%endmacro

%macro fpu-clear-exceptions 0
    fclex
%endmacro

%macro fpu-clear-exceptions-no-wait 0
    fnclex
%endmacro

%macro fpu-wait 0
    fwait
%endmacro

%macro fpu-no-operation 0
    fnop
%endmacro

%macro fpu-free-register 0-1
%if %0 = 1
    ffree %1
%else
    ffree
%endif
%endmacro

%macro fpu-decrement-stack-pointer 0
    fdecstp
%endmacro

%macro fpu-increment-stack-pointer 0
    fincstp
%endmacro

%macro fpu-extract-exponent-and-significand 0
    fxtract
%endmacro

; ============================================================================
; SECTION 29: X87 FPU - CONDITIONAL MOVE INSTRUCTIONS
; ============================================================================

%macro fpu-conditional-move-if-below 0-1
%if %0 = 1
    fcmovb %1
%else
    fcmovb
%endif
%endmacro

%macro fpu-conditional-move-if-below-or-equal 0-1
%if %0 = 1
    fcmovbe %1
%else
    fcmovbe
%endif
%endmacro

%macro fpu-conditional-move-if-equal 0-1
%if %0 = 1
    fcmove %1
%else
    fcmove
%endif
%endmacro

%macro fpu-conditional-move-if-not-below-or-equal 0-1
%if %0 = 1
    fcmovnbe %1
%else
    fcmovnbe
%endif
%endmacro

%macro fpu-conditional-move-if-not-equal 0-1
%if %0 = 1
    fcmovne %1
%else
    fcmovne
%endif
%endmacro

%macro fpu-conditional-move-if-not-overflow 0-1
%if %0 = 1
    fcmovnu %1
%else
    fcmovnu
%endif
%endmacro

%macro fpu-conditional-move-if-overflow 0-1
%if %0 = 1
    fcmovu %1
%else
    fcmovu
%endif
%endmacro

; ============================================================================
; SECTION 30: MMX INSTRUCTIONS
; ============================================================================

%macro mmx-empty-state 0
    emms
%endmacro

%macro mmx-move-doubleword 2
    movd %1, %2
%endmacro

%macro mmx-move-quadword 2
    movq %1, %2
%endmacro

%macro mmx-pack-with-signed-saturation-word-to-byte 2
    packsswb %1, %2
%endmacro

%macro mmx-pack-with-signed-saturation-dword-to-word 2
    packssdw %1, %2
%endmacro

%macro mmx-pack-with-unsigned-saturation-word-to-byte 2
    packuswb %1, %2
%endmacro

%macro mmx-compare-equal-bytes 2
    pcmpeqb %1, %2
%endmacro

%macro mmx-compare-equal-words 2
    pcmpeqw %1, %2
%endmacro

%macro mmx-compare-equal-dwords 2
    pcmpeqd %1, %2
%endmacro

%macro mmx-compare-greater-than-bytes 2
    pcmpgtb %1, %2
%endmacro

%macro mmx-compare-greater-than-words 2
    pcmpgtw %1, %2
%endmacro

%macro mmx-compare-greater-than-dwords 2
    pcmpgtd %1, %2
%endmacro

%macro mmx-move-byte-mask 2
    pmovmskb %1, %2
%endmacro

%macro mmx-add-bytes-with-saturation 2
    paddsb %1, %2
%endmacro

%macro mmx-add-words-with-saturation 2
    paddsw %1, %2
%endmacro

%macro mmx-add-bytes-with-unsigned-saturation 2
    paddusb %1, %2
%endmacro

%macro mmx-add-words-with-unsigned-saturation 2
    paddusw %1, %2
%endmacro

%macro mmx-average-bytes 2
    pavgb %1, %2
%endmacro

%macro mmx-average-words 2
    pavgw %1, %2
%endmacro

%macro mmx-multiply-and-add-words 2
    pmaddwd %1, %2
%endmacro

%macro mmx-maximum-signed-bytes 2
    pmaxsb %1, %2
%endmacro

%macro mmx-maximum-signed-words 2
    pmaxsw %1, %2
%endmacro

%macro mmx-maximum-unsigned-bytes 2
    pmaxub %1, %2
%endmacro

%macro mmx-maximum-unsigned-words 2
    pmaxuw %1, %2
%endmacro

%macro mmx-minimum-signed-bytes 2
    pminsb %1, %2
%endmacro

%macro mmx-minimum-signed-words 2
    pminsw %1, %2
%endmacro

%macro mmx-minimum-unsigned-bytes 2
    pminub %1, %2
%endmacro

%macro mmx-minimum-unsigned-words 2
    pminuw %1, %2
%endmacro

%macro mmx-multiply-high-signed-words 2
    pmulhw %1, %2
%endmacro

%macro mmx-multiply-high-unsigned-words 2
    pmulhuw %1, %2
%endmacro

%macro mmx-multiply-low-words 2
    pmullw %1, %2
%endmacro

%macro mmx-shift-left-words 2
    psllw %1, %2
%endmacro

%macro mmx-shift-left-dwords 2
    pslld %1, %2
%endmacro

%macro mmx-shift-left-quadwords 2
    psllq %1, %2
%endmacro

%macro mmx-shift-right-arithmetic-words 2
    psraw %1, %2
%endmacro

%macro mmx-shift-right-arithmetic-dwords 2
    psrad %1, %2
%endmacro

%macro mmx-shift-right-logical-words 2
    psrlw %1, %2
%endmacro

%macro mmx-shift-right-logical-dwords 2
    psrld %1, %2
%endmacro

%macro mmx-shift-right-logical-quadwords 2
    psrlq %1, %2
%endmacro

%macro mmx-subtract-bytes-with-saturation 2
    psubsb %1, %2
%endmacro

%macro mmx-subtract-words-with-saturation 2
    psubsw %1, %2
%endmacro

%macro mmx-subtract-bytes-with-unsigned-saturation 2
    psubusb %1, %2
%endmacro

%macro mmx-subtract-words-with-unsigned-saturation 2
    psubusw %1, %2
%endmacro

%macro mmx-extract-word 3
    pextrw %1, %2, %3
%endmacro

%macro mmx-insert-word 3
    pinsrw %1, %2, %3
%endmacro

%macro mmx-mask-move-quadword 3
    maskmovq %1, %2, %3
%endmacro

%macro mmx-move-quadword-non-temporal 2
    movntq %1, %2
%endmacro

%macro mmx-move-from-xmm-to-mmx 2
    movdq2q %1, %2
%endmacro

%macro mmx-move-from-mmx-to-xmm 2
    movq2dq %1, %2
%endmacro

; ============================================================================
; SECTION 31: SSE INSTRUCTIONS
; ============================================================================

%macro sse-add-packed-single 2
    addps %1, %2
%endmacro

%macro sse-add-scalar-single 2
    addss %1, %2
%endmacro

%macro sse-and-packed-single 2
    andps %1, %2
%endmacro

%macro sse-and-not-packed-single 2
    andnps %1, %2
%endmacro

%macro sse-compare-packed-single 3
    cmpps %1, %2, %3
%endmacro

%macro sse-compare-scalar-single 3
    cmpss %1, %2, %3
%endmacro

%macro sse-compare-ordered-scalar-single 2
    comiss %1, %2
%endmacro

%macro sse-divide-packed-single 2
    divps %1, %2
%endmacro

%macro sse-divide-scalar-single 2
    divss %1, %2
%endmacro

%macro sse-load-unaligned-single 2
    movups %1, %2
%endmacro

%macro sse-load-aligned-single 2
    movaps %1, %2
%endmacro

%macro sse-move-scalar-single 2
    movss %1, %2
%endmacro

%macro sse-move-high-to-low 2
    movhlps %1, %2
%endmacro

%macro sse-move-low-to-high 2
    movlhps %1, %2
%endmacro

%macro sse-move-high-packed-single 2
    movhps %1, %2
%endmacro

%macro sse-move-low-packed-single 2
    movlps %1, %2
%endmacro

%macro sse-move-mask-packed-single 2
    movmskps %1, %2
%endmacro

%macro sse-move-non-temporal-single 2
    movntps %1, %2
%endmacro

%macro sse-maximum-packed-single 2
    maxps %1, %2
%endmacro

%macro sse-maximum-scalar-single 2
    maxss %1, %2
%endmacro

%macro sse-minimum-packed-single 2
    minps %1, %2
%endmacro

%macro sse-minimum-scalar-single 2
    minss %1, %2
%endmacro

%macro sse-multiply-packed-single 2
    mulps %1, %2
%endmacro

%macro sse-multiply-scalar-single 2
    mulss %1, %2
%endmacro

%macro sse-or-packed-single 2
    orps %1, %2
%endmacro

%macro sse-reciprocal-packed-single 1
    rcpps %1
%endmacro

%macro sse-reciprocal-scalar-single 1
    rcpss %1
%endmacro

%macro sse-reciprocal-square-root-packed-single 1
    rsqrtps %1
%endmacro

%macro sse-reciprocal-square-root-scalar-single 1
    rsqrtss %1
%endmacro

%macro sse-shuffle-packed-single 3
    shufps %1, %2, %3
%endmacro

%macro sse-square-root-packed-single 1
    sqrtps %1
%endmacro

%macro sse-square-root-scalar-single 1
    sqrtss %1
%endmacro

%macro sse-subtract-packed-single 2
    subps %1, %2
%endmacro

%macro sse-subtract-scalar-single 2
    subss %1, %2
%endmacro

%macro sse-unpack-high-packed-single 2
    unpckhps %1, %2
%endmacro

%macro sse-unpack-low-packed-single 2
    unpcklps %1, %2
%endmacro

%macro sse-xor-packed-single 2
    xorps %1, %2
%endmacro

; ============================================================================
; SECTION 32: SSE2 INSTRUCTIONS
; ============================================================================

%macro sse2-add-packed-double 2
    addpd %1, %2
%endmacro

%macro sse2-add-scalar-double 2
    addsd %1, %2
%endmacro

%macro sse2-add-packed-dword 2
    paddd %1, %2
%endmacro

%macro sse2-add-packed-qword 2
    paddq %1, %2
%endmacro

%macro sse2-add-packed-word 2
    paddw %1, %2
%endmacro

%macro sse2-add-packed-byte 2
    paddb %1, %2
%endmacro

%macro sse2-and-not-packed-double 2
    andnpd %1, %2
%endmacro

%macro sse2-and-packed-double 2
    andpd %1, %2
%endmacro

%macro sse2-compare-packed-double 3
    cmppd %1, %2, %3
%endmacro

%macro sse2-compare-scalar-double 3
    cmpsd %1, %2, %3
%endmacro

%macro sse2-compare-ordered-scalar-double 2
    comisd %1, %2
%endmacro

%macro sse2-divide-packed-double 2
    divpd %1, %2
%endmacro

%macro sse2-divide-scalar-double 2
    divsd %1, %2
%endmacro

%macro sse2-load-aligned-double 2
    movapd %1, %2
%endmacro

%macro sse2-load-unaligned-double 2
    movupd %1, %2
%endmacro

%macro sse2-move-scalar-double 2
    movsd %1, %2
%endmacro

%macro sse2-move-high-packed-double 2
    movhpd %1, %2
%endmacro

%macro sse2-move-low-packed-double 2
    movlpd %1, %2
%endmacro

%macro sse2-move-mask-packed-double 2
    movmskpd %1, %2
%endmacro

%macro sse2-move-aligned-packed-integer 2
    movdqa %1, %2
%endmacro

%macro sse2-move-unaligned-packed-integer 2
    movdqu %1, %2
%endmacro

%macro sse2-move-double-duplicate 2
    movddup %1, %2
%endmacro

%macro sse2-move-high-and-duplicate 2
    movshdup %1, %2
%endmacro

%macro sse2-move-low-and-duplicate 2
    movsldup %1, %2
%endmacro

%macro sse2-maximum-packed-double 2
    maxpd %1, %2
%endmacro

%macro sse2-maximum-scalar-double 2
    maxsd %1, %2
%endmacro

%macro sse2-minimum-packed-double 2
    minpd %1, %2
%endmacro

%macro sse2-minimum-scalar-double 2
    minsd %1, %2
%endmacro

%macro sse2-multiply-packed-double 2
    mulpd %1, %2
%endmacro

%macro sse2-multiply-scalar-double 2
    mulsd %1, %2
%endmacro

%macro sse2-or-packed-double 2
    orpd %1, %2
%endmacro

%macro sse2-pack-with-signed-saturation-dword 2
    packssdw %1, %2
%endmacro

%macro sse2-pack-with-signed-saturation-word 2
    packsswb %1, %2
%endmacro

%macro sse2-pack-with-unsigned-saturation-dword 2
    packusdw %1, %2
%endmacro

%macro sse2-pack-with-unsigned-saturation-word 2
    packuswb %1, %2
%endmacro

%macro sse2-compare-equal-qword 2
    pcmpeqq %1, %2
%endmacro

%macro sse2-compare-greater-than-qword 2
    pcmpgtq %1, %2
%endmacro

%macro sse2-extract-byte 3
    pextrb %1, %2, %3
%endmacro

%macro sse2-extract-dword 3
    pextrd %1, %2, %3
%endmacro

%macro sse2-extract-qword 3
    pextrq %1, %2, %3
%endmacro

%macro sse2-insert-byte 3
    pinsrb %1, %2, %3
%endmacro

%macro sse2-insert-dword 3
    pinsrd %1, %2, %3
%endmacro

%macro sse2-insert-qword 3
    pinsrq %1, %2, %3
%endmacro

%macro sse2-maximum-signed-dword 2
    pmaxsd %1, %2
%endmacro

%macro sse2-maximum-signed-word 2
    pmaxsw %1, %2
%endmacro

%macro sse2-maximum-unsigned-dword 2
    pmaxud %1, %2
%endmacro

%macro sse2-maximum-unsigned-word 2
    pmaxuw %1, %2
%endmacro

%macro sse2-minimum-signed-dword 2
    pminsd %1, %2
%endmacro

%macro sse2-minimum-signed-word 2
    pminsw %1, %2
%endmacro

%macro sse2-minimum-unsigned-dword 2
    pminud %1, %2
%endmacro

%macro sse2-minimum-unsigned-word 2
    pminuw %1, %2
%endmacro

%macro sse2-move-byte-mask-from-packed 2
    pmovmskb %1, %2
%endmacro

%macro sse2-multiply-packed-dword 2
    pmuludq %1, %2
%endmacro

%macro sse2-multiply-low-packed-dword 2
    pmulld %1, %2
%endmacro

%macro sse2-multiply-high-rounded-and-scale 2
    pmulhrsw %1, %2
%endmacro

%macro sse2-multiply-and-add-packed-signed-unsigned-bytes 2
    pmaddubsw %1, %2
%endmacro

%macro sse2-horizontal-add-packed-words 2
    phaddw %1, %2
%endmacro

%macro sse2-horizontal-add-packed-dwords 2
    phaddd %1, %2
%endmacro

%macro sse2-horizontal-add-and-saturate-packed-words 2
    phaddsw %1, %2
%endmacro

%macro sse2-horizontal-subtract-packed-words 2
    phsubw %1, %2
%endmacro

%macro sse2-horizontal-subtract-packed-dwords 2
    phsubd %1, %2
%endmacro

%macro sse2-horizontal-subtract-and-saturate-packed-words 2
    phsubsw %1, %2
%endmacro

%macro sse2-align-right-packed 3
    palignr %1, %2, %3
%endmacro

%macro sse2-absolute-value-packed-bytes 1
    pabsb %1
%endmacro

%macro sse2-absolute-value-packed-words 1
    pabsw %1
%endmacro

%macro sse2-absolute-value-packed-dwords 1
    pabsd %1
%endmacro

%macro sse2-sign-extend-packed-word-to-dword 2
    pmovsxwd %1, %2
%endmacro

%macro sse2-sign-extend-packed-byte-to-word 2
    pmovsxbw %1, %2
%endmacro

%macro sse2-sign-extend-packed-byte-to-dword 2
    pmovsxbd %1, %2
%endmacro

%macro sse2-sign-extend-packed-byte-to-qword 2
    pmovsxbq %1, %2
%endmacro

%macro sse2-sign-extend-packed-word-to-qword 2
    pmovsxwq %1, %2
%endmacro

%macro sse2-sign-extend-packed-dword-to-qword 2
    pmovsxdq %1, %2
%endmacro

%macro sse2-zero-extend-packed-word-to-dword 2
    pmovzxwd %1, %2
%endmacro

%macro sse2-zero-extend-packed-byte-to-word 2
    pmovzxbw %1, %2
%endmacro

%macro sse2-zero-extend-packed-byte-to-dword 2
    pmovzxbd %1, %2
%endmacro

%macro sse2-zero-extend-packed-byte-to-qword 2
    pmovzxbq %1, %2
%endmacro

%macro sse2-zero-extend-packed-word-to-qword 2
    pmovzxwq %1, %2
%endmacro

%macro sse2-zero-extend-packed-dword-to-qword 2
    pmovzxdq %1, %2
%endmacro

%macro sse2-shuffle-packed-double 3
    shufpd %1, %2, %3
%endmacro

%macro sse2-square-root-packed-double 1
    sqrtpd %1
%endmacro

%macro sse2-square-root-scalar-double 1
    sqrtsd %1
%endmacro

%macro sse2-store-non-temporal-dword 2
    movnti %1, %2
%endmacro

%macro sse2-store-non-temporal-double 2
    movntpd %1, %2
%endmacro

%macro sse2-subtract-packed-double 2
    subpd %1, %2
%endmacro

%macro sse2-subtract-scalar-double 2
    subsd %1, %2
%endmacro

%macro sse2-unpack-high-packed-double 2
    unpckhpd %1, %2
%endmacro

%macro sse2-unpack-low-packed-double 2
    unpcklpd %1, %2
%endmacro

%macro sse2-xor-packed-double 2
    xorpd %1, %2
%endmacro

; ============================================================================
; SECTION 33: SSE3 INSTRUCTIONS
; ============================================================================

%macro sse3-add-subtract-packed-double 2
    addsubpd %1, %2
%endmacro

%macro sse3-add-subtract-packed-single 2
    addsubps %1, %2
%endmacro

%macro sse3-horizontal-add-packed-double 2
    haddpd %1, %2
%endmacro

%macro sse3-horizontal-add-packed-single 2
    haddps %1, %2
%endmacro

%macro sse3-horizontal-subtract-packed-double 2
    hsubpd %1, %2
%endmacro

%macro sse3-horizontal-subtract-packed-single 2
    hsubps %1, %2
%endmacro

%macro sse3-load-duplicate-unaligned 2
    lddqu %1, %2
%endmacro

; ============================================================================
; SECTION 34: SSSE3 INSTRUCTIONS
; ============================================================================

%macro ssse3-shuffle-packed-bytes 2
    pshufb %1, %2
%endmacro

%macro ssse3-sign-packed-bytes 2
    psignb %1, %2
%endmacro

%macro ssse3-sign-packed-words 2
    psignw %1, %2
%endmacro

%macro ssse3-sign-packed-dwords 2
    psignd %1, %2
%endmacro

; ============================================================================
; SECTION 35: SSE4.1 INSTRUCTIONS
; ============================================================================

%macro sse41-blend-packed-bytes 3
    pblendvb %1, %2, %3
%endmacro

%macro sse41-blend-packed-words 3
    pblendw %1, %2, %3
%endmacro

%macro sse41-blend-packed-double 3
    blendpd %1, %2, %3
%endmacro

%macro sse41-blend-packed-single 3
    blendps %1, %2, %3
%endmacro

%macro sse41-dot-product-packed-double 3
    dppd %1, %2, %3
%endmacro

%macro sse41-dot-product-packed-single 3
    dpps %1, %2, %3
%endmacro

%macro sse41-extract-packed-single 3
    extractps %1, %2, %3
%endmacro

%macro sse41-insert-packed-single 4
    insertps %1, %2, %3, %4
%endmacro

%macro sse41-mask-move-packed-dword 3
    maskmovdqu %1, %2, %3
%endmacro

%macro sse41-pack-with-unsigned-saturation-dword 2
    packusdw %1, %2
%endmacro

%macro sse41-test-packed 2
    ptest %1, %2
%endmacro

%macro sse41-round-scalar-double 3
    roundsd %1, %2, %3
%endmacro

%macro sse41-round-scalar-single 3
    roundss %1, %2, %3
%endmacro

%macro sse41-round-packed-double 3
    roundpd %1, %2, %3
%endmacro

%macro sse41-round-packed-single 3
    roundps %1, %2, %3
%endmacro

%macro sse41-compare-implicit-length-string-return-index 3
    pcmpistri %1, %2, %3
%endmacro

%macro sse41-compare-implicit-length-string-return-mask 3
    pcmpistrm %1, %2, %3
%endmacro

%macro sse41-compare-explicit-length-string-return-index 3
    pcmpestri %1, %2, %3
%endmacro

%macro sse41-compare-explicit-length-string-return-mask 3
    pcmpestrm %1, %2, %3
%endmacro

; ============================================================================
; SECTION 36: SSE4.2 INSTRUCTIONS
; ============================================================================

%macro sse42-crc32 2
    crc32 %1, %2
%endmacro

%macro sse42-populate-count 2
    popcnt %1, %2
%endmacro

; ============================================================================
; SECTION 37: AES INSTRUCTIONS
; ============================================================================

%macro aes-encrypt-round 2
    aesenc %1, %2
%endmacro

%macro aes-encrypt-last-round 2
    aesenclast %1, %2
%endmacro

%macro aes-decrypt-round 2
    aesdec %1, %2
%endmacro

%macro aes-decrypt-last-round 2
    aesdeclast %1, %2
%endmacro

%macro aes-inverse-mix-column 2
    aesimc %1, %2
%endmacro

%macro aes-key-generation-assist 3
    aeskeygenassist %1, %2, %3
%endmacro

%macro aes-encrypt-128-key-locker 2
    aesenc128kl %1, %2
%endmacro

%macro aes-encrypt-256-key-locker 2
    aesenc256kl %1, %2
%endmacro

%macro aes-decrypt-128-key-locker 2
    aesdec128kl %1, %2
%endmacro

%macro aes-decrypt-256-key-locker 2
    aesdec256kl %1, %2
%endmacro

%macro aes-encrypt-wide-128-key-locker 2
    aesencwide128kl %1, %2
%endmacro

%macro aes-encrypt-wide-256-key-locker 2
    aesencwide256kl %1, %2
%endmacro

%macro aes-decrypt-wide-128-key-locker 2
    aesdecwide128kl %1, %2
%endmacro

%macro aes-decrypt-wide-256-key-locker 2
    aesdecwide256kl %1, %2
%endmacro

%macro encode-key-128 1
    encodekey128 %1
%endmacro

%macro encode-key-256 1
    encodekey256 %1
%endmacro

%macro load-internal-wrapping-key 1
    loadiwkey %1
%endmacro

; ============================================================================
; SECTION 38: PCLMULQDQ INSTRUCTION
; ============================================================================

%macro carry-less-multiply-quadword 3
    pclmulqdq %1, %2, %3
%endmacro

; ============================================================================
; SECTION 39: AVX INSTRUCTIONS
; ============================================================================

%macro avx-add-packed-double 3
    vaddpd %1, %2, %3
%endmacro

%macro avx-add-packed-single 3
    vaddps %1, %2, %3
%endmacro

%macro avx-add-scalar-double 3
    vaddsd %1, %2, %3
%endmacro

%macro avx-add-scalar-single 3
    vaddss %1, %2, %3
%endmacro

%macro avx-and-packed-double 3
    vandpd %1, %2, %3
%endmacro

%macro avx-and-packed-single 3
    vandps %1, %2, %3
%endmacro

%macro avx-and-not-packed-double 3
    vandnpd %1, %2, %3
%endmacro

%macro avx-and-not-packed-single 3
    vandnps %1, %2, %3
%endmacro

%macro avx-blend-packed-double 4
    vblendpd %1, %2, %3, %4
%endmacro

%macro avx-blend-packed-single 4
    vblendps %1, %2, %3, %4
%endmacro

%macro avx-variable-blend-packed-double 4
    vblendvpd %1, %2, %3, %4
%endmacro

%macro avx-variable-blend-packed-single 4
    vblendvps %1, %2, %3, %4
%endmacro

%macro avx-broadcast-scalar-double 2
    vbroadcastsd %1, %2
%endmacro

%macro avx-broadcast-scalar-single 2
    vbroadcastss %1, %2
%endmacro

%macro avx-compare-packed-double 4
    vcmppd %1, %2, %3, %4
%endmacro

%macro avx-compare-packed-single 4
    vcmpps %1, %2, %3, %4
%endmacro

%macro avx-compare-scalar-double 4
    vcmpsd %1, %2, %3, %4
%endmacro

%macro avx-compare-scalar-single 4
    vcmpss %1, %2, %3, %4
%endmacro

%macro avx-compare-ordered-scalar-double 2
    vcomisd %1, %2
%endmacro

%macro avx-compare-ordered-scalar-single 2
    vcomiss %1, %2
%endmacro

%macro avx-divide-packed-double 3
    vdivpd %1, %2, %3
%endmacro

%macro avx-divide-packed-single 3
    vdivps %1, %2, %3
%endmacro

%macro avx-divide-scalar-double 3
    vdivsd %1, %2, %3
%endmacro

%macro avx-divide-scalar-single 3
    vdivss %1, %2, %3
%endmacro

%macro avx-dot-product-packed-double 4
    vdppd %1, %2, %3, %4
%endmacro

%macro avx-dot-product-packed-single 4
    vdpps %1, %2, %3, %4
%endmacro

%macro avx-horizontal-add-packed-double 3
    vhaddpd %1, %2, %3
%endmacro

%macro avx-horizontal-add-packed-single 3
    vhaddps %1, %2, %3
%endmacro

%macro avx-horizontal-subtract-packed-double 3
    vhsubpd %1, %2, %3
%endmacro

%macro avx-horizontal-subtract-packed-single 3
    vhsubps %1, %2, %3
%endmacro

%macro avx-insert-packed-single 4
    vinsertps %1, %2, %3, %4
%endmacro

%macro avx-load-aligned 2
    vmovaps %1, %2
%endmacro

%macro avx-load-unaligned 2
    vmovups %1, %2
%endmacro

%macro avx-load-aligned-double 2
    vmovapd %1, %2
%endmacro

%macro avx-load-unaligned-double 2
    vmovupd %1, %2
%endmacro

%macro avx-load-aligned-integer 2
    vmovdqa %1, %2
%endmacro

%macro avx-load-unaligned-integer 2
    vmovdqu %1, %2
%endmacro

%macro avx-maximum-packed-double 3
    vmaxpd %1, %2, %3
%endmacro

%macro avx-maximum-packed-single 3
    vmaxps %1, %2, %3
%endmacro

%macro avx-maximum-scalar-double 3
    vmaxsd %1, %2, %3
%endmacro

%macro avx-maximum-scalar-single 3
    vmaxss %1, %2, %3
%endmacro

%macro avx-minimum-packed-double 3
    vminpd %1, %2, %3
%endmacro

%macro avx-minimum-packed-single 3
    vminps %1, %2, %3
%endmacro

%macro avx-minimum-scalar-double 3
    vminsd %1, %2, %3
%endmacro

%macro avx-minimum-scalar-single 3
    vminss %1, %2, %3
%endmacro

%macro avx-multiply-packed-double 3
    vmulpd %1, %2, %3
%endmacro

%macro avx-multiply-packed-single 3
    vmulps %1, %2, %3
%endmacro

%macro avx-multiply-scalar-double 3
    vmulsd %1, %2, %3
%endmacro

%macro avx-multiply-scalar-single 3
    vmulss %1, %2, %3
%endmacro

%macro avx-or-packed-double 3
    vorpd %1, %2, %3
%endmacro

%macro avx-or-packed-single 3
    vorps %1, %2, %3
%endmacro

%macro avx-permute-double 3
    vpermilpd %1, %2, %3
%endmacro

%macro avx-permute-single 3
    vpermilps %1, %2, %3
%endmacro

%macro avx-permute-2x128 4
    vperm2f128 %1, %2, %3, %4
%endmacro

%macro avx-reciprocal-packed-single 2
    vrcpps %1, %2
%endmacro

%macro avx-reciprocal-scalar-single 3
    vrcpss %1, %2, %3
%endmacro

%macro avx-reciprocal-square-root-packed-single 2
    vrsqrtps %1, %2
%endmacro

%macro avx-reciprocal-square-root-scalar-single 3
    vrsqrtss %1, %2, %3
%endmacro

%macro avx-round-packed-double 3
    vroundpd %1, %2, %3
%endmacro

%macro avx-round-packed-single 3
    vroundps %1, %2, %3
%endmacro

%macro avx-round-scalar-double 3
    vroundsd %1, %2, %3
%endmacro

%macro avx-round-scalar-single 3
    vroundss %1, %2, %3
%endmacro

%macro avx-shuffle-packed-double 4
    vshufpd %1, %2, %3, %4
%endmacro

%macro avx-shuffle-packed-single 4
    vshufps %1, %2, %3, %4
%endmacro

%macro avx-square-root-packed-double 2
    vsqrtpd %1, %2
%endmacro

%macro avx-square-root-packed-single 2
    vsqrtps %1, %2
%endmacro

%macro avx-square-root-scalar-double 3
    vsqrtsd %1, %2, %3
%endmacro

%macro avx-square-root-scalar-single 3
    vsqrtss %1, %2, %3
%endmacro

%macro avx-subtract-packed-double 3
    vsubpd %1, %2, %3
%endmacro

%macro avx-subtract-packed-single 3
    vsubps %1, %2, %3
%endmacro

%macro avx-subtract-scalar-double 3
    vsubsd %1, %2, %3
%endmacro

%macro avx-subtract-scalar-single 3
    vsubss %1, %2, %3
%endmacro

%macro avx-test-packed-double 3
    vtestpd %1, %2, %3
%endmacro

%macro avx-test-packed-single 3
    vtestps %1, %2, %3
%endmacro

%macro avx-unpack-high-packed-double 3
    vunpckhpd %1, %2, %3
%endmacro

%macro avx-unpack-high-packed-single 3
    vunpckhps %1, %2, %3
%endmacro

%macro avx-unpack-low-packed-double 3
    vunpcklpd %1, %2, %3
%endmacro

%macro avx-unpack-low-packed-single 3
    vunpcklps %1, %2, %3
%endmacro

%macro avx-xor-packed-double 3
    vxorpd %1, %2, %3
%endmacro

%macro avx-xor-packed-single 3
    vxorps %1, %2, %3
%endmacro

%macro avx-zero-upper 0
    vzeroupper
%endmacro

%macro avx-zero-all 0
    vzeroall
%endmacro

; ============================================================================
; SECTION 40: AVX2 INSTRUCTIONS
; ============================================================================

%macro avx2-gather-dword-single 5
    vgatherdps %1, %2, %3, %4, %5
%endmacro

%macro avx2-gather-qword-single 5
    vgatherqps %1, %2, %3, %4, %5
%endmacro

%macro avx2-gather-dword-double 5
    vgatherdpd %1, %2, %3, %4, %5
%endmacro

%macro avx2-gather-qword-double 5
    vgatherqpd %1, %2, %3, %4, %5
%endmacro

%macro avx2-permute-2x128 4
    vperm2i128 %1, %2, %3, %4
%endmacro

%macro avx2-broadcast-i128 2
    vbroadcasti128 %1, %2
%endmacro

%macro avx2-extract-i128 3
    vextracti128 %1, %2, %3
%endmacro

%macro avx2-insert-i128 4
    vinserti128 %1, %2, %3, %4
%endmacro

%macro avx2-mask-load-dword 3
    vpmaskmovd %1, %2, %3
%endmacro

%macro avx2-mask-load-qword 3
    vpmaskmovq %1, %2, %3
%endmacro

%macro avx2-mask-store-dword 3
    vpmaskmovd %1, %2, %3
%endmacro

%macro avx2-mask-store-qword 3
    vpmaskmovq %1, %2, %3
%endmacro

%macro avx2-permute-variable-dword 3
    vpermd %1, %2, %3
%endmacro

%macro avx2-permute-variable-qword 3
    vpermq %1, %2, %3
%endmacro

%macro avx2-shift-left-variable-dword 3
    vpsllvd %1, %2, %3
%endmacro

%macro avx2-shift-left-variable-qword 3
    vpsllvq %1, %2, %3
%endmacro

%macro avx2-shift-right-arithmetic-variable-dword 3
    vpsravd %1, %2, %3
%endmacro

%macro avx2-shift-right-logical-variable-dword 3
    vpsrlvd %1, %2, %3
%endmacro

%macro avx2-shift-right-logical-variable-qword 3
    vpsrlvq %1, %2, %3
%endmacro

; ============================================================================
; SECTION 41: FMA (FUSED MULTIPLY-ADD) INSTRUCTIONS
; ============================================================================

%macro fma-add-subtract-packed-double 4
    vfmaddsubpd %1, %2, %3, %4
%endmacro

%macro fma-add-subtract-packed-single 4
    vfmaddsubps %1, %2, %3, %4
%endmacro

%macro fma-subtract-add-packed-double 4
    vfmsubaddpd %1, %2, %3, %4
%endmacro

%macro fma-subtract-add-packed-single 4
    vfmsubaddps %1, %2, %3, %4
%endmacro

%macro fma-multiply-add-packed-double 4
    vfmaddpd %1, %2, %3, %4
%endmacro

%macro fma-multiply-add-packed-single 4
    vfmaddps %1, %2, %3, %4
%endmacro

%macro fma-multiply-add-scalar-double 4
    vfmaddsd %1, %2, %3, %4
%endmacro

%macro fma-multiply-add-scalar-single 4
    vfmaddss %1, %2, %3, %4
%endmacro

%macro fma-multiply-subtract-packed-double 4
    vfmsubpd %1, %2, %3, %4
%endmacro

%macro fma-multiply-subtract-packed-single 4
    vfmsubps %1, %2, %3, %4
%endmacro

%macro fma-multiply-subtract-scalar-double 4
    vfmsubsd %1, %2, %3, %4
%endmacro

%macro fma-multiply-subtract-scalar-single 4
    vfmsubss %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-add-packed-double 4
    vfnmaddpd %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-add-packed-single 4
    vfnmaddps %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-add-scalar-double 4
    vfnmaddsd %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-add-scalar-single 4
    vfnmaddss %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-subtract-packed-double 4
    vfnmsubpd %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-subtract-packed-single 4
    vfnmsubps %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-subtract-scalar-double 4
    vfnmsubsd %1, %2, %3, %4
%endmacro

%macro fma-negative-multiply-subtract-scalar-single 4
    vfnmsubss %1, %2, %3, %4
%endmacro

; ============================================================================
; SECTION 42: AVX-512 MASK REGISTER OPERATIONS
; ============================================================================

%macro avx512-mask-add-byte 3
    kaddb %1, %2, %3
%endmacro

%macro avx512-mask-add-word 3
    kaddw %1, %2, %3
%endmacro

%macro avx512-mask-add-dword 3
    kaddd %1, %2, %3
%endmacro

%macro avx512-mask-add-qword 3
    kaddq %1, %2, %3
%endmacro

%macro avx512-mask-and-byte 3
    kandb %1, %2, %3
%endmacro

%macro avx512-mask-and-word 3
    kandw %1, %2, %3
%endmacro

%macro avx512-mask-and-dword 3
    kandd %1, %2, %3
%endmacro

%macro avx512-mask-and-qword 3
    kandq %1, %2, %3
%endmacro

%macro avx512-mask-and-not-byte 3
    kandnb %1, %2, %3
%endmacro

%macro avx512-mask-and-not-word 3
    kandnw %1, %2, %3
%endmacro

%macro avx512-mask-and-not-dword 3
    kandnd %1, %2, %3
%endmacro

%macro avx512-mask-and-not-qword 3
    kandnq %1, %2, %3
%endmacro

%macro avx512-mask-move-byte 2
    kmovb %1, %2
%endmacro

%macro avx512-mask-move-word 2
    kmovw %1, %2
%endmacro

%macro avx512-mask-move-dword 2
    kmovd %1, %2
%endmacro

%macro avx512-mask-move-qword 2
    kmovq %1, %2
%endmacro

%macro avx512-mask-not-byte 2
    knotb %1, %2
%endmacro

%macro avx512-mask-not-word 2
    knotw %1, %2
%endmacro

%macro avx512-mask-not-dword 2
    knotd %1, %2
%endmacro

%macro avx512-mask-not-qword 2
    knotq %1, %2
%endmacro

%macro avx512-mask-or-byte 3
    korb %1, %2, %3
%endmacro

%macro avx512-mask-or-word 3
    korw %1, %2, %3
%endmacro

%macro avx512-mask-or-dword 3
    kord %1, %2, %3
%endmacro

%macro avx512-mask-or-qword 3
    korq %1, %2, %3
%endmacro

%macro avx512-mask-or-test-byte 2
    kortestb %1, %2
%endmacro

%macro avx512-mask-or-test-word 2
    kortestw %1, %2
%endmacro

%macro avx512-mask-or-test-dword 2
    kortestd %1, %2
%endmacro

%macro avx512-mask-or-test-qword 2
    kortestq %1, %2
%endmacro

%macro avx512-mask-shift-left-byte 3
    kshiftlb %1, %2, %3
%endmacro

%macro avx512-mask-shift-left-word 3
    kshiftlw %1, %2, %3
%endmacro

%macro avx512-mask-shift-left-dword 3
    kshiftld %1, %2, %3
%endmacro

%macro avx512-mask-shift-left-qword 3
    kshiftlq %1, %2, %3
%endmacro

%macro avx512-mask-shift-right-byte 3
    kshiftrb %1, %2, %3
%endmacro

%macro avx512-mask-shift-right-word 3
    kshiftrw %1, %2, %3
%endmacro

%macro avx512-mask-shift-right-dword 3
    kshiftrd %1, %2, %3
%endmacro

%macro avx512-mask-shift-right-qword 3
    kshiftrq %1, %2, %3
%endmacro

%macro avx512-mask-test-byte 2
    ktestb %1, %2
%endmacro

%macro avx512-mask-test-word 2
    ktestw %1, %2
%endmacro

%macro avx512-mask-test-dword 2
    ktestd %1, %2
%endmacro

%macro avx512-mask-test-qword 2
    ktestq %1, %2
%endmacro

%macro avx512-mask-unpack-byte-word 3
    kunpckbw %1, %2, %3
%endmacro

%macro avx512-mask-unpack-word-dword 3
    kunpckwd %1, %2, %3
%endmacro

%macro avx512-mask-unpack-dword-qword 3
    kunpckdq %1, %2, %3
%endmacro

%macro avx512-mask-xnor-byte 3
    kxnorb %1, %2, %3
%endmacro

%macro avx512-mask-xnor-word 3
    kxnorw %1, %2, %3
%endmacro

%macro avx512-mask-xnor-dword 3
    kxnord %1, %2, %3
%endmacro

%macro avx512-mask-xnor-qword 3
    kxnorq %1, %2, %3
%endmacro

%macro avx512-mask-xor-byte 3
    kxorb %1, %2, %3
%endmacro

%macro avx512-mask-xor-word 3
    kxorw %1, %2, %3
%endmacro

%macro avx512-mask-xor-dword 3
    kxord %1, %2, %3
%endmacro

%macro avx512-mask-xor-qword 3
    kxorq %1, %2, %3
%endmacro

; --- AVX-512 Data Movement ---
%macro avx512-move-aligned-dword 2
    vmovdqa32 %1, %2
%endmacro

%macro avx512-move-aligned-qword 2
    vmovdqa64 %1, %2
%endmacro

%macro avx512-move-unaligned-byte 2
    vmovdqu8 %1, %2
%endmacro

%macro avx512-move-unaligned-word 2
    vmovdqu16 %1, %2
%endmacro

%macro avx512-move-unaligned-dword 2
    vmovdqu32 %1, %2
%endmacro

%macro avx512-move-unaligned-qword 2
    vmovdqu64 %1, %2
%endmacro

; --- AVX-512 Compress/Expand ---
%macro avx512-compress-packed-single 2
    vcompressps %1, %2
%endmacro

%macro avx512-compress-packed-double 2
    vcompresspd %1, %2
%endmacro

%macro avx512-expand-packed-single 2
    vexpandps %1, %2
%endmacro

%macro avx512-expand-packed-double 2
    vexpandpd %1, %2
%endmacro

; --- AVX-512 Ternary Logic ---
%macro avx512-ternary-logic-dword 4
    vpternlogd %1, %2, %3, %4
%endmacro

%macro avx512-ternary-logic-qword 4
    vpternlogq %1, %2, %3, %4
%endmacro

; --- AVX-512 FP Classify ---
%macro avx512-fp-classify-single 3
    vfpclassps %1, %2, %3
%endmacro

%macro avx512-fp-classify-double 3
    vfpclasspd %1, %2, %3
%endmacro

%macro avx512-fp-classify-scalar-single 3
    vfpclassss %1, %2, %3
%endmacro

%macro avx512-fp-classify-scalar-double 3
    vfpclasssd %1, %2, %3
%endmacro

; --- AVX-512 Reduce ---
%macro avx512-reduce-packed-single 3
    vreduceps %1, %2, %3
%endmacro

%macro avx512-reduce-packed-double 3
    vreducepd %1, %2, %3
%endmacro

%macro avx512-reduce-scalar-single 3
    vreducess %1, %2, %3
%endmacro

%macro avx512-reduce-scalar-double 3
    vreducesd %1, %2, %3
%endmacro

; --- AVX-512 Round Scale ---
%macro avx512-round-scale-packed-single 3
    vrndscaleps %1, %2, %3
%endmacro

%macro avx512-round-scale-packed-double 3
    vrndscalepd %1, %2, %3
%endmacro

%macro avx512-round-scale-scalar-single 3
    vrndscaless %1, %2, %3
%endmacro

%macro avx512-round-scale-scalar-double 3
    vrndscalesd %1, %2, %3
%endmacro

; --- AVX-512 Scale ---
%macro avx512-scale-packed-single 3
    vscalefps %1, %2, %3
%endmacro

%macro avx512-scale-packed-double 3
    vscalefpd %1, %2, %3
%endmacro

%macro avx512-scale-scalar-single 3
    vscalefss %1, %2, %3
%endmacro

%macro avx512-scale-scalar-double 3
    vscalefsd %1, %2, %3
%endmacro

; --- AVX-512 Scatter/Gather ---
%macro avx512-scatter-dword-single 5
    vscatterdps %1, %2, %3, %4, %5
%endmacro

%macro avx512-scatter-qword-single 5
    vscatterqps %1, %2, %3, %4, %5
%endmacro

%macro avx512-scatter-dword-double 5
    vscatterdpd %1, %2, %3, %4, %5
%endmacro

%macro avx512-scatter-qword-double 5
    vscatterqpd %1, %2, %3, %4, %5
%endmacro

; --- AVX-512 Integer Operations ---
%macro avx512-abs-packed-byte 2
    vpabsb %1, %2
%endmacro

%macro avx512-abs-packed-word 2
    vpabsw %1, %2
%endmacro

%macro avx512-abs-packed-dword 2
    vpabsd %1, %2
%endmacro

%macro avx512-abs-packed-qword 2
    vpabsq %1, %2
%endmacro

%macro avx512-add-packed-byte 3
    vpaddb %1, %2, %3
%endmacro

%macro avx512-add-packed-word 3
    vpaddw %1, %2, %3
%endmacro

%macro avx512-add-packed-dword 3
    vpaddd %1, %2, %3
%endmacro

%macro avx512-add-packed-qword 3
    vpaddq %1, %2, %3
%endmacro

%macro avx512-compare-equal-byte 4
    vpcmpeqb %1, %2, %3, %4
%endmacro

%macro avx512-compare-equal-word 4
    vpcmpeqw %1, %2, %3, %4
%endmacro

%macro avx512-compare-equal-dword 4
    vpcmpeqd %1, %2, %3, %4
%endmacro

%macro avx512-compare-equal-qword 4
    vpcmpeqq %1, %2, %3, %4
%endmacro

%macro avx512-compare-greater-than-byte 4
    vpcmpgtb %1, %2, %3, %4
%endmacro

%macro avx512-compare-greater-than-word 4
    vpcmpgtw %1, %2, %3, %4
%endmacro

%macro avx512-compare-greater-than-dword 4
    vpcmpgtd %1, %2, %3, %4
%endmacro

%macro avx512-compare-greater-than-qword 4
    vpcmpgtq %1, %2, %3, %4
%endmacro

; ============================================================================
; SECTION 43: SHA INSTRUCTIONS
; ============================================================================

%macro sha-message-schedule-1 2
    sha1msg1 %1, %2
%endmacro

%macro sha-message-schedule-2 2
    sha1msg2 %1, %2
%endmacro

%macro sha-next-round 2
    sha1nexte %1, %2
%endmacro

%macro sha-round-1 3
    sha1rnds4 %1, %2, %3
%endmacro

%macro sha-message-schedule-256-1 2
    sha256msg1 %1, %2
%endmacro

%macro sha-message-schedule-256-2 2
    sha256msg2 %1, %2
%endmacro

%macro sha-round-256 3
    sha256rnds2 %1, %2, %3
%endmacro

; ============================================================================
; SECTION 44: GFNI (GALOIS FIELD) INSTRUCTIONS
; ============================================================================

%macro gfni-affine-transformation 3
    gf2p8affineqb %1, %2, %3
%endmacro

%macro gfni-affine-transformation-inverse 3
    gf2p8affineinvqb %1, %2, %3
%endmacro

%macro gfni-multiply-bytes 2
    gf2p8mulb %1, %2
%endmacro

; ============================================================================
; SECTION 45: MPX (MEMORY PROTECTION EXTENSIONS) INSTRUCTIONS
; ============================================================================

%macro mpx-make-bounds 2
    bndmk %1, %2
%endmacro

%macro mpx-check-lower-bound 2
    bndcl %1, %2
%endmacro

%macro mpx-check-upper-bound 2
    bndcu %1, %2
%endmacro

%macro mpx-check-upper-bound-cn 2
    bndcn %1, %2
%endmacro

%macro mpx-move-bounds 2
    bndmov %1, %2
%endmacro

%macro mpx-load-extended-bounds 2
    bndldx %1, %2
%endmacro

%macro mpx-store-extended-bounds 2
    bndstx %1, %2
%endmacro

; ============================================================================
; SECTION 46: BMI1/BMI2 (BIT MANIPULATION) INSTRUCTIONS
; ============================================================================

%macro bmi-and-not 3
    andn %1, %2, %3
%endmacro

%macro bmi-multiply-without-affecting-flags 3
    mulx %1, %2, %3
%endmacro

%macro bmi-parallel-bits-deposit 3
    pdep %1, %2, %3
%endmacro

%macro bmi-parallel-bits-extract 3
    pext %1, %2, %3
%endmacro

%macro bmi-rotate-right-without-affecting-flags 3
    rorx %1, %2, %3
%endmacro

%macro bmi-shift-left 3
    shlx %1, %2, %3
%endmacro

%macro bmi-shift-right-arithmetic 3
    sarx %1, %2, %3
%endmacro

%macro bmi-shift-right-logical 3
    shrx %1, %2, %3
%endmacro

; ============================================================================
; SECTION 47: ADX (MULTI-PRECISION ADD) INSTRUCTIONS
; ============================================================================

%macro adx-add-with-carry-flag 2
    adcx %1, %2
%endmacro

%macro adx-add-with-overflow-flag 2
    adox %1, %2
%endmacro

; ============================================================================
; SECTION 48: FPU CONTROL INSTRUCTIONS
; ============================================================================

%macro fpu-load-mxcsr 1
    ldmxcsr %1
%endmacro

%macro fpu-store-mxcsr 1
    stmxcsr %1
%endmacro

%macro mmx-empty 0
    emms
%endmacro

; ============================================================================
; SECTION 49: BOUND INSTRUCTION
; ============================================================================

%macro check-bounds 2
    bound %1, %2
%endmacro

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

; ============================================================================
; SECTION 51: SGX (SOFTWARE GUARD EXTENSIONS) INSTRUCTIONS
; ============================================================================

%macro sgx-enclave-leaf 1
    enclu %1
%endmacro

%macro sgx-provision-leaf 1
    encls %1
%endmacro

; ============================================================================
; SECTION 52: SAVE/RESTORE STATE INSTRUCTIONS
; ============================================================================

%macro save-x87-mmx-sse-state 1
    fxsave %1
%endmacro

%macro restore-x87-mmx-sse-state 1
    fxrstor %1
%endmacro

%macro save-x87-mmx-sse-state-optimized 1
    xsave %1
%endmacro

%macro restore-x87-mmx-sse-state-optimized 1
    xrstor %1
%endmacro

%macro save-x87-mmx-sse-state-supervisor 1
    xsavec %1
%endmacro

%macro save-x87-mmx-sse-state-compacted 1
    xsaveopt %1
%endmacro

%macro restore-x87-mmx-sse-state-compacted 1
    xrstors %1
%endmacro

%macro save-x87-mmx-sse-state-supervisor-compacted 1
    xsaves %1
%endmacro

; ============================================================================
; SECTION 53: TRANSACTIONAL SYNCHRONIZATION EXTENSIONS (TSX)
; ============================================================================

%macro transactional-suspend 0
    xsuspend
%endmacro

%macro transactional-begin 1
    xbegin %1
%endmacro

%macro transactional-end 0
    xend
%endmacro

%macro transactional-abort 1
    xabort %1
%endmacro

%macro restricted-transactional-begin 1
    xbegin %1
%endmacro

%macro restricted-transactional-end 0
    xend
%endmacro

; ============================================================================
; SECTION 54: USER INTERRUPT INSTRUCTIONS
; ============================================================================

%macro send-user-interrupt 2
    senduipi %1, %2
%endmacro

%macro user-interrupt-return 0
    uiret
%endmacro

%macro set-user-interrupt-request 1
    stui %1
%endmacro

%macro clear-user-interrupt-request 0
    clui
%endmacro

; ============================================================================
; SECTION 55: PTWRITE INSTRUCTION
; ============================================================================

%macro pt-write 1
    ptwrite %1
%endmacro

; ============================================================================
; SECTION 56: SERIALIZE INSTRUCTION
; ============================================================================

%macro serialize-all 0
    serialize
%endmacro

; ============================================================================
; SECTION 57: VMX VIRTUALIZATION INSTRUCTIONS
; ============================================================================

%macro vm-call 0
    vmcall
%endmacro

%macro vm-clear 1
    vmclear %1
%endmacro

%macro vm-launch 0
    vmlaunch
%endmacro

%macro vm-resume 0
    vmresume
%endmacro

%macro vm-off 0
    vmoff
%endmacro

%macro vm-on 0
    vmon
%endmacro

%macro vm-pointer-load 1
    vmptrld %1
%endmacro

%macro vm-pointer-store 1
    vmptrst %1
%endmacro

%macro vm-read-field 2
    vmread %1, %2
%endmacro

%macro vm-write-field 2
    vmwrite %1, %2
%endmacro

%macro vm-exit-interrupt-info 1
    vmxoff %1
%endmacro

; ============================================================================
; SECTION 58: XSAVE/XRSTOR STATE MANAGEMENT
; ============================================================================

%macro save-extended-state 1
    xsave %1
%endmacro

%macro restore-extended-state 1
    xrstor %1
%endmacro

%macro save-extended-state-compacted 1
    xsavec %1
%endmacro

%macro save-extended-state-optimized 1
    xsaveopt %1
%endmacro

%macro restore-extended-state-compacted 1
    xrstors %1
%endmacro

%macro save-extended-state-supervisor 1
    xsaves %1
%endmacro

%macro get-extended-state 2
    xgetbv %1, %2
%endmacro

%macro set-extended-state 2
    xsetbv %1, %2
%endmacro

; ============================================================================
; SECTION 59: TSX TRANSACTIONAL SYNCHRONIZATION EXTENSIONS
; ============================================================================

%macro transaction-begin 1
    xbegin %1
%endmacro

%macro transaction-end 0
    xend
%endmacro

%macro transaction-abort 1
    xabort %1
%endmacro

%macro restricted-transaction-begin 1
    xbegin %1
%endmacro

%macro restricted-transaction-end 0
    xend
%endmacro

; ============================================================================
; SECTION 60: CET SHADOW STACK WRITE INSTRUCTIONS
; ============================================================================

%macro write-shadow-stack-dword 2
    wrssd %1, %2
%endmacro

%macro write-shadow-stack-qword 2
    wrssq %1, %2
%endmacro

%macro write-user-shadow-stack-dword 2
    wrussd %1, %2
%endmacro

%macro write-user-shadow-stack-qword 2
    wrussq %1, %2
%endmacro

%macro save-previous-shadow-stack 0
    saveprevssp
%endmacro

%macro restore-shadow-stack 1
    rstorssp %1
%endmacro

%macro set-shadow-stack-busy 0
    setssbsy
%endmacro

; ============================================================================
; SECTION 61: ADDITIONAL SYSTEM INSTRUCTIONS
; ============================================================================

%macro read-performance-counter 1
    rdpmc %1
%endmacro

%macro store-local-descriptor-table 1
    sldt %1
%endmacro

%macro store-task-register 1
    str %1
%endmacro

%macro store-machine-status-word 1
    smsw %1
%endmacro

%macro wait-for-fpu 0
    wait
%endmacro

%macro serialize-processor 0
    serialize
%endmacro

%macro user-mode-interrupt-prevention 0
    umip
%endmacro

%macro undefined-instruction 0
    ud2
%endmacro

%macro debug-breakpoint 0
    int3
%endmacro

%macro debug-ice-breakpoint 0
    int1
%endmacro

; ============================================================================
; SECTION 62: SGX ENCLAVE INSTRUCTIONS
; ============================================================================

%macro sgx-enter-enclave 0
    eenter
%endmacro

%macro sgx-resume-enclave 0
    eresume
%endmacro

%macro sgx-enclave-leaf 1
    enclu %1
%endmacro

%macro sgx-provision-leaf 1
    encls %1
%endmacro
