; ============================================================================
; 05-data-movement.nasm - Data Movement Instructions
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

; --- Move with Extension ---
%macro move-with-sign-extend 2
    movsx %1, %2
%endmacro

%macro move-with-sign-extend-dword 2
    movsxd %1, %2
%endmacro

%macro move-with-zero-extend 2
    movzx %1, %2
%endmacro

; --- Move with Byte Swap ---
%macro move-with-byte-swap 2
    movbe %1, %2
%endmacro

; --- Exchange ---
%macro exchange 2
    xchg %1, %2
%endmacro

%macro swap 2
    xchg %1, %2
%endmacro

%macro exchange-and-add 2
    xadd %1, %2
%endmacro

; --- Load Effective Address ---
%macro load-effective-address 2
    lea %1, %2
%endmacro

; --- Load Far Pointers ---
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

; --- Size Conversion ---
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

; --- String Move ---
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

; --- Translate ---
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
