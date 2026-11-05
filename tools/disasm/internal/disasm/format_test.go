package disasm

import (
	"strings"
	"testing"
)

func TestCoreEncodings(t *testing.T) {
	cases := []struct {
		hex      string
		base     uint64
		intel    string
		readable string
	}{
		{"48c7c02a000000", 0x401000, "mov rax, 0x2a", "move accumulator, 0x2a"},
		{"55", 0x401000, "push rbp", "push_onto_stack base_pointer"},
		{"4801d8", 0x401000, "add rax, rbx", "add accumulator, base"},
		{"4889e5", 0x401000, "mov rbp, rsp", "move base_pointer, stack_pointer"},
		{"7400", 0x2000, "jz 0x2002", "jump_if_zero 0x2002"},
		{"e800000000", 0x2000, "call 0x2005", "call_procedure 0x2005"},
		{"c3", 0x2000, "ret", "return_from_procedure"},
		{"0f05", 0x2000, "syscall", "syscall_invoke"},
		{"f3aa", 0x2000, "", "repeat store_string_byte"},
		{"830001", 0x2000, "", "add_dword [accumulator], 0x1"},
		{"4989c8", 0x2000, "", "move register_r8, counter"},
		{"0fb600", 0x2000, "", "move_with_zero_extend_byte accumulator_32, [accumulator]"},
	}
	for _, tc := range cases {
		raw, err := ParseHex(tc.hex)
		if err != nil {
			t.Fatal(err)
		}
		sec := Section{Name: ".text", Data: raw}
		got := Disassemble(sec, Options{Base: tc.base, Mode: 64, MaxBytes: len(raw)})
		var insn *Row
		for i := range got.Rows {
			if got.Rows[i].Kind == RowInsn {
				insn = &got.Rows[i]
				break
			}
		}
		if insn == nil {
			t.Fatalf("%s: no instruction", tc.hex)
		}
		if tc.intel != "" && insn.Intel != tc.intel {
			t.Errorf("%s intel\n got %q\nwant %q", tc.hex, insn.Intel, tc.intel)
		}
		if insn.Readable != tc.readable {
			t.Errorf("%s readable\n got %q\nwant %q\n intel %q", tc.hex, insn.Readable, tc.readable, insn.Intel)
		}
	}
}

func TestZeroImmediateIsNotFirstLabel(t *testing.T) {
	raw, err := ParseHex("b800000000")
	if err != nil {
		t.Fatal(err)
	}
	sec := Section{
		Name:   ".text",
		Data:   raw,
		Labels: map[uint64][]string{0: {"fact"}},
	}
	got := Disassemble(sec, Options{Base: 0, Mode: 64, MaxBytes: len(raw)})
	for _, row := range got.Rows {
		if row.Kind != RowInsn {
			continue
		}
		if strings.Contains(row.Intel, "fact") || strings.Contains(row.Readable, "fact") {
			t.Fatalf("immediate zero became a symbol: %s / %s", row.Intel, row.Readable)
		}
		if row.Readable != "move accumulator_32, 0x0" {
			t.Fatalf("got %s (%s)", row.Readable, row.Intel)
		}
	}
}

func TestRelocAndLabel(t *testing.T) {
	sec := Section{
		Name:   ".text",
		Data:   []byte{0xe8, 0, 0, 0, 0, 0xc3},
		Labels: map[uint64][]string{0: {"_start"}},
		Relocs: []Reloc{{Offset: 1, Name: "write_str"}},
	}
	got := Disassemble(sec, Options{Base: 0x1000, Mode: 64, MaxBytes: len(sec.Data)})
	text := FormatListing(&Binary{Name: "t", Format: "COFF"}, sec, 0x1000, got.Rows)
	if !strings.Contains(text, "_start:") {
		t.Fatalf("missing label:\n%s", text)
	}
	if !strings.Contains(text, "call_procedure write_str") {
		t.Fatalf("missing reloc name:\n%s", text)
	}
}

func TestParseHex(t *testing.T) {
	got, err := ParseHex("0x48, c7 c0\n401000:\t48 c7 c0 2a ; comment")
	if err != nil {
		t.Fatal(err)
	}
	if HexBytes(got) != "48 c7 c0 48 c7 c0 2a" {
		t.Fatalf("%s", HexBytes(got))
	}
	if _, err := ParseHex("zz"); err == nil {
		t.Fatal("expected an error")
	}
}
