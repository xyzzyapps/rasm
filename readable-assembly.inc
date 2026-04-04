; ============================================================================
; READABLE ASSEMBLY - NASM Preprocessor Macros for x86-64
; ============================================================================
; This file provides English-hyphenated macro names that map to actual
; x86-64 instructions, making assembly code more readable and self-documenting.
;
; Usage: %include "readable-assembly.inc"
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

; --- Test Registers (legacy) ---
%define test-register-tr3 tr3
%define test-register-tr4 tr4
%define test-register-tr5 tr5
%define test-register-tr6 tr6
%define test-register-tr7 tr7

; --- Special Registers ---
%define register-rip rip
%define register-eflags eflags
%define register-rflags rflags
%define register-mxcsr mxcsr

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
; SECTION 5: CORE INSTRUCTION MACROS
; ============================================================================

; ----------------------------------------------------------------------------
; DATA MOVEMENT
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; ARITHMETIC
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; LOGIC
; ----------------------------------------------------------------------------

%macro logical-and 2
    and %1, %2
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

; ----------------------------------------------------------------------------
; SHIFT AND ROTATE
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; CONTROL FLOW - JUMPS
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; LOOP
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; PROCEDURE CALLS
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; STACK OPERATIONS
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; FLAG CONTROL
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; STRING OPERATIONS
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; REPEAT PREFIXES
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; I/O OPERATIONS
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; INTERRUPTS
; ----------------------------------------------------------------------------

%macro interrupt 1
    int %1
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

; ----------------------------------------------------------------------------
; SYSTEM INSTRUCTIONS
; ----------------------------------------------------------------------------

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

; ----------------------------------------------------------------------------
; FLAG TRANSFER
; ----------------------------------------------------------------------------

%macro load-flags-into-ah 0
    lahf
%endmacro

%macro store-ah-into-flags 0
    sahf
%endmacro
