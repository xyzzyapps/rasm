; ============================================================================
; hello.lisp - rasl feature demo
;
; A minimal Lisp that compiles to Readable Assembly (rasm). This program
; exercises every feature of the v1 language:
;   define-struct, global, define-array, define (scalar + function),
;   if, cond, while, begin, set!, label, goto, asm, print, exit,
;   + - * / < > = zero?, array-get/set, struct-get/set
;
; Build (from the repo root):
;   compiler/rasl examples/lisp/hello.lisp -o build/hello.asm
;   nasm -f win64 build/hello.asm -o build/hello.o && gcc build/hello.o -o build/hello.exe
;   build/hello.exe
;
; Expected output:
;   2 6 24 7 7 55 99
; ============================================================================

; A point with a qword x, dword y and byte tag (offsets computed by rasm).
(define-struct point (x : qword) (y : dword) (tag : byte))

(global count)
(define magic 99)
(define-array buf 4)

; Recursive functions - arguments live on the stack.
(define (fact n)
  (if (< n 2) 1 (* n (fact (- n 1)))))

; cond chains multiple tests.
(define (fib n)
  (cond ((< n 2) n)
        (else (+ (fib (- n 1)) (fib (- n 2))))))

; while + begin + set! + print + array/struct access + asm + goto/label.
(define (main)
  (set! count 0)
  (while (< count 3)
    (begin
      (print (fact (+ count 2)))
      (set! count (+ count 1))))
  (array-set buf 0 42)
  (struct-set buf point.x 7)
  (struct-set buf point.y 9)
  (print (array-get buf 0))
  (print (struct-get buf point.x))
  (asm (no_operation))
  (label skipme)
  (goto end)
  (print 999)
  (label end)
  (print (fib 10))
  (print magic)
  (exit 0))

