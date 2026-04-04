; ============================================================================
; Readable Assembly Macros for NASM - x86-64
; ============================================================================
; A comprehensive preprocessor that transforms x86-64 assembly into
; human-readable, English-like syntax using NASM's macro system.
;
; Usage: %include "readable-assembly.inc"
;
; Examples:
;   move    register-ax, 42          ; mov rax, 42
;   jump    label                    ; jmp label
;   add-with-carry register-bx, register-cx  ; adc rbx, rcx
;   jump-if-equal some_label         ; je some_label
; ============================================================================
; ============================================================================
; SECTION 1: REGISTER MACROS
; ============================================================================
; General Purpose Registers (64-bit)
%define register-ax       rax
%define register-bx       rbx
%define register-cx       rcx
%define register-dx       rdx
%define register-si       rsi
%define register-di       rdi
%define register-bp       rbp
%define register-sp       rsp
%define register-8        r8
%define register-9        r9
%define register-10       r10
%define register-11       r11
%define register-12       r12
%define register-13       r13
%define register-14       r14
%define register-15       r15
; General Purpose Registers (32-bit)
%define register-eax      eax
%define register-ebx      ebx
%define register-ecx      ecx
%define register-edx      edx
%define register-esi      esi
%define register-edi      edi
%define register-ebp      ebp
%define register-esp      esp
%define register-r8d      r8d
%define register-r9d      r9d
%define register-r10d     r10d
%define register-r11d     r11d
%define register-r12d     r12d
%define register-r13d     r13d
%define register-r14d     r14d
%define register-r15d     r15d
; General Purpose Registers (16-bit)
%define register-ax16     ax
%define register-bx16     bx
%define register-cx16     cx
%define register-dx16     dx
%define register-si16     si
%define register-di16     di
%define register-bp16     bp
%define register-sp16     sp
%define register-r8w      r8w
%define register-r9w      r9w
%define register-r10w     r10w
%define register-r11w     r11w
%define register-r12w     r12w
%define register-r13w     r13w
%define register-r14w     r14w
%define register-r15w     r15w
; General Purpose Registers (8-bit)
%define register-al       al
%define register-bl       bl
%define register-cl       cl
%define register-dl       dl
%define register-ah       ah
%define register-bh       bh
%define register-ch       ch
%define register-dh       dh
%define register-sil      sil
%define register-dil      dil
%define register-bpl      bpl
%define register-spl      spl
%define register-r8b      r8b
%define register-r9b      r9b
%define register-r10b     r10b
%define register-r11b     r11b
%define register-r12b     r12b
%define register-r13b     r13b
%define register-r14b     r14b
%define register-r15b     r15b
; Segment Registers
%define register-cs       cs
%define register-ds       ds
%define register-es       es
%define register-fs       fs
%define register-gs       gs
%define register-ss       ss
; Control Registers
%define register-cr0      cr0
%define register-cr2      cr2
%define register-cr3      cr3
%define register-cr4      cr4
%define register-cr8      cr8
; Debug Registers
%define register-dr0      dr0
%define register-dr1      dr1
%define register-dr2      dr2
%define register-dr3      dr3
%define register-dr6      dr6
%define register-dr7      dr7
; Test Registers
%define register-tr3      tr3
%define register-tr4      tr4
%define register-tr5      tr5
%define register-tr6      tr6
%define register-tr7      tr7
; Special Registers
%define register-rip      rip
%define register-rflags   rflags
%define register-eflags   eflags
%define register-flags    flags
; ============================================================================
; SECTION 2: FLAG MACROS
; ============================================================================
%define zero-flag         zf
%define carry-flag        cf
%define sign-flag         sf
%define overflow-flag     of
%define parity-flag       pf
%define adjust-flag       af
%define direction-flag    df
%define interrupt-flag    if
%define trap-flag         tf
; ============================================================================
; SECTION 3: OPERAND SIZE SPECIFIERS
; ============================================================================
%define byte-size         byte
%define word-size         word
%define dword-size        dword
%define qword-size        qword
%define tword-size        tword
%define oword-size        oword
%define yword-size        yword
%define xword-size        xword
; ============================================================================
; SECTION 4: SEGMENT OVERRIDES
; ============================================================================
%define segment-cs        cs:
%define segment-ds        ds:
%define segment-es        es:
%define segment-fs        fs:
%define segment-gs        gs:
%define segment-ss        ss:
; ============================================================================
; SECTION 5: CORE INSTRUCTION MACROS
; ============================================================================
; --- Data Movement ---
%macro move 2
    mov %1, %2
%endmacro
%macro exchange 2
    xchg %1, %2
%endmacro
%macro swap 2
    xchg %1, %2
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
%macro sign-extend-byte 1
    movsx %1
%endmacro
%macro zero-extend-byte 1
    movzx %1
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
%macro translate-byte 0-1
    %ifnempty %1
        xlat %1
    %else
        xlat
    %endif
%endmacro
; --- Arithmetic ---
%macro add 2
    add %1, %2
%endmacro
%macro add-with-carry 2
    adc %1, %2
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
%macro signed-multiply 1-2
    %ifnempty %2
        imul %1, %2
    %else
        imul %1
    %endif
%endmacro
%macro signed-multiply-immediate 3
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
; --- Logic ---
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
; --- Shift and Rotate ---
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
; --- Double-Precision Shifts ---
%macro shift-left-double 3
    shld %1, %2, %3
%endmacro
%macro shift-right-double 3
    shrd %1, %2, %3
%endmacro
; --- Control Flow ---
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
; --- Loop ---
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
; --- Procedure Calls ---
%macro call-procedure 1
    call %1
%endmacro
%macro return-from-procedure 0-1
    %ifnempty %1
        ret %1
    %else
        ret
    %endif
%endmacro
%macro return-far 0-1
    %ifnempty %1
        retf %1
    %else
        retf
    %endif
%endmacro
; --- Stack Operations ---
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
%macro pop-flags 0
    popf
%endmacro
%macro push-flags-word 0
    pushfw
%endmacro
%macro pop-flags-word 0
    popfw
%endmacro
%macro push-flags-dword 0
    pushfd
%endmacro
%macro pop-flags-dword 0
    popfd
%endmacro
%macro push-flags-qword 0
    pushfq
%endmacro
%macro pop-flags-qword 0
    popfq
%endmacro
; --- Flag Control ---
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
; --- String Operations ---
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
; --- Repeat Prefixes ---
%macro repeat 0
    rep
%endmacro
%macro repeat-if-equal 0
    repe
%endmacro
%macro repeat-if-zero 0
    repz
%endmacro
%macro repeat-if-not-equal 0
    repne
%endmacro
%macro repeat-if-not-zero 0
    repnz
%endmacro
; --- I/O Operations ---
%macro input-from-port 1
    in %1
%endmacro
%macro output-to-port 1
    out %1
%endmacro
%macro input-string-from-port 0
    ins
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
%macro output-string-to-port 0
    outs
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
; --- Interrupt ---
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
; --- System ---
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
; --- Flag Transfer ---
%macro load-flags-into-ah 0
    lahf
%endmacro
%macro store-ah-into-flags 0
    sahf
%endmacro
; ============================================================================
; SECTION 6: x86-64 EXTENSION INSTRUCTIONS
; ============================================================================
; --- Conditional Move ---
%macro move-if-equal 2
    cmove %1, %2
%endmacro
%macro move-if-not-equal 2
    cmovne %1, %2
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
%macro move-if-no-parity 2
    cmovnp %1, %2
%endmacro
%macro move-if-zero 2
    cmovz %1, %2
%endmacro
%macro move-if-not-zero 2
    cmovnz %1, %2
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
; --- Bit Manipulation ---
%macro bit-scan-forward 2
    bsf %1, %2
%endmacro
%macro bit-scan-reverse 2
    bsr %1, %2
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
%macro byte-swap 1
    bswap %1
%endmacro
; --- Counting ---
%macro count-leading-zeros 2
    lzcnt %1, %2
%endmacro
%macro count-trailing-zeros 2
    tzcnt %1, %2
%endmacro
%macro population-count 2
    popcnt %1, %2
%endmacro
; --- BMI1 Instructions ---
%macro extract-lowest-set-bit 2
    blsi %1, %2
%endmacro
%macro mask-up-to-lowest-set-bit 2
    blsmsk %1, %2
%endmacro
%macro reset-lowest-set-bit 2
    blsr %1, %2
%endmacro
%macro bit-field-extract 3
    bextr %1, %2, %3
%endmacro
; --- BMI2 Instructions ---
%macro bit-deposit 3
    pdep %1, %2, %3
%endmacro
%macro bit-extract 3
    pext %1, %2, %3
%endmacro
%macro zero-high-bits 3
    bzhi %1, %2, %3
%endmacro
%macro multiply-low 3
    mulx %1, %2, %3
%endmacro
%macro rotate-left-without-affecting-flags 3
    rolx %1, %2, %3
%endmacro
%macro rotate-right-without-affecting-flags 3
    rorx %1, %2, %3
%endmacro
%macro shift-left-without-affecting-flags 3
    shl %1, %2, %3
%endmacro
%macro shift-arithmetic-right-without-affecting-flags 3
    sarx %1, %2, %3
%endmacro
%macro shift-logical-right-without-affecting-flags 3
    shrx %1, %2, %3
%endmacro
; --- CRC32 ---
%macro crc32-byte 2
    crc32 %1, %2
%endmacro
%macro crc32-word 2
    crc32 %1, %2
%endmacro
%macro crc32-dword 2
    crc32 %1, %2
%endmacro
%macro crc32-qword 2
    crc32 %1, %2
%endmacro
; ============================================================================
; SECTION 7: SSE / SSE2 / SSE3 / SSSE3 / SSE4 INSTRUCTIONS
; ============================================================================
; --- SSE Register Aliases ---
%define xmm-register-0  xmm0
%define xmm-register-1  xmm1
%define xmm-register-2  xmm2
%define xmm-register-3  xmm3
%define xmm-register-4  xmm4
%define xmm-register-5  xmm5
%define xmm-register-6  xmm6
%define xmm-register-7  xmm7
%define xmm-register-8  xmm8
%define xmm-register-9  xmm9
%define xmm-register-10 xmm10
%define xmm-register-11 xmm11
%define xmm-register-12 xmm12
%define xmm-register-13 xmm13
%define xmm-register-14 xmm14
%define xmm-register-15 xmm15
; --- SSE: Arithmetic ---
%macro sse-add-packed-single 2
    addps %1, %2
%endmacro
%macro sse-add-packed-double 2
    addpd %1, %2
%endmacro
%macro sse-add-scalar-single 2
    addss %1, %2
%endmacro
%macro sse-add-scalar-double 2
    addsd %1, %2
%endmacro
%macro sse-subtract-packed-single 2
    subps %1, %2
%endmacro
%macro sse-subtract-packed-double 2
    subpd %1, %2
%endmacro
%macro sse-subtract-scalar-single 2
    subss %1, %2
%endmacro
%macro sse-subtract-scalar-double 2
    subsd %1, %2
%endmacro
%macro sse-multiply-packed-single 2
    mulps %1, %2
%endmacro
%macro sse-multiply-packed-double 2
    mulpd %1, %2
%endmacro
%macro sse-multiply-scalar-single 2
    mulss %1, %2
%endmacro
%macro sse-multiply-scalar-double 2
    mulsd %1, %2
%endmacro
%macro sse-divide-packed-single 2
    divps %1, %2
%endmacro
%macro sse-divide-packed-double 2
    divpd %1, %2
%endmacro
%macro sse-divide-scalar-single 2
    divss %1, %2
%endmacro
%macro sse-divide-scalar-double 2
    divsd %1, %2
%endmacro
%macro sse-square-root-packed-single 1
    sqrtps %1
%endmacro
%macro sse-square-root-packed-double 1
    sqrtpd %1
%endmacro
%macro sse-square-root-scalar-single 2
    sqrtss %1, %2
%endmacro
%macro sse-square-root-scalar-double 2
    sqrtsd %1, %2
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
; --- SSE: Comparison ---
%macro sse-compare-packed-single 3
    cmpps %1, %2, %3
%endmacro
%macro sse-compare-packed-double 3
    cmppd %1, %2, %3
%endmacro
%macro sse-compare-scalar-single 3
    cmpss %1, %2, %3
%endmacro
%macro sse-compare-scalar-double 3
    cmpsd %1, %2, %3
%endmacro
%macro sse-compare-equal-packed-single 2
    cmpeqps %1, %2
%endmacro
%macro sse-compare-equal-packed-double 2
    cmpeqpd %1, %2
%endmacro
%macro sse-compare-less-than-packed-single 2
    cmpltps %1, %2
%endmacro
%macro sse-compare-less-than-packed-double 2
    cmpltpd %1, %2
%endmacro
%macro sse-compare-less-or-equal-packed-single 2
    cmpleps %1, %2
%endmacro
%macro sse-compare-less-or-equal-packed-double 2
    cmplepd %1, %2
%endmacro
%macro sse-compare-greater-than-packed-single 2
    cmpnltpd %1, %2
%endmacro
%macro sse-compare-greater-than-packed-double 2
    cmpnltpd %1, %2
%endmacro
%macro sse-compare-ordered 2
    cmpordps %1, %2
%endmacro
%macro sse-compare-unordered 2
    cmpunordps %1, %2
%endmacro
%macro sse-compare-scalar-equal-single 2
    cmpeqss %1, %2
%endmacro
%macro sse-compare-scalar-equal-double 2
    cmpeqsd %1, %2
%endmacro
%macro sse-compare-scalar-less-than-single 2
    cmpltss %1, %2
%endmacro
%macro sse-compare-scalar-less-than-double 2
    cmpltsd %1, %2
%endmacro
%macro sse-compare-scalar-less-or-equal-single 2
    cmpless %1, %2
%endmacro
%macro sse-compare-scalar-less-or-equal-double 2
    cmplesd %1, %2
%endmacro
%macro sse-unordered-compare-scalar-single 2
    ucomiss %1, %2
%endmacro
%macro sse-unordered-compare-scalar-double 2
    ucomisd %1, %2
%endmacro
%macro sse-ordered-compare-scalar-single 2
    comiss %1, %2
%endmacro
%macro sse-ordered-compare-scalar-double 2
    comisd %1, %2
%endmacro
; --- SSE: Logical ---
%macro sse-and 2
    andps %1, %2
%endmacro
%macro sse-and-double 2
    andpd %1, %2
%endmacro
%macro sse-and-not 2
    andnps %1, %2
%endmacro
%macro sse-and-not-double 2
    andnpd %1, %2
%endmacro
%macro sse-or 2
    orps %1, %2
%endmacro
%macro sse-or-double 2
    orpd %1, %2
%endmacro
%macro sse-xor 2
    xorps %1, %2
%endmacro
%macro sse-xor-double 2
    xorpd %1, %2
%endmacro
; --- SSE: Data Movement ---
%macro sse-move-aligned-packed-double 2
    movapd %1, %2
%endmacro
%macro sse-move-aligned-packed-single 2
    movaps %1, %2
%endmacro
%macro sse-move-unaligned-packed-double 2
    movupd %1, %2
%endmacro
%macro sse-move-unaligned-packed-single 2
    movups %1, %2
%endmacro
%macro sse-move-scalar-double 2
    movsd %1, %2
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
%macro sse-mask-move 3
    maskmovq %1, %2, %3
%endmacro
%macro sse-move-mask-packed-single 2
    movmskps %1, %2
%endmacro
%macro sse-move-mask-packed-double 2
    movmskpd %1, %2
%endmacro
%macro sse-move-fence 0
    movntps
%endmacro
%macro sse-move-non-temporal-double 2
    movntpd %1, %2
%endmacro
%macro sse-move-non-temporal-dword 2
    movnti %1, %2
%endmacro
%macro sse-move-non-temporal-qword 2
    movntq %1, %2
%endmacro
%macro sse-stream-double 2
    movntdq %1, %2
%endmacro
; --- SSE: Shuffle and Unpack ---
%macro sse-shuffle-packed-single 3
    shufps %1, %2, %3
%endmacro
%macro sse-shuffle-packed-double 3
    shufpd %1, %2, %3
%endmacro
%macro sse-unpack-high-packed-single 2
    unhps %1, %2
%endmacro
%macro sse-unpack-low-packed-single 2
    unlps %1, %2
%endmacro
%macro sse-unpack-high-packed-double 2
    unhpd %1, %2
%endmacro
%macro sse-unpack-low-packed-double 2
    unlpd %1, %2
%endmacro
; --- SSE: Conversion ---
%macro sse-convert-packed-single-to-dword 2
    cvtps2dq %1, %2
%endmacro
%macro sse-convert-packed-double-to-dword 2
    cvtpd2dq %1, %2
%endmacro
%macro sse-convert-dword-to-packed-single 2
    cvtdq2ps %1, %2
%endmacro
%macro sse-convert-dword-to-packed-double 2
    cvtdq2pd %1, %2
%endmacro
%macro sse-convert-packed-single-to-double 2
    cvtps2pd %1, %2
%endmacro
%macro sse-convert-packed-double-to-single 2
    cvtpd2ps %1, %2
%endmacro
%macro sse-convert-scalar-single-to-double 2
    cvtss2sd %1, %2
%endmacro
%macro sse-convert-scalar-double-to-single 2
    cvtsd2ss %1, %2
%endmacro
%macro sse-convert-scalar-single-to-dword 2
    cvtss2si %1, %2
%endmacro
%macro sse-convert-scalar-double-to-dword 2
    cvtsd2si %1, %2
%endmacro
%macro sse-convert-dword-to-scalar-single 2
    cvtsi2ss %1, %2
%endmacro
%macro sse-convert-dword-to-scalar-double 2
    cvtsi2sd %1, %2
%endmacro
%macro sse-truncate-packed-single-to-dword 2
    cvttps2dq %1, %2
%endmacro
%macro sse-truncate-packed-double-to-dword 2
    cvttpd2dq %1, %2
%endmacro
%macro sse-truncate-scalar-single-to-dword 2
    cvttss2si %1, %2
%endmacro
%macro sse-truncate-scalar-double-to-dword 2
    cvttsd2si %1, %2
%endmacro
; --- SSE: Min/Max ---
%macro sse-min-packed-single 2
    minps %1, %2
%endmacro
%macro sse-min-packed-double 2
    minpd %1, %2
%endmacro
%macro sse-min-scalar-single 2
    minss %1, %2
%endmacro
%macro sse-min-scalar-double 2
    minsd %1, %2
%endmacro
%macro sse-max-packed-single 2
    maxps %1, %2
%endmacro
%macro sse-max-packed-double 2
    maxpd %1, %2
%endmacro
%macro sse-max-scalar-single 2
    maxss %1, %2
%endmacro
%macro sse-max-scalar-double 2
    maxsd %1, %2
%endmacro
; --- SSE2: Integer Operations ---
%macro sse2-add-packed-words 2
    paddw %1, %2
%endmacro
%macro sse2-add-packed-dwords 2
    paddd %1, %2
%endmacro
%macro sse2-add-packed-qwords 2
    paddq %1, %2
%endmacro
%macro sse2-add-packed-bytes 2
    paddb %1, %2
%endmacro
%macro sse2-add-saturated-packed-words 2
    paddsw %1, %2
%endmacro
%macro sse2-add-saturated-packed-unsigned-words 2
    paddusw %1, %2
%endmacro
%macro sse2-add-saturated-packed-bytes 2
    paddsb %1, %2
%endmacro
%macro sse2-add-saturated-packed-unsigned-bytes 2
    paddusb %1, %2
%endmacro
%macro sse2-subtract-packed-words 2
    psubw %1, %2
%endmacro
%macro sse2-subtract-packed-dwords 2
    psubd %1, %2
%endmacro
%macro sse2-subtract-packed-qwords 2
    psubq %1, %2
%endmacro
%macro sse2-subtract-packed-bytes 2
    psubb %1, %2
%endmacro
%macro sse2-subtract-saturated-packed-words 2
    psubsw %1, %2
%endmacro
%macro sse2-subtract-saturated-packed-unsigned-words 2
    psubusw %1, %2
%endmacro
%macro sse2-subtract-saturated-packed-bytes 2
    psubsb %1, %2
%endmacro
%macro sse2-subtract-saturated-packed-unsigned-bytes 2
    psubusb %1, %2
%endmacro
%macro sse2-multiply-low-packed-words 2
    pmullw %1, %2
%endmacro
%macro sse2-multiply-high-packed-words 2
    pmulhw %1, %2
%endmacro
%macro sse2-multiply-high-packed-unsigned-words 2
    pmulhuw %1, %2
%endmacro
%macro sse2-average-packed-unsigned-words 2
    pavgb %1, %2
%endmacro
%macro sse2-average-packed-unsigned-bytes 2
    pavgb %1, %2
%endmacro
%macro sse2-max-packed-words 2
    pmaxsw %1, %2
%endmacro
%macro sse2-max-packed-unsigned-bytes 2
    pmaxub %1, %2
%endmacro
%macro sse2-min-packed-words 2
    pminsw %1, %2
%endmacro
%macro sse2-min-packed-unsigned-bytes 2
    pminub %1, %2
%endmacro
; --- SSE2: Shift ---
%macro sse2-shift-left-logical-packed-words 2
    psllw %1, %2
%endmacro
%macro sse2-shift-left-logical-packed-dwords 2
    pslld %1, %2
%endmacro
%macro sse2-shift-left-logical-packed-qwords 2
    psllq %1, %2
%endmacro
%macro sse2-shift-right-logical-packed-words 2
    psrlw %1, %2
%endmacro
%macro sse2-shift-right-logical-packed-dwords 2
    psrld %1, %2
%endmacro
%macro sse2-shift-right-logical-packed-qwords 2
    psrlq %1, %2
%endmacro
%macro sse2-shift-right-arithmetic-packed-words 2
    psraw %1, %2
%endmacro
%macro sse2-shift-right-arithmetic-packed-dwords 2
    psrad %1, %2
%endmacro
; --- SSE2: Compare ---
%macro sse2-compare-equal-packed-bytes 2
    pcmpeqb %1, %2
%endmacro
%macro sse2-compare-equal-packed-words 2
    pcmpeqw %1, %2
%endmacro
%macro sse2-compare-equal-packed-dwords 2
    pcmpeqd %1, %2
%endmacro
%macro sse2-compare-greater-than-packed-bytes 2
    pcmpgtb %1, %2
%endmacro
%macro sse2-compare-greater-than-packed-words 2
    pcmpgtw %1, %2
%endmacro
%macro sse2-compare-greater-than-packed-dwords 2
    pcmpgtd %1, %2
%endmacro
; --- SSE2: Pack/Unpack ---
%macro sse2-pack-signed-saturate-dwords 2
    packssdw %1, %2
%endmacro
%macro sse2-pack-signed-saturate-words 2
    packsswb %1, %2
%endmacro
%macro sse2-pack-unsigned-saturate-words 2
    packuswb %1, %2
%endmacro
%macro sse2-unpack-high-bytes 2
    punpckhbw %1, %2
%endmacro
%macro sse2-unpack-high-words 2
    punpckhwd %1, %2
%endmacro
%macro sse2-unpack-high-dwords 2
    punpckhdq %1, %2
%endmacro
%macro sse2-unpack-high-qwords 2
    punpckhqdq %1, %2
%endmacro
%macro sse2-unpack-low-bytes 2
    punpcklbw %1, %2
%endmacro
%macro sse2-unpack-low-words 2
    punpcklwd %1, %2
%endmacro
%macro sse2-unpack-low-dwords 2
    punpckldq %1, %2
%endmacro
%macro sse2-unpack-low-qwords 2
    punpcklqdq %1, %2
%endmacro
; --- SSE2: Logical ---
%macro sse2-logical-and 2
    pand %1, %2
%endmacro
%macro sse2-logical-and-not 2
    pandn %1, %2
%endmacro
%macro sse2-logical-or 2
    por %1, %2
%endmacro
%macro sse2-logical-xor 2
    pxor %1, %2
%endmacro
; --- SSE2: Load/Store ---
%macro sse2-load-aligned 2
    movdqa %1, %2
%endmacro
%macro sse2-load-unaligned 2
    movdqu %1, %2
%endmacro
%macro sse2-store-aligned 2
    movdqa %1, %2
%endmacro
%macro sse2-store-unaligned 2
    movdqu %1, %2
%endmacro
%macro sse2-load-scalar-64 2
    movq %1, %2
%endmacro
%macro sse2-store-scalar-64 2
    movq %1, %2
%endmacro
%macro sse2-load-duplicate 2
    movddup %1, %2
%endmacro
%macro sse2-load-high-low 2
    movhpd %1, %2
%endmacro
%macro sse2-load-low-high 2
    movlpd %1, %2
%endmacro
%macro sse2-store-high 2
    movhpd %1, %2
%endmacro
%macro sse2-store-low 2
    movlpd %1, %2
%endmacro
%macro sse2-load-fence 0
    lfence
%endmacro
%macro sse2-store-fence 0
    sfence
%endmacro
%macro sse2-memory-fence 0
    mfence
%endmacro
; --- SSE3 Instructions ---
%macro sse3-addsub-packed-single 2
    addsubps %1, %2
%endmacro
%macro sse3-addsub-packed-double 2
    addsubpd %1, %2
%endmacro
%macro sse3-horizontal-add-packed-single 2
    haddps %1, %2
%endmacro
%macro sse3-horizontal-add-packed-double 2
    haddpd %1, %2
%endmacro
%macro sse3-horizontal-subtract-packed-single 2
    hsubps %1, %2
%endmacro
%macro sse3-horizontal-subtract-packed-double 2
    hsubpd %1, %2
%endmacro
%macro sse3-move-duplicate-packed-single 2
    movsldup %1, %2
%endmacro
%macro sse3-move-duplicate-packed-double 2
    movddup %1, %2
%endmacro
%macro sse3-load-unaligned-fence 2
    lddqu %1, %2
%endmacro
%macro sse3-monitor 0
    monitor
%endmacro
%macro sse3-mwait 0
    mwait
%endmacro
; --- SSSE3 Instructions ---
%macro ssse3-absolute-packed-bytes 2
    pabsb %1, %2
%endmacro
%macro ssse3-absolute-packed-words 2
    pabsw %1, %2
%endmacro
%macro ssse3-absolute-packed-dwords 2
    pabsd %1, %2
%endmacro
%macro ssse3-align-right 3
    palignr %1, %2, %3
%endmacro
%macro ssse3-horizontal-add-multiply-saturate 2
    phaddw %1, %2
%endmacro
%macro ssse3-horizontal-add-multiply-saturate-dwords 2
    phaddd %1, %2
%endmacro
%macro ssse3-horizontal-add-multiply-saturate-bytes 2
    phaddsw %1, %2
%endmacro
%macro ssse3-horizontal-subtract-words 2
    phsubw %1, %2
%endmacro
%macro ssse3-horizontal-subtract-dwords 2
    phsubd %1, %2
%endmacro
%macro ssse3-horizontal-subtract-saturate-words 2
    phsubsw %1, %2
%endmacro
%macro ssse3-multiply-add-signed-bytes 2
    pmaddubsw %1, %2
%endmacro
%macro ssse3-multiply-high-round-scaled 2
    pmulhrsw %1, %2
%endmacro
%macro ssse3-shuffle-bytes 2
    pshufb %1, %2
%endmacro
%macro ssse3-sign-bytes 2
    psignb %1, %2
%endmacro
%macro ssse3-sign-words 2
    psignw %1, %2
%endmacro
%macro ssse3-sign-dwords 2
    psignd %1, %2
%endmacro
; --- SSE4.1 Instructions ---
%macro sse41-blend-packed-words 3
    blendps %1, %2, %3
%endmacro
%macro sse41-blend-variables-packed-single 2
    blendvps %1, %2
%endmacro
%macro sse41-blend-variables-packed-double 2
    blendvpd %1, %2
%endmacro
%macro sse41-dot-product-packed-single 3
    dpps %1, %2, %3
%endmacro
%macro sse41-dot-product-packed-double 3
    dppd %1, %2, %3
%endmacro
%macro sse41-extract-dword 3
    extractps %1, %2, %3
%endmacro
%macro sse41-insert-dword 3
    insertps %1, %2, %3
%endmacro
%macro sse41-min-packed-dwords 2
    pminsd %1, %2
%endmacro
%macro sse41-min-packed-unsigned-dwords 2
    pminud %1, %2
%endmacro
%macro sse41-min-packed-words 2
    pminsw %1, %2
%endmacro
%macro sse41-min-position-unsigned-word 2
    phminposuw %1, %2
%endmacro
%macro sse41-max-packed-dwords 2
    pmaxsd %1, %2
%endmacro
%macro sse41-max-packed-unsigned-dwords 2
    pmaxud %1, %2
%endmacro
%macro sse41-multiply-low-packed-dwords 2
    pmulld %1, %2
%endmacro
%macro sse41-multiply-high-dwords 2
    pmuldq %1, %2
%endmacro
%macro sse41-round-packed-single 2
    roundps %1, %2
%endmacro
%macro sse41-round-packed-double 2
    roundpd %1, %2
%endmacro
%macro sse41-round-scalar-single 2
    roundss %1, %2
%endmacro
%macro sse41-round-scalar-double 2
    roundsd %1, %2
%endmacro
%macro sse41-floor-packed-single 1
    floorps %1
%endmacro
%macro sse41-floor-packed-double 1
    floorpd %1
%endmacro
%macro sse41-ceil-packed-single 1
    ceilps %1
%endmacro
%macro sse41-ceil-packed-double 1
    ceilpd %1
%endmacro
%macro sse41-truncate-packed-single 1
    truncps %1
%endmacro
%macro sse41-truncate-packed-double 1
    truncpd %1
%endmacro
%macro sse41-test-bytes 2
    ptest %1, %2
%endmacro
%macro sse41-pack-unsigned-dwords 2
    packusdw %1, %2
%endmacro
%macro sse41-convert-sign-extend-bytes 2
    pmovsxbw %1, %2
%endmacro
%macro sse41-convert-sign-extend-byte-dwords 2
    pmovsxbd %1, %2
%endmacro
%macro sse41-convert-sign-extend-byte-qwords 2
    pmovsxbq %1, %2
%endmacro
%macro sse41-convert-sign-extend-words 2
    pmovsxwd %1, %2
%endmacro
%macro sse41-convert-sign-extend-word-qwords 2
    pmovsxwq %1, %2
%endmacro
%macro sse41-convert-sign-extend-dwords 2
    pmovsxdq %1, %2
%endmacro
%macro sse41-convert-zero-extend-bytes 2
    pmovzxbw %1, %2
%endmacro
%macro sse41-convert-zero-extend-byte-dwords 2
    pmovzxbd %1, %2
%endmacro
%macro sse41-convert-zero-extend-byte-qwords 2
    pmovzxbq %1, %2
%endmacro
%macro sse41-convert-zero-extend-words 2
    pmovzxwd %1, %2
%endmacro
%macro sse41-convert-zero-extend-word-qwords 2
    pmovzxwq %1, %2
%endmacro
%macro sse41-convert-zero-extend-dwords 2
    pmovzxdq %1, %2
%endmacro
; --- SSE4.2 Instructions ---
%macro sse42-string-compare 3
    pcmpestri %1, %2, %3
%endmacro
%macro sse42-string-compare-mask 3
    pcmpestrm %1, %2, %3
%endmacro
%macro sse42-string-compare-index 2
    pcmpistri %1, %2
%endmacro
%macro sse42-string-compare-mask-index 2
    pcmpistrm %1, %2
%endmacro
%macro sse42-compare-equal-qwords 2
    pcmpeqq %1, %2
%endmacro
%macro sse42-compare-greater-than-qwords 2
    pcmpgtq %1, %2
%endmacro
%macro sse42-crc32 2
    crc32 %1, %2
%endmacro
%macro sse42-populate-count 2
    popcnt %1, %2
%endmacro
; ============================================================================
; SECTION 8: AVX / AVX2 INSTRUCTIONS
; ============================================================================
; --- YMM Register Aliases ---
%define ymm-register-0  ymm0
%define ymm-register-1  ymm1
%define ymm-register-2  ymm2
%define ymm-register-3  ymm3
%define ymm-register-4  ymm4
%define ymm-register-5  ymm5
%define ymm-register-6  ymm6
%define ymm-register-7  ymm7
%define ymm-register-8  ymm8
%define ymm-register-9  ymm9
%define ymm-register-10 ymm10
%define ymm-register-11 ymm11
%define ymm-register-12 ymm12
%define ymm-register-13 ymm13
%define ymm-register-14 ymm14
%define ymm-register-15 ymm15
; --- AVX: Three-Operand Arithmetic ---
%macro avx-add-packed-single 3
    vaddps %1, %2, %3
%endmacro
%macro avx-add-packed-double 3
    vaddpd %1, %2, %3
%endmacro
%macro avx-add-scalar-single 3
    vaddss %1, %2, %3
%endmacro
%macro avx-add-scalar-double 3
    vaddsd %1, %2, %3
%endmacro
%macro avx-subtract-packed-single 3
    vsubps %1, %2, %3
%endmacro
%macro avx-subtract-packed-double 3
    vsubpd %1, %2, %3
%endmacro
%macro avx-subtract-scalar-single 3
    vsubss %1, %2, %3
%endmacro
%macro avx-subtract-scalar-double 3
    vsubsd %1, %2, %3
%endmacro
%macro avx-multiply-packed-single 3
    vmulps %1, %2, %3
%endmacro
%macro avx-multiply-packed-double 3
    vmulpd %1, %2, %3
%endmacro
%macro avx-multiply-scalar-single 3
    vmulss %1, %2, %3
%endmacro
%macro avx-multiply-scalar-double 3
    vmulsd %1, %2, %3
%endmacro
%macro avx-divide-packed-single 3
    vdivps %1, %2, %3
%endmacro
%macro avx-divide-packed-double 3
    vdivpd %1, %2, %3
%endmacro
%macro avx-divide-scalar-single 3
    vdivss %1, %2, %3
%endmacro
%macro avx-divide-scalar-double 3
    vdivsd %1, %2, %3
%endmacro
%macro avx-square-root-packed-single 2
    vsqrtps %1, %2
%endmacro
%macro avx-square-root-packed-double 2
    vsqrtpd %1, %2
%endmacro
%macro avx-square-root-scalar-single 3
    vsqrtss %1, %2, %3
%endmacro
%macro avx-square-root-scalar-double 3
    vsqrtsd %1, %2, %3
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
; --- AVX: Comparison ---
%macro avx-compare-packed-single 4
    vcmpps %1, %2, %3, %4
%endmacro
%macro avx-compare-packed-double 4
    vcmppd %1, %2, %3, %4
%endmacro
%macro avx-compare-scalar-single 4
    vcmpss %1, %2, %3, %4
%endmacro
%macro avx-compare-scalar-double 4
    vcmpsd %1, %2, %3, %4
%endmacro
; --- AVX: Logical ---
%macro avx-logical-and 3
    vandps %1, %2, %3
%endmacro
%macro avx-logical-and-double 3
    vandpd %1, %2, %3
%endmacro
%macro avx-logical-and-not-128 3
    vandnps %1, %2, %3
%endmacro
%macro avx-logical-or 3
    vorps %1, %2, %3
%endmacro
%macro avx-logical-or-double 3
    vorpd %1, %2, %3
%endmacro
%macro avx-logical-xor 3
    vxorps %1, %2, %3
%endmacro
%macro avx-logical-xor-double 3
    vxorpd %1, %2, %3
%endmacro
; --- AVX: Blend ---
%macro avx-blend-variables-packed-single 3
    vblendvps %1, %2, %3
%endmacro
%macro avx-blend-variables-packed-double 3
    vblendvpd %1, %2, %3
%endmacro
%macro avx-blend-packed-single 4
    vblendps %1, %2, %3, %4
%endmacro
%macro avx-blend-packed-double 4
    vblendpd %1, %2, %3, %4
%endmacro
; --- AVX: Permute and Shuffle ---
%macro avx-permute-packed-single 3
    vpermilps %1, %2, %3
%endmacro
%macro avx-permute-packed-double 3
    vpermilpd %1, %2, %3
%endmacro
%macro avx-permute-two-128 4
    vperm2f128 %1, %2, %3, %4
%endmacro
%macro avx-shuffle-packed-single 4
    vshufps %1, %2, %3, %4
%endmacro
%macro avx-shuffle-packed-double 4
    vshufpd %1, %2, %3, %4
%endmacro
; --- AVX: Broadcast ---
%macro avx-broadcast-scalar-single 2
    vbroadcastss %1, %2
%endmacro
%macro avx-broadcast-scalar-double 2
    vbroadcastsd %1, %2
%endmacro
%macro avx-broadcast-128 2
    vbroadcastf128 %1, %2
%endmacro
; --- AVX: Insert/Extract ---
%macro avx-insert-128 4
    vinsertf128 %1, %2, %3, %4
%endmacro
%macro avx-extract-128 3
    vextractf128 %1, %2, %3
%endmacro
; --- AVX: Data Movement ---
%macro avx-move-aligned 2
    vmovaps %1, %2
%endmacro
%macro avx-move-unaligned 2
    vmovups %1, %2
%endmacro
%macro avx-move-aligned-double 2
    vmovapd %1, %2
%endmacro
%macro avx-move-unaligned-double 2
    vmovupd %1, %2
%endmacro
%macro avx-mask-load-packed-single 3
    vmaskmovps %1, %2, %3
%endmacro
%macro avx-mask-load-packed-double 3
    vmaskmovpd %1, %2, %3
%endmacro
%macro avx-mask-store-packed-single 3
    vmaskmovps %1, %2, %3
%endmacro
%macro avx-mask-store-packed-double 3
    vmaskmovpd %1, %2, %3
%endmacro
; --- AVX: Fused Multiply-Add (FMA) ---
%macro fma-add-multiply-packed-single 4
    vfmadd132ps %1, %2, %3, %4
%endmacro
%macro fma-add-multiply-packed-double 4
    vfmadd132pd %1, %2, %3, %4
%endmacro
%macro fma-add-multiply-scalar-single 4
    vfmadd132ss %1, %2, %3, %4
%endmacro
%macro fma-add-multiply-scalar-double 4
    vfmadd132sd %1, %2, %3, %4
%endmacro
%macro fma-subtract-multiply-packed-single 4
    vfmsub132ps %1, %2, %3, %4
%endmacro
%macro fma-subtract-multiply-packed-double 4
    vfmsub132pd %1, %2, %3, %4
%endmacro
%macro fma-add-subtract-multiply-packed-single 3
    vfmaddsubps %1, %2, %3
%endmacro
%macro fma-add-subtract-multiply-packed-double 3
    vfmaddsubpd %1, %2, %3
%endmacro
%macro fma-subtract-add-multiply-packed-single 3
    vfmsubaddps %1, %2, %3
%endmacro
%macro fma-subtract-add-multiply-packed-double 3
    vfmsubaddpd %1, %2, %3
%endmacro
%macro fma-negative-add-multiply-packed-single 4
    vfnmadd132ps %1, %2, %3, %4
%endmacro
%macro fma-negative-subtract-multiply-packed-single 4
    vfnmsub132ps %1, %2, %3, %4
%endmacro
; --- AVX2: Integer Operations ---
%macro avx2-gather-dwords 5
    vgatherdps %1, %2, %3, %4, %5
%endmacro
%macro avx2-gather-qwords 5
    vgatherqps %1, %2, %3, %4, %5
%endmacro
%macro avx2-permute-128 4
    vperm2i128 %1, %2, %3, %4
%endmacro
%macro avx2-broadcast-byte 2
    vpbroadcastb %1, %2
%endmacro
%macro avx2-broadcast-word 2
    vpbroadcastw %1, %2
%endmacro
%macro avx2-broadcast-dword 2
    vpbroadcastd %1, %2
%endmacro
%macro avx2-broadcast-qword 2
    vpbroadcastq %1, %2
%endmacro
%macro avx2-shift-left-logical-variable-dwords 3
    vpsllvd %1, %2, %3
%endmacro
%macro avx2-shift-left-logical-variable-qwords 3
    vpsllvq %1, %2, %3
%endmacro
%macro avx2-shift-right-arithmetic-variable-dwords 3
    vpsravd %1, %2, %3
%endmacro
%macro avx2-shift-right-logical-variable-dwords 3
    vpsrlvd %1, %2, %3
%endmacro
%macro avx2-shift-right-logical-variable-qwords 3
    vpsrlvq %1, %2, %3
%endmacro
%macro avx2-multiply-low-packed-dwords 3
    vpmulld %1, %2, %3
%endmacro
%macro avx2-mask-load 3
    vpmaskmovd %1, %2, %3
%endmacro
%macro avx2-mask-load-qword 3
    vpmaskmovq %1, %2, %3
%endmacro
%macro avx2-permute-bytes 3
    vpermps %1, %2, %3
%endmacro
%macro avx2-permute-bytes-double 3
    vpermpd %1, %2, %3
%endmacro
; --- AVX: Register State ---
%macro avx-zero-upper 0
    vzeroupper
%endmacro
%macro avx-zero-all 0
    vzeroall
%endmacro
; ============================================================================
; SECTION 9: AES INSTRUCTIONS
; ============================================================================
%macro aes-encrypt 2
    aesenc %1, %2
%endmacro
%macro aes-encrypt-last 2
    aesenclast %1, %2
%endmacro
%macro aes-decrypt 2
    aesdec %1, %2
%endmacro
%macro aes-decrypt-last 2
    aesdeclast %1, %2
%endmacro
%macro aes-inverse-mix-columns 2
    aesimc %1, %2
%endmacro
%macro aes-key-generate-assist 3
    aeskeygenassist %1, %2, %3
%endmacro
; ============================================================================
; SECTION 10: CLMUL INSTRUCTION
; ============================================================================
%macro carryless-multiply 3
    pclmulqdq %1, %2, %3
%endmacro
; ============================================================================
; SECTION 11: SYSTEM AND PRIVILEGED INSTRUCTIONS
; ============================================================================
%macro enter-stack-frame 2
    enter %1, %2
%endmacro
%macro leave-stack-frame 0
    leave
%endmacro
%macro swap-general-purpose-register 1
    swapgs %1
%endmacro
%macro syscall-invoke 0
    syscall
%endmacro
%macro sysret-return 0
    sysret
%endmacro
%macro debug-interrupt 0
    int3
%endmacro
%macro debug-interrupt-1 0
    int1
%endmacro
%macro bound-check 2
    bound %1, %2
%endmacro
%macro invalidate-tlb 1
    invlpg %1
%endmacro
%macro read-time-stamp-counter 0
    rdtsc
%endmacro
%macro read-time-stamp-counter-processor 0
    rdtscp
%endmacro
%macro serialize 0
    serialize
%endmacro
%macro user-mode-instruction-prevention 0
    umip
%endmacro
; ============================================================================
; SECTION 12: VIRTUALIZATION INSTRUCTIONS
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
%macro vm-pointer-read 1
    vmptrld %1
%endmacro
%macro vm-pointer-store 1
    vmptrst %1
%endmacro
%macro vm-read 3
    vmread %1, %2
%endmacro
%macro vm-write 2
    vmwrite %1, %2
%endmacro
%macro vm-exit-interrupt-info 1
    vmxoff %1
%endmacro
; ============================================================================
; SECTION 13: SGX INSTRUCTIONS
; ============================================================================
%macro sgx-enter-enclave 0
    eenter
%endmacro
%macro sgx-resume-enclave 0
    eresume
%endmacro
%macro sgx-accept-page 0
    eaccept
%endmacro
%macro sgx-add-page 0
    eadd
%endmacro
%macro sgx-block 0
    eblock
%endmacro
%macro sgx-create-page 0
    ecreate
%endmacro
%macro sgx-debug 0
    edbgwr
%endmacro
%macro sgx-extend 0
    eextend
%endmacro
%macro sgx-init 0
    einit
%endmacro
%macro sgx-load-block 0
    eloadblock
%endmacro
%macro sgx-modify-page-type 0
    emodt
%endmacro
%macro sgx-modify-page-permissions 0
    emodpr
%endmacro
%macro sgx-remove-page 0
    eremove
%endmacro
%macro sgx-track 0
    etrack
%endmacro
; ============================================================================
; SECTION 14: TSX (Transactional Synchronization Extensions)
; ============================================================================
%macro transaction-begin 0
    xbegin
%endmacro
%macro transaction-end 0
    xend
%endmacro
%macro transaction-abort 1
    xabort %1
%endmacro
%macro test-transaction 0
    xtest
%endmacro
; ============================================================================
; SECTION 15: SHA EXTENSIONS
; ============================================================================
%macro sha-message-schedule-1 3
    sha1msg1 %1, %2, %3
%endmacro
%macro sha-message-schedule-2 3
    sha1msg2 %1, %2, %3
%endmacro
%macro sha-next-message 3
    sha1nexte %1, %2, %3
%endmacro
%macro sha-round-1 4
    sha1rnds4 %1, %2, %3, %4
%endmacro
%macro sha256-message-schedule-1 3
    sha256msg1 %1, %2, %3
%endmacro
%macro sha256-message-schedule-2 3
    sha256msg2 %1, %2, %3
%endmacro
%macro sha256-round-2 3
    sha256rnds2 %1, %2, %3
%endmacro
; ============================================================================
; SECTION 16: MISCELLANEOUS AND UTILITY MACROS
; ============================================================================
; --- Define Constants ---
%define true  1
%define false 0
%define null  0
; --- Common Immediate Values ---
%define byte-max    255
%define word-max    65535
%define dword-max   4294967295
; --- Stack Alignment ---
%define stack-align-16  and rsp, -16
%define stack-align-32  and rsp, -32
; --- Common Patterns ---
%macro return-zero 0
    xor eax, eax
%endmacro
%macro return-one 0
    mov eax, 1
%endmacro
%macro clear-register 1
    xor %1, %1
%endmacro
%macro set-register-to-negative-one 1
    or %1, -1
%endmacro
%macro align-stack 1
    and rsp, ~(%1 - 1)
%endmacro
; ============================================================================
; END OF READABLE ASSEMBLY MACROS
; ============================================================================