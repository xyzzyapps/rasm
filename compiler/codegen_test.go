package main

import (
	"strings"
	"testing"
)

// compileSrc parses and compiles a snippet, failing the test on error.
func compileSrc(t *testing.T, src string) string {
	t.Helper()
	forms, err := NewReader(src).ReadAll()
	if err != nil {
		t.Fatalf("parse: %v", err)
	}
	out, err := NewCompiler(nil).Compile(forms)
	if err != nil {
		t.Fatalf("compile: %v", err)
	}
	return out
}

// mustContain checks that out contains every expected substring.
func mustContain(t *testing.T, out string, expected ...string) {
	t.Helper()
	for _, e := range expected {
		if !strings.Contains(out, e) {
			t.Errorf("output missing %q\n--- output ---\n%s", e, out)
		}
	}
}

func TestCompileHeader(t *testing.T) {
	out := compileSrc(t, "(global x)")
	mustContain(t, out,
		"%include \"readable_macros.nasm\"",
		"default rel",
		"section .data",
		"x: define_qword 0",
		"section .text",
	)
}

func TestCompileStruct(t *testing.T) {
	out := compileSrc(t, "(define-struct point (x: qword) (y: dword) (tag: byte))")
	mustContain(t, out,
		"begin_struct point",
		"struct_qword x",
		"struct_dword y",
		"struct_byte tag",
		"end_struct",
	)
}

func TestCompileArithAndIf(t *testing.T) {
	out := compileSrc(t, `
(global n)
(define (f x) (if (< x 2) 1 (* x (f (- x 1)))))
`)
	mustContain(t, out,
		"f:",
		"push_onto_stack base_pointer",
		"compare accumulator_64, 0",
		"jump_if_equal .if_0_else",
		"signed_multiply data_64",
		"set_if_less accumulator_8",
		"return_from_procedure",
	)
}

func TestCompileWhileAndBegin(t *testing.T) {
	out := compileSrc(t, `
(global c)
(define (main)
  (set! c 0)
  (while (< c 3)
    (begin (print c) (set! c (+ c 1)))))
`)
	mustContain(t, out,
		".while_0_start:",
		"jump .while_0_start",
		"call_procedure rasl_print",
		"move [c], accumulator_64",
	)
}

func TestCompileCond(t *testing.T) {
	out := compileSrc(t, `
(define (f x)
  (cond ((< x 0) 1)
        ((= x 0) 2)
        (else 3)))
`)
	mustContain(t, out,
		".cond_0_next0:",
		".cond_0_end:",
	)
}

func TestCompileArrays(t *testing.T) {
	out := compileSrc(t, `
(define-array buf 4)
(define (f i v)
  (begin
    (array-set buf i v)
    (array-get buf i)))
(define (g) buf)
`)
	mustContain(t, out,
		"buf: reserve_qword 4",
		"move [counter_64 + data_64*8], accumulator_64",
		"move accumulator_64, [counter_64 + data_64*8]",
		"load_effective_address accumulator_64, [buf]",
		"load_effective_address counter_64, [buf]",
	)
}

func TestCompileStructAccess(t *testing.T) {
	out := compileSrc(t, `
(define-struct point (x: qword) (y: qword))
(define-array storage 2)
(define (f)
  (begin
    (struct-set storage point.x 7)
    (struct-get storage point.y)))
`)
	mustContain(t, out,
		"move [data_64 + point.x], accumulator_64",
		"move accumulator_64, [data_64 + point.y]",
	)
}

func TestCompileMixedStructSizes(t *testing.T) {
	out := compileSrc(t, `
(define-struct header (magic: dword) (version: byte) (flags: qword))
(define-array h 4)
(define (f)
  (begin
    (struct-set h header.magic 0x464C457F)
    (struct-set h header.version 1)
    (struct-get h header.magic)
    (struct-get h header.flags)))
`)
	mustContain(t, out,
		"struct_dword magic",
		"struct_byte version",
		"struct_qword flags",
		"struct_field pad0, 3", // magic(0..4) version(4..5) pad to 8 for flags
		"move_dword [data_64 + header.magic], accumulator_32",
		"move_byte [data_64 + header.version], accumulator_8",
		"movzx accumulator_64, dword [data_64 + header.magic]   ; dword field",
		"move accumulator_64, [data_64 + header.flags]",
	)
}

func TestCompileAsmBlock(t *testing.T) {
	out := compileSrc(t, `(define (main)
  (asm (move accumulator_64 60) (syscall_invoke)))`)
	mustContain(t, out,
		"move accumulator_64, 60",
		"syscall_invoke",
	)
}

func TestCompileAsmMemOperand(t *testing.T) {
	out := compileSrc(t, `(define (main)
  (asm (move_byte [counter_64] data_8)))`)
	mustContain(t, out, "move_byte [counter_64], data_8")
}

func TestCompileLabelGoto(t *testing.T) {
	out := compileSrc(t, `
(define (main)
  (begin
    (label skip)
    (goto end)
    (print 999)
    (label end)
    (exit 0)))
`)
	mustContain(t, out,
		"skip:",
		"jump end",
		"end:",
	)
}

func TestCompileExit(t *testing.T) {
	out := compileSrc(t, `(define (main) (exit 3))`)
	mustContain(t, out,
		"jump rasl_exit",
		"rasl_exit:",
	)
}

func TestCompileDefaultMain(t *testing.T) {
	out := compileSrc(t, `(global x)`)
	mustContain(t, out, "rasl_main:")
}

func TestCompileUserMainEntry(t *testing.T) {
	out := compileSrc(t, `(define (main) (exit 0))`)
	mustContain(t, out,
		"rasl_main:",
		"call_procedure rasl_init",
	)
	if strings.Count(out, "rasl_main:") != 1 {
		t.Errorf("expected exactly one rasl_main label\n%s", out)
	}
}

func TestCompileErrors(t *testing.T) {
	cases := []struct {
		name string
		src  string
		want string
	}{
		{"undefined symbol", "(define (f) x)", "undefined symbol x"},
		{"undefined function", "(define (f) (nope 1))", "undefined function nope"},
		{"unknown struct", "(define (f) (struct-get p point.field_x))", "unknown struct point"},
		{"unknown field", "(define-struct p (x) (y)) (define (f) (struct-get 0 p.field_z))", "no field"},
		{"duplicate", "(global x) (global x)", "duplicate definition"},
		{"mem outside asm", "(define (f) [buf])", "only valid inside (asm"},
		{"func as value", "(define (g) 1) (define (h) g)", "not a value"},
		{"top-level decl", "(define (f) (global x))", "only allowed at top level"},
		{"reserved name", "(global counter)", "reserved rasm name"},
		{"reserved name array", "(define-array base 4)", "reserved rasm name"},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			forms, err := NewReader(tc.src).ReadAll()
			if err != nil {
				t.Fatalf("parse: %v", err)
			}
			_, cerr := NewCompiler(nil).Compile(forms)
			if cerr == nil {
				t.Fatalf("expected error containing %q", tc.want)
			}
			if !strings.Contains(cerr.Error(), tc.want) {
				t.Errorf("error %q does not contain %q", cerr, tc.want)
			}
		})
	}
}
