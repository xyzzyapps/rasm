package disasm

import (
	"debug/macho"
	"encoding/binary"
	"fmt"
	"io"
	"strings"
)

const (
	machoNType = 0x0e
	machoNStab = 0xe0
	machoNSect = 0x0e
	// S_ATTR_SOME_INSTRUCTIONS and S_ATTR_PURE_INSTRUCTIONS.
	machoSomeIns = 0x00000400
	machoPureIns = 0x80000000
)

func isMachO(magic []byte) bool {
	if len(magic) < 4 {
		return false
	}
	le := binary.LittleEndian.Uint32(magic)
	be := binary.BigEndian.Uint32(magic)
	return le == macho.Magic32 || le == macho.Magic64 || be == macho.Magic32 || be == macho.Magic64
}

func isFat(magic []byte) bool {
	if len(magic) < 4 {
		return false
	}
	return binary.BigEndian.Uint32(magic) == macho.MagicFat
}

func loadMachOFile(name string, r io.ReaderAt, prefix string) (*Binary, error) {
	f, err := macho.NewFile(r)
	if err != nil {
		return nil, err
	}
	mode := 0
	bits := "64"
	switch f.Cpu {
	case macho.CpuAmd64:
		mode = 64
	case macho.Cpu386:
		mode = 32
		bits = "32"
	default:
		return nil, fmt.Errorf("Mach-O cpu %s is not x86", f.Cpu)
	}
	kind := "object"
	switch f.Type {
	case macho.TypeExec:
		kind = "executable"
	case macho.TypeDylib:
		kind = "dylib"
	case macho.TypeBundle:
		kind = "bundle"
	}
	format := fmt.Sprintf("Mach-O %s %s", bits, kind)
	objectFile := f.Type == macho.TypeObj

	var sections []Section
	for i, s := range f.Sections {
		if s.Size == 0 || s.Name == "" {
			continue
		}
		data, err := s.Data()
		if err != nil || len(data) == 0 {
			continue
		}
		secName := s.Name
		if prefix != "" {
			secName = prefix + "/" + secName
		}
		sec := Section{
			Name:   secName,
			Addr:   s.Addr,
			Code:   s.Flags&machoPureIns != 0 || s.Flags&machoSomeIns != 0 || codeName(s.Name),
			Mode:   mode,
			Data:   data,
			Labels: map[uint64][]string{},
		}
		if f.Symtab != nil {
			for _, sym := range f.Symtab.Syms {
				if sym.Type&machoNStab != 0 || sym.Type&machoNType != machoNSect {
					continue
				}
				if int(sym.Sect) != i+1 || sym.Name == "" || sym.Name == s.Name {
					continue
				}
				off := sym.Value
				if !objectFile {
					if sym.Value < s.Addr {
						continue
					}
					off = sym.Value - s.Addr
				}
				if off > uint64(len(data)) {
					continue
				}
				addLabel(sec.Labels, off, sym.Name)
			}
		}
		for _, rel := range s.Relocs {
			relName := machoRelocName(f, rel)
			if relName == "" {
				continue
			}
			sec.Relocs = append(sec.Relocs, Reloc{Offset: uint64(rel.Addr), Name: relName})
		}
		sortLabels(sec.Labels)
		sections = append(sections, sec)
	}
	if len(sections) == 0 {
		return nil, fmt.Errorf("Mach-O file has no section bytes")
	}
	return &Binary{
		Name:     name,
		Format:   format,
		Mode:     mode,
		Sections: sections,
	}, nil
}

func machoRelocName(f *macho.File, rel macho.Reloc) string {
	if rel.Scattered || f.Symtab == nil {
		return ""
	}
	if rel.Extern {
		if int(rel.Value) >= 0 && int(rel.Value) < len(f.Symtab.Syms) {
			return f.Symtab.Syms[rel.Value].Name
		}
		return ""
	}
	if rel.Value > 0 && int(rel.Value) <= len(f.Sections) {
		return f.Sections[rel.Value-1].Name
	}
	return ""
}

func loadFatFile(name string, r io.ReaderAt) (*Binary, error) {
	ff, err := macho.NewFatFile(r)
	if err != nil {
		return nil, err
	}
	var sections []Section
	var format string
	mode := 64
	var skipped []string
	x86 := 0
	for _, arch := range ff.Arches {
		if arch.Cpu != macho.CpuAmd64 && arch.Cpu != macho.Cpu386 {
			skipped = append(skipped, arch.Cpu.String())
			continue
		}
		x86++
	}
	for _, arch := range ff.Arches {
		if arch.Cpu != macho.CpuAmd64 && arch.Cpu != macho.Cpu386 {
			continue
		}
		prefix := ""
		if x86 > 1 {
			prefix = "x86_64"
			if arch.Cpu == macho.Cpu386 {
				prefix = "i386"
			}
		}
		b, err := loadMachOFile(name, io.NewSectionReader(r, int64(arch.Offset), int64(arch.Size)), prefix)
		if err != nil {
			skipped = append(skipped, err.Error())
			continue
		}
		if format == "" {
			format = b.Format
			mode = b.Mode
		}
		sections = append(sections, b.Sections...)
	}
	if len(sections) == 0 {
		extra := ""
		if len(skipped) > 0 {
			extra = " (" + strings.Join(skipped, ", ") + ")"
		}
		return nil, fmt.Errorf("Mach-O universal binary has no x86 slice%s", extra)
	}
	if x86 > 1 {
		format = "Mach-O universal"
	} else {
		format += " universal"
	}
	return &Binary{
		Name:     name,
		Format:   format,
		Mode:     mode,
		Sections: sections,
	}, nil
}
