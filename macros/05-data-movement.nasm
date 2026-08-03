; ============================================================================
; 05-data-movement.nasm - Data Movement Instructions
; ============================================================================

; --- Basic Move ---
%macro move 2
    mov %1, %2
%endmacro

%macro move_byte 2
    mov byte %1, %2
%endmacro

%macro move_word 2
    mov word %1, %2
%endmacro

%macro move_dword 2
    mov dword %1, %2
%endmacro

%macro move_qword 2
    mov qword %1, %2
%endmacro

; --- Move with Extension ---
%macro move_with_sign_extend 2
    movsx %1, %2
%endmacro

%macro move_with_sign_extend_dword 2
    movsxd %1, %2
%endmacro

%macro move_with_zero_extend 2
    movzx %1, %2
%endmacro

; --- Move with Byte Swap ---
%macro move_with_byte_swap 2
    movbe %1, %2
%endmacro

; --- Exchange ---
%macro exchange 2
    xchg %1, %2
%endmacro

%macro swap 2
    xchg %1, %2
%endmacro

%macro exchange_and_add 2
    xadd %1, %2
%endmacro

; --- Load Effective Address ---
%macro load_effective_address 2
    lea %1, %2
%endmacro

; --- Load Far Pointers ---
%macro load_pointer_ds 2
    lds %1, %2
%endmacro

%macro load_pointer_es 2
    les %1, %2
%endmacro

%macro load_pointer_fs 2
    lfs %1, %2
%endmacro

%macro load_pointer_gs 2
    lgs %1, %2
%endmacro

%macro load_pointer_ss 2
    lss %1, %2
%endmacro

; --- Size Conversion ---
%macro convert_byte_to_word 0
    cbw
%endmacro

%macro convert_word_to_dword 0
    cwd
%endmacro

%macro convert_dword_to_qword 0
    cdq
%endmacro

%macro convert_qword_to_oword 0
    cqo
%endmacro

%macro convert_byte_to_dword 0
    cwde
%endmacro

%macro convert_word_to_qword 0
    cdqe
%endmacro

; --- String Move ---
%macro move_string 0
    movs
%endmacro

%macro move_string_byte 0
    movsb
%endmacro

%macro move_string_word 0
    movsw
%endmacro

%macro move_string_dword 0
    movsd
%endmacro

%macro move_string_qword 0
    movsq
%endmacro

; --- Translate ---
%macro translate_byte 0
    xlat
%endmacro

; --- Conditional Move ---
%macro move_if_equal 2
    cmove %1, %2
%endmacro

%macro move_if_zero 2
    cmovz %1, %2
%endmacro

%macro move_if_not_equal 2
    cmovne %1, %2
%endmacro

%macro move_if_not_zero 2
    cmovnz %1, %2
%endmacro

%macro move_if_greater 2
    cmovg %1, %2
%endmacro

%macro move_if_greater_or_equal 2
    cmovge %1, %2
%endmacro

%macro move_if_less 2
    cmovl %1, %2
%endmacro

%macro move_if_less_or_equal 2
    cmovle %1, %2
%endmacro

%macro move_if_above 2
    cmova %1, %2
%endmacro

%macro move_if_above_or_equal 2
    cmovae %1, %2
%endmacro

%macro move_if_below 2
    cmovb %1, %2
%endmacro

%macro move_if_below_or_equal 2
    cmovbe %1, %2
%endmacro

%macro move_if_carry 2
    cmovc %1, %2
%endmacro

%macro move_if_not_carry 2
    cmovnc %1, %2
%endmacro

%macro move_if_overflow 2
    cmovo %1, %2
%endmacro

%macro move_if_not_overflow 2
    cmovno %1, %2
%endmacro

%macro move_if_sign 2
    cmovs %1, %2
%endmacro

%macro move_if_not_sign 2
    cmovns %1, %2
%endmacro

%macro move_if_parity 2
    cmovp %1, %2
%endmacro

%macro move_if_parity_even 2
    cmovpe %1, %2
%endmacro

%macro move_if_no_parity 2
    cmovnp %1, %2
%endmacro

%macro move_if_parity_odd 2
    cmovpo %1, %2
%endmacro

%macro move_if_not_above 2
    cmovna %1, %2
%endmacro

%macro move_if_not_above_or_equal 2
    cmovnae %1, %2
%endmacro

%macro move_if_not_below 2
    cmovnb %1, %2
%endmacro

%macro move_if_not_below_or_equal 2
    cmovnbe %1, %2
%endmacro

%macro move_if_not_greater 2
    cmovng %1, %2
%endmacro

%macro move_if_not_greater_or_equal 2
    cmovnge %1, %2
%endmacro

%macro move_if_not_less 2
    cmovnl %1, %2
%endmacro

%macro move_if_not_less_or_equal 2
    cmovnle %1, %2
%endmacro

; --- Compare and Exchange ---
%macro compare_and_exchange 2
    cmpxchg %1, %2
%endmacro

%macro compare_and_exchange_8_byte 1
    cmpxchg8b %1
%endmacro

%macro compare_and_exchange_16_byte 1
    cmpxchg16b %1
%endmacro

; --- Move Direct ---
%macro move_direct_indirect 2
    movdiri %1, %2
%endmacro

%macro move_direct_64_byte 2
    movdir64b %1, %2
%endmacro

; --- Enqueue ---
%macro enqueue_command 2
    enqcmd %1, %2
%endmacro

%macro enqueue_command_supervisor 2
    enqcmds %1, %2
%endmacro
