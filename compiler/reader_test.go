package main

import (
	"reflect"
	"testing"
)

func mustRead(t *testing.T, src string) []Node {
	t.Helper()
	forms, err := NewReader(src).ReadAll()
	if err != nil {
		t.Fatalf("ReadAll(%q): %v", src, err)
	}
	return forms
}

func TestReaderNumbers(t *testing.T) {
	forms := mustRead(t, "42 -7 0x10 0XFF")
	want := []Node{Num{42}, Num{-7}, Num{16}, Num{255}}
	if !reflect.DeepEqual(forms, want) {
		t.Errorf("got %v, want %v", forms, want)
	}
}

func TestReaderSymbolsAndLists(t *testing.T) {
	forms := mustRead(t, "(define x 5) (f a b)")
	if len(forms) != 2 {
		t.Fatalf("expected 2 forms, got %d", len(forms))
	}
	l, ok := forms[0].(List)
	if !ok || len(l.Items) != 3 {
		t.Fatalf("first form malformed: %v", forms[0])
	}
	if AtomName(l.Items[0]) != "define" || AtomName(l.Items[1]) != "x" {
		t.Errorf("unexpected first form: %v", l.Items)
	}
}

func TestReaderComments(t *testing.T) {
	forms := mustRead(t, "; hello\n(define x 1) ; trailing\n")
	if len(forms) != 1 {
		t.Fatalf("expected 1 form after comments, got %d", len(forms))
	}
}

func TestReaderMemOperand(t *testing.T) {
	forms := mustRead(t, "(asm (move accumulator_64 [buf + data_64*8]))")
	asm := ListItems(forms[0])
	if len(asm) != 2 {
		t.Fatalf("unexpected asm form: %v", forms[0])
	}
	m := ListItems(asm[1])
	if len(m) != 3 {
		t.Fatalf("unexpected move form: %v", asm[1])
	}
	mem, ok := m[2].(Mem)
	if !ok || mem.Text != "[buf + data_64*8]" {
		t.Errorf("mem token = %q, want %q", mem.Text, "[buf + data_64*8]")
	}
}

func TestReaderOperatorSymbols(t *testing.T) {
	forms := mustRead(t, "(+ a b) (< n 2) (zero? x) (set! c (+ c 1))")
	for _, f := range forms {
		if _, ok := f.(List); !ok {
			t.Errorf("expected list, got %v", f)
		}
	}
}

func TestReaderUnclosedList(t *testing.T) {
	if _, err := NewReader("(define x").ReadAll(); err == nil {
		t.Error("expected error for unclosed list")
	}
}

func TestReaderUnclosedMem(t *testing.T) {
	if _, err := NewReader("(asm (move accumulator_64 [buf))").ReadAll(); err == nil {
		t.Error("expected error for unclosed memory operand")
	}
}

func TestReaderEmpty(t *testing.T) {
	if forms := mustRead(t, "  \n\t; nothing\n"); len(forms) != 0 {
		t.Errorf("expected no forms, got %v", forms)
	}
}

func TestReaderNestedMemBrackets(t *testing.T) {
	forms := mustRead(t, "(asm (x [a + b*[c+1]]))")
	asm := ListItems(forms[0])
	x := ListItems(asm[1])
	mem, ok := x[1].(Mem)
	if !ok || mem.Text != "[a + b*[c+1]]" {
		t.Errorf("nested mem token = %q", mem.Text)
	}
}
