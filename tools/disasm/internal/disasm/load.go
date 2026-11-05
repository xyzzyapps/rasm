package disasm

import (
	"bytes"
	"debug/elf"
	"debug/pe"
	"encoding/binary"
	"fmt"
	"io"
	"os"
	"sort"
	"strings"
)

// Reloc is one relocation inside a section.
// Offset is the section offset of the relocated field.
type Reloc struct {
	Offset uint64
	Name   string
}

// Section is one loaded piece of a binary.
type Section struct {
	Name   string
	Addr   uint64
	Code   bool
	Mode   int // 16, 32, or 64. Zero uses the file mode.
	Data   []byte
	Labels map[uint64][]string
	Relocs []Reloc
}

// Binary is a loaded file.
type Binary struct {
	Path     string
	Name     string
	Format   string
	Mode     int
	Sections []Section
}

// LoadFile opens a C or C++ binary.
// It accepts ELF executables and .so files, Mach-O executables and .dylib
// files, Windows .exe and .dll files, COFF objects, and .a or .lib archives.
// A file with no known header is raw bytes.
func LoadFile(path string) (*Binary, error) {
	f, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer f.Close()

	var magic [8]byte
	_, _ = io.ReadFull(f, magic[:])
	bin, recognized, err := loadMagic(baseName(path), f, magic)
	if err != nil {
		return nil, err
	}
	if bin == nil && !recognized {
		if b, err := loadPEFile(baseName(path), mustReader(f), true); err == nil {
			bin = b
		} else {
			return loadRaw(path)
		}
	}
	if bin == nil {
		return nil, fmt.Errorf("file has no loadable bytes")
	}
	bin.Path = path
	bin.Name = baseName(path)
	stamp(bin)
	return bin, nil
}

// loadMagic parses a file whose header is in magic.
// recognized is true when the header is a known container, even if parsing fails.
func loadMagic(name string, r io.ReaderAt, magic [8]byte) (*Binary, bool, error) {
	switch {
	case bytes.Equal(magic[:4], []byte{0x7f, 'E', 'L', 'F'}):
		b, err := loadELFFile(name, r)
		return b, true, err
	case magic[0] == 'M' && magic[1] == 'Z':
		b, err := loadPEFile(name, r, false)
		return b, true, err
	case isMachO(magic[:4]):
		b, err := loadMachOFile(name, r, "")
		return b, true, err
	case isFat(magic[:4]):
		b, err := loadFatFile(name, r)
		return b, true, err
	case bytes.Equal(magic[:], []byte("!<arch>\n")):
		b, err := loadArchive(name, r)
		return b, true, err
	case bytes.Equal(magic[:], []byte("!<thin>\n")):
		return nil, true, fmt.Errorf("thin archive has no object bytes")
	default:
		return nil, false, nil
	}
}

func mustReader(f *os.File) io.ReaderAt {
	_, _ = f.Seek(0, io.SeekStart)
	return f
}

// LoadBytes builds a one-section binary from raw machine code.
func LoadBytes(name string, data []byte, mode int) *Binary {
	if mode != 16 && mode != 32 && mode != 64 {
		mode = 64
	}
	return &Binary{
		Name:   name,
		Format: "raw",
		Mode:   mode,
		Sections: []Section{{
			Name:   "bytes",
			Code:   true,
			Data:   append([]byte(nil), data...),
			Labels: map[uint64][]string{},
		}},
	}
}

func loadRaw(path string) (*Binary, error) {
	data, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}
	b := LoadBytes(baseName(path), data, 64)
	b.Path = path
	b.Format = "raw"
	b.Sections[0].Name = "file"
	return b, nil
}

func loadELFFile(name string, r io.ReaderAt) (*Binary, error) {
	f, err := elf.NewFile(r)
	if err != nil {
		return nil, err
	}

	mode := 0
	format := ""
	switch f.Machine {
	case elf.EM_X86_64:
		mode = 64
		format = "ELF64"
	case elf.EM_386:
		mode = 32
		format = "ELF32"
	default:
		return nil, fmt.Errorf("ELF machine %s is not x86", f.Machine)
	}
	if f.Class == elf.ELFCLASS32 {
		format = "ELF32"
	}
	switch f.Type {
	case elf.ET_DYN:
		format += " shared object"
	case elf.ET_EXEC:
		format += " executable"
	case elf.ET_REL:
		format += " object"
	}

	syms, _ := f.Symbols()
	dyn, _ := f.DynamicSymbols()
	relocs := elfRelocs(f, syms, dyn)
	relocFile := f.Type == elf.ET_REL

	var sections []Section
	for i, s := range f.Sections {
		if s.Type == elf.SHT_NULL || s.Type == elf.SHT_NOBITS {
			continue
		}
		if s.Size == 0 || s.Name == "" {
			continue
		}
		// Relocation and string sections are not code.
		if s.Type == elf.SHT_RELA || s.Type == elf.SHT_REL || s.Type == elf.SHT_STRTAB || s.Type == elf.SHT_SYMTAB {
			continue
		}
		data, err := s.Data()
		if err != nil || len(data) == 0 {
			continue
		}
		sec := Section{
			Name:   s.Name,
			Addr:   s.Addr,
			Code:   s.Flags&elf.SHF_EXECINSTR != 0 || codeName(s.Name),
			Mode:   mode,
			Data:   data,
			Labels: map[uint64][]string{},
			Relocs: relocs[i],
		}
		if relocFile {
			sec.Addr = 0
		}
		for _, sym := range syms {
			addELFSymbol(&sec, i, sym, relocFile, s.Addr)
		}
		for _, sym := range dyn {
			addELFSymbol(&sec, i, sym, relocFile, s.Addr)
		}
		sortLabels(sec.Labels)
		sections = append(sections, sec)
	}
	if len(sections) == 0 {
		for _, p := range f.Progs {
			if p.Type != elf.PT_LOAD || p.Filesz == 0 {
				continue
			}
			buf := make([]byte, p.Filesz)
			if _, err := p.ReadAt(buf, 0); err != nil {
				continue
			}
			sections = append(sections, Section{
				Name:   fmt.Sprintf("load_%#x", p.Vaddr),
				Addr:   p.Vaddr,
				Code:   p.Flags&elf.PF_X != 0,
				Mode:   mode,
				Data:   buf,
				Labels: map[uint64][]string{},
			})
		}
	}
	if len(sections) == 0 {
		return nil, fmt.Errorf("ELF file has no section bytes")
	}
	return &Binary{
		Name:     name,
		Format:   format,
		Mode:     mode,
		Sections: sections,
	}, nil
}

func addELFSymbol(sec *Section, index int, sym elf.Symbol, relocFile bool, secAddr uint64) {
	name := sym.Name
	if name == "" || name == sec.Name {
		return
	}
	switch elf.ST_TYPE(sym.Info) {
	case elf.STT_FILE, elf.STT_SECTION:
		return
	}
	if sym.Section == elf.SHN_UNDEF || sym.Section >= elf.SHN_LORESERVE {
		return
	}
	var off uint64
	if relocFile {
		if sym.Section != elf.SectionIndex(index) {
			return
		}
		off = sym.Value
	} else {
		if sym.Value < secAddr {
			return
		}
		off = sym.Value - secAddr
	}
	if off > uint64(len(sec.Data)) {
		return
	}
	addLabel(sec.Labels, off, name)
}

func elfRelocs(f *elf.File, static, dynamic []elf.Symbol) map[int][]Reloc {
	out := map[int][]Reloc{}
	if f.Class != elf.ELFCLASS64 {
		return out
	}
	for _, s := range f.Sections {
		if s.Type != elf.SHT_RELA && s.Type != elf.SHT_REL {
			continue
		}
		syms := static
		if int(s.Link) < len(f.Sections) && f.Sections[s.Link].Name == ".dynsym" {
			syms = dynamic
		}
		target := int(s.Info)
		data, err := s.Data()
		if err != nil {
			continue
		}
		step := 16
		if s.Type == elf.SHT_RELA {
			step = 24
		}
		for off := 0; off+step <= len(data); off += step {
			rOff := binary.LittleEndian.Uint64(data[off:])
			info := binary.LittleEndian.Uint64(data[off+8:])
			var addend int64
			if step == 24 {
				addend = int64(binary.LittleEndian.Uint64(data[off+16:]))
			}
			// File.Symbols omits the null symbol, so index x is syms[x-1].
			symi := int(elf.R_SYM64(info))
			if symi <= 0 || symi-1 >= len(syms) {
				continue
			}
			sym := syms[symi-1]
			name := sym.Name
			if name == "" && int(sym.Section) >= 0 && int(sym.Section) < len(f.Sections) {
				name = f.Sections[sym.Section].Name
			}
			if name == "" {
				continue
			}
			name = withAddend(name, elf.R_X86_64(elf.R_TYPE64(info)), addend)
			out[target] = append(out[target], Reloc{Offset: rOff, Name: name})
		}
	}
	return out
}

func withAddend(name string, typ elf.R_X86_64, addend int64) string {
	switch typ {
	case elf.R_X86_64_PC32, elf.R_X86_64_PLT32, elf.R_X86_64_GOTPCREL:
		if addend == -4 || addend == 0 {
			return name
		}
	}
	if addend == 0 {
		return name
	}
	if addend > 0 {
		return fmt.Sprintf("%s+%#x", name, addend)
	}
	return fmt.Sprintf("%s-%#x", name, -addend)
}

func loadPEFile(name string, r io.ReaderAt, object bool) (*Binary, error) {
	f, err := pe.NewFile(r)
	if err != nil {
		return nil, err
	}

	mode := 0
	switch f.Machine {
	case pe.IMAGE_FILE_MACHINE_AMD64:
		mode = 64
	case pe.IMAGE_FILE_MACHINE_I386:
		mode = 32
	default:
		return nil, fmt.Errorf("PE machine %#x is not x86", f.Machine)
	}
	if object && (f.NumberOfSections == 0 || f.NumberOfSections > 128) {
		return nil, fmt.Errorf("not a COFF object")
	}

	format := "COFF"
	var imageBase uint64
	if f.SizeOfOptionalHeader > 0 && f.OptionalHeader != nil {
		switch oh := f.OptionalHeader.(type) {
		case *pe.OptionalHeader64:
			format = "PE32+"
			imageBase = oh.ImageBase
		case *pe.OptionalHeader32:
			format = "PE32"
			imageBase = uint64(oh.ImageBase)
		}
	}
	if object && f.SizeOfOptionalHeader == 0 {
		format = "COFF object"
	} else if f.Characteristics&0x2000 != 0 {
		format += " DLL"
	} else if format != "COFF" {
		format += " executable"
	}

	var sections []Section
	for idx, s := range f.Sections {
		data, err := s.Data()
		if err != nil || len(data) == 0 {
			continue
		}
		addr := imageBase + uint64(s.VirtualAddress)
		if format == "COFF" {
			addr = 0
		}
		sec := Section{
			Name:   s.Name,
			Addr:   addr,
			Code:   s.Characteristics&0x20000000 != 0 || s.Characteristics&0x20 != 0 || codeName(s.Name),
			Mode:   mode,
			Data:   data,
			Labels: map[uint64][]string{},
		}
		for _, r := range s.Relocs {
			name := coffSymbolName(f, r.SymbolTableIndex)
			if name == "" {
				continue
			}
			sec.Relocs = append(sec.Relocs, Reloc{Offset: uint64(r.VirtualAddress), Name: name})
		}
		for _, sym := range f.Symbols {
			if int(sym.SectionNumber) != idx+1 {
				continue
			}
			if sym.StorageClass == 103 || sym.StorageClass == 104 || sym.StorageClass == 105 {
				continue
			}
			if sym.Name == "" || sym.Name == s.Name {
				continue
			}
			addLabel(sec.Labels, uint64(sym.Value), sym.Name)
		}
		sortLabels(sec.Labels)
		sections = append(sections, sec)
	}
	if len(sections) == 0 {
		return nil, fmt.Errorf("file has no section bytes")
	}
	return &Binary{
		Name:     name,
		Format:   format,
		Mode:     mode,
		Sections: sections,
	}, nil
}

func coffSymbolName(f *pe.File, idx uint32) string {
	if int(idx) >= len(f.COFFSymbols) {
		return ""
	}
	name, err := f.COFFSymbols[idx].FullName(f.StringTable)
	if err != nil {
		return ""
	}
	return name
}

func codeName(name string) bool {
	switch strings.ToLower(name) {
	case ".text", ".init", ".fini", ".plt", ".plt.sec", "__text", "__stubs", "__stub_helper":
		return true
	default:
		return false
	}
}

func stamp(bin *Binary) {
	if bin == nil {
		return
	}
	for i := range bin.Sections {
		if bin.Sections[i].Mode == 0 {
			bin.Sections[i].Mode = bin.Mode
		}
		if bin.Sections[i].Labels == nil {
			bin.Sections[i].Labels = map[uint64][]string{}
		}
	}
}

func addLabel(m map[uint64][]string, off uint64, name string) {
	for _, n := range m[off] {
		if n == name {
			return
		}
	}
	m[off] = append(m[off], name)
}

func sortLabels(m map[uint64][]string) {
	for off := range m {
		sort.Strings(m[off])
	}
}

func baseName(path string) string {
	i := strings.LastIndexAny(path, `/\`)
	if i >= 0 {
		return path[i+1:]
	}
	return path
}

// DefaultSection returns the first code section, or 0.
func DefaultSection(bin *Binary) int {
	if bin == nil || len(bin.Sections) == 0 {
		return 0
	}
	for i, s := range bin.Sections {
		if s.Code {
			return i
		}
	}
	return 0
}

// SectionChoices returns the labels for the section list.
func SectionChoices(bin *Binary) []string {
	if bin == nil {
		return nil
	}
	seen := map[string]int{}
	out := make([]string, len(bin.Sections))
	for i, s := range bin.Sections {
		n := seen[s.Name]
		seen[s.Name]++
		label := s.Name
		if n > 0 {
			label = fmt.Sprintf("%s #%d", s.Name, n+1)
		}
		if s.Code {
			label += " (code)"
		}
		out[i] = label
	}
	return out
}
