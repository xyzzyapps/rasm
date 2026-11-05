package disasm

import (
	"errors"
	"fmt"
	"strings"

	"golang.org/x/arch/x86/x86asm"
)

// DefaultWindow is the number of bytes decoded in one view.
const DefaultWindow = 256 * 1024

// RowKind tells a label row from an instruction row.
type RowKind int

const (
	RowInsn RowKind = iota
	RowLabel
)

// Row is one line of a disassembly listing.
type Row struct {
	Kind     RowKind
	Addr     uint64
	Offset   uint64
	Bytes    []byte
	Intel    string
	Readable string
}

// Options controls one decode.
type Options struct {
	Base     uint64
	Mode     int // 16, 32, or 64. Zero means 64.
	Start    int
	MaxBytes int // Zero means DefaultWindow.
}

// Result is the decoded window.
type Result struct {
	Rows      []Row
	Truncated bool
}

// Disassemble decodes a section with a linear sweep.
// A byte the decoder rejects becomes define_byte.
func Disassemble(sec Section, opt Options) Result {
	mode := opt.Mode
	if mode != 16 && mode != 32 && mode != 64 {
		mode = 64
	}
	maxBytes := opt.MaxBytes
	if maxBytes <= 0 {
		maxBytes = DefaultWindow
	}
	start := opt.Start
	if start < 0 {
		start = 0
	}
	if start > len(sec.Data) {
		start = len(sec.Data)
	}
	end := len(sec.Data)
	truncated := false
	if start+maxBytes < end {
		end = start + maxBytes
		truncated = true
	}
	code := sec.Data[start:end]
	base := opt.Base

	symname := func(addr uint64) (string, uint64) {
		// Address 0 is also the encoding of an immediate zero. Do not
		// turn "mov eax, 0" into a reference to the first label.
		if addr == 0 || addr < base {
			return "", 0
		}
		off := addr - base
		names := sec.Labels[off]
		if len(names) == 0 {
			return "", 0
		}
		return names[0], addr
	}

	var rows []Row
	i := 0
	for i < len(code) {
		off := uint64(start + i)
		pc := base + off
		for _, name := range sec.Labels[off] {
			rows = append(rows, Row{
				Kind:     RowLabel,
				Addr:     pc,
				Offset:   off,
				Readable: name + ":",
			})
		}
		inst, err := x86asm.Decode(code[i:], mode)
		if err != nil || inst.Len <= 0 || i+inst.Len > len(code) {
			if errors.Is(err, x86asm.ErrTruncated) && end < len(sec.Data) {
				truncated = true
				break
			}
			b := code[i]
			rows = append(rows, Row{
				Kind:     RowInsn,
				Addr:     pc,
				Offset:   off,
				Bytes:    []byte{b},
				Intel:    fmt.Sprintf("db %#x", b),
				Readable: fmt.Sprintf("define_byte %#x", b),
			})
			i++
			continue
		}
		raw := append([]byte(nil), code[i:i+inst.Len]...)
		intel := x86asm.IntelSyntax(inst, pc, symname)
		// IntelSyntax writes "$name" for some 32-bit immediates.
		intel = strings.ReplaceAll(intel, ", $", ", ")
		intel = strings.ReplaceAll(intel, " $", " ")
		intel = annotate(intel, inst, pc, relocAt(sec.Relocs, off, inst.Len))
		rows = append(rows, Row{
			Kind:     RowInsn,
			Addr:     pc,
			Offset:   off,
			Bytes:    raw,
			Intel:    intel,
			Readable: toReadable(intel),
		})
		i += inst.Len
	}
	return Result{Rows: rows, Truncated: truncated}
}

func relocAt(relocs []Reloc, off uint64, n int) string {
	end := off + uint64(n)
	for _, r := range relocs {
		if r.Offset >= off && r.Offset < end && r.Name != "" {
			return r.Name
		}
	}
	return ""
}

// FormatListing writes a text listing. The readable form is the main line.
// The Intel form is a comment under that line.
func FormatListing(bin *Binary, sec Section, base uint64, rows []Row) string {
	var sb strings.Builder
	name := ""
	format := ""
	if bin != nil {
		name = bin.Name
		format = bin.Format
	}
	fmt.Fprintf(&sb, "; rasmdis listing\n")
	fmt.Fprintf(&sb, "; file: %s\n", name)
	fmt.Fprintf(&sb, "; format: %s\n", format)
	fmt.Fprintf(&sb, "; section: %s\n", sec.Name)
	fmt.Fprintf(&sb, "; base: %#x\n", base)
	for _, r := range rows {
		switch r.Kind {
		case RowLabel:
			fmt.Fprintf(&sb, "\n%s\n", r.Readable)
		default:
			fmt.Fprintf(&sb, "%#x  %-24s  %s\n", r.Addr, HexBytes(r.Bytes), r.Readable)
			if r.Intel != "" {
				fmt.Fprintf(&sb, "; intel: %s\n", r.Intel)
			}
		}
	}
	return sb.String()
}
