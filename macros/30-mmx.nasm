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

