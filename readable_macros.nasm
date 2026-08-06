; ============================================================================
; READABLE MACROS - Complete x86-64 NASM Preprocessor Macros
; ============================================================================
; Comprehensive English-underscore macro names for ALL x86-64 instructions.
; Covers 1000+ instruction mnemonics across all categories.
;
; Usage: %include "readable_macros.nasm"
;
; Or include individual sections:
;   %include "macros/01-registers.nasm"
;   %include "macros/05-data-movement.nasm"
;   etc.
; ============================================================================

; --- Registers and Definitions ---
%include "macros/01-registers.nasm"
%include "macros/02-flags.nasm"
%include "macros/03-sizes.nasm"
%include "macros/04-segments.nasm"

; --- Core Instructions ---
%include "macros/05-data-movement.nasm"
%include "macros/06-arithmetic.nasm"
%include "macros/07-logic.nasm"
%include "macros/08-shift-rotate.nasm"
%include "macros/09-bit-manipulation.nasm"
%include "macros/10-jumps.nasm"
%include "macros/11-loops.nasm"
%include "macros/12-procedures.nasm"
%include "macros/13-stack.nasm"
%include "macros/14-flag-control.nasm"
%include "macros/15-setcc.nasm"
%include "macros/16-strings.nasm"
%include "macros/17-repeat-prefixes.nasm"
%include "macros/18-io.nasm"
%include "macros/19-interrupts.nasm"
%include "macros/20-system.nasm"
%include "macros/21-cache-memory.nasm"
%include "macros/22-flag-transfer.nasm"

; --- x87 FPU ---
%include "macros/23-fpu-data-transfer.nasm"
%include "macros/24-fpu-constants.nasm"
%include "macros/25-fpu-arithmetic.nasm"
%include "macros/26-fpu-transcendental.nasm"
%include "macros/27-fpu-comparison.nasm"
%include "macros/28-fpu-control.nasm"
%include "macros/29-fpu-conditional-move.nasm"

; --- MMX ---
%include "macros/30-mmx.nasm"

; --- SSE Family ---
%include "macros/31-sse.nasm"
%include "macros/32-sse2.nasm"
%include "macros/33-sse3.nasm"
%include "macros/34-ssse3.nasm"
%include "macros/35-sse41.nasm"
%include "macros/36-sse42.nasm"

; --- AES and Carry-Less Multiply ---
%include "macros/37-aes.nasm"
%include "macros/38-pclmulqdq.nasm"

; --- AVX Family ---
%include "macros/39-avx.nasm"
%include "macros/40-avx2.nasm"
%include "macros/41-fma.nasm"

; --- AVX-512 ---
%include "macros/42-avx512-masks.nasm"

; --- SHA ---
%include "macros/43-sha.nasm"

; --- GFNI ---
%include "macros/44-gfni.nasm"

; --- MPX ---
%include "macros/45-mpx.nasm"

; --- BMI ---
%include "macros/46-bmi.nasm"

; --- ADX ---
%include "macros/47-adx.nasm"

; --- Bound ---
%include "macros/49-bound.nasm"

; --- Newer Extensions ---
%include "macros/50-newer-extensions.nasm"

; --- SGX ---
%include "macros/51-sgx.nasm"

; --- XSAVE ---
%include "macros/52-xsave.nasm"

; --- TSX ---
%include "macros/53-tsx.nasm"

; --- User Interrupts ---
%include "macros/54-user-interrupts.nasm"

; --- PTWRITE ---
%include "macros/55-ptwrite.nasm"

; --- VMX ---
%include "macros/57-vmx.nasm"

; --- CET Shadow Stack ---
%include "macros/60-cet-shadow-stack.nasm"
