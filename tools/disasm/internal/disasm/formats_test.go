package disasm

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"os"
	"strings"
	"testing"
)

func TestArchiveOfCOFF(t *testing.T) {
	path := repoPath(t, "build/hello_win.o")
	obj, err := os.ReadFile(path)
	if err != nil {
		t.Fatal(err)
	}
	ar := wrapArchive("hello_win.o", obj)
	got, _, err := loadMagic("hello.lib", bytes.NewReader(ar), header8(ar))
	if err != nil {
		t.Fatal(err)
	}
	if !strings.Contains(got.Format, "archive") {
		t.Fatalf("format %q", got.Format)
	}
	idx := DefaultSection(got)
	sec := got.Sections[idx]
	if !strings.Contains(sec.Name, "hello_win.o/") {
		t.Fatalf("section name %q", sec.Name)
	}
	res := Disassemble(sec, Options{Base: sec.Addr, Mode: sec.Mode})
	if !listingHas(res, "push_onto_stack") && !listingHas(res, "move") {
		t.Fatalf("archive member did not decode to readable names")
	}
}

func TestMachOObjectReadable(t *testing.T) {
	raw := syntheticMachO()
	bin, err := loadMachOFile("fact.o", bytes.NewReader(raw), "")
	if err != nil {
		t.Fatal(err)
	}
	if bin.Format != "Mach-O 64 object" {
		t.Fatalf("format %q", bin.Format)
	}
	if len(bin.Sections) != 1 || bin.Sections[0].Name != "__text" {
		t.Fatalf("sections %+v", bin.Sections)
	}
	res := Disassemble(bin.Sections[0], Options{Base: 0, Mode: 64})
	text := FormatListing(bin, bin.Sections[0], 0, res.Rows)
	if !strings.Contains(text, "move accumulator, 0x2a") {
		t.Fatalf("readable name missing:\n%s", text)
	}
	if !strings.Contains(text, "fact:") {
		t.Fatalf("symbol missing:\n%s", text)
	}
}

func TestDLLLabel(t *testing.T) {
	path := repoPath(t, "build/SDL2.dll")
	bin, err := LoadFile(path)
	if err != nil {
		t.Fatal(err)
	}
	if !strings.Contains(bin.Format, "DLL") {
		t.Fatalf("format %q", bin.Format)
	}
	sec := bin.Sections[DefaultSection(bin)]
	res := Disassemble(sec, Options{Base: sec.Addr, Mode: bin.Mode, MaxBytes: 4096})
	if !listingHas(res, "move") && !listingHas(res, "push_onto_stack") && !listingHas(res, "call_procedure") && !listingHas(res, "jump") {
		t.Fatalf("dll section %s has no readable instruction", sec.Name)
	}
}

func listingHas(res Result, needle string) bool {
	for _, row := range res.Rows {
		if strings.Contains(row.Readable, needle) {
			return true
		}
	}
	return false
}

func header8(b []byte) [8]byte {
	var m [8]byte
	copy(m[:], b)
	return m
}

func wrapArchive(name string, data []byte) []byte {
	if !strings.HasSuffix(name, "/") {
		name += "/"
	}
	hdr := fmt.Sprintf("%-16s%-12d%-6d%-6d%-8o%-10d`\n", name, 0, 0, 0, 0644, len(data))
	if len(hdr) != 60 {
		panic(len(hdr))
	}
	var buf bytes.Buffer
	buf.WriteString("!<arch>\n")
	buf.WriteString(hdr)
	buf.Write(data)
	if len(data)%2 == 1 {
		buf.WriteByte('\n')
	}
	return buf.Bytes()
}

// syntheticMachO builds a Mach-O 64 object whose __text is "mov rax, 0x2a"
// and whose symbol is fact.
func syntheticMachO() []byte {
	const (
		headerSize = 32
		segSize    = 72
		sectSize   = 80
		symCmdSize = 24
	)
	codeOff := headerSize + segSize + sectSize + symCmdSize
	code := []byte{0x48, 0xc7, 0xc0, 0x2a, 0x00, 0x00, 0x00}
	symOff := codeOff + len(code)
	if symOff%8 != 0 {
		symOff += 8 - symOff%8
	}
	strOff := symOff + 16
	strs := []byte{0, 'f', 'a', 'c', 't', 0}

	buf := make([]byte, strOff+len(strs))
	le := binary.LittleEndian
	// mach_header_64
	le.PutUint32(buf[0:], 0xfeedfacf)
	le.PutUint32(buf[4:], uint32(0x01000007)) // CPU_TYPE_X86_64
	le.PutUint32(buf[8:], 3)
	le.PutUint32(buf[12:], 1) // MH_OBJECT
	le.PutUint32(buf[16:], 2) // ncmds
	le.PutUint32(buf[20:], segSize+sectSize+symCmdSize)
	// LC_SEGMENT_64
	off := headerSize
	le.PutUint32(buf[off:], 0x19)
	le.PutUint32(buf[off+4:], segSize+sectSize)
	copy(buf[off+8:], []byte("__TEXT"))
	le.PutUint64(buf[off+40:], uint64(codeOff)) // fileoff
	le.PutUint64(buf[off+48:], uint64(len(code)))
	le.PutUint32(buf[off+56:], 7)
	le.PutUint32(buf[off+60:], 7)
	le.PutUint32(buf[off+64:], 1) // nsects
	// section
	so := off + segSize
	copy(buf[so:], []byte("__text"))
	copy(buf[so+16:], []byte("__TEXT"))
	le.PutUint64(buf[so+40:], uint64(len(code)))
	le.PutUint32(buf[so+48:], uint32(codeOff))
	le.PutUint32(buf[so+64:], 0x80000400)
	// LC_SYMTAB
	sy := so + sectSize
	le.PutUint32(buf[sy:], 2)
	le.PutUint32(buf[sy+4:], symCmdSize)
	le.PutUint32(buf[sy+8:], uint32(symOff))
	le.PutUint32(buf[sy+12:], 1)
	le.PutUint32(buf[sy+16:], uint32(strOff))
	le.PutUint32(buf[sy+20:], uint32(len(strs)))
	copy(buf[codeOff:], code)
	// nlist_64: name index 1, N_SECT|N_EXT, section 1
	le.PutUint32(buf[symOff:], 1)
	buf[symOff+4] = 0x0f
	buf[symOff+5] = 1
	copy(buf[strOff:], strs)
	return buf
}
