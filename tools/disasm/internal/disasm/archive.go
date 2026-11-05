package disasm

import (
	"bytes"
	"fmt"
	"io"
	"strconv"
	"strings"
)

type arMember struct {
	Name string
	Data []byte
}

// loadArchive reads a static library (.a or .lib).
// Each member is an ELF object, a Mach-O object, or a COFF object.
func loadArchive(name string, r io.ReaderAt) (*Binary, error) {
	members, err := readArchive(r)
	if err != nil {
		return nil, err
	}
	var sections []Section
	formats := map[string]struct{}{}
	mode := 64
	for _, m := range members {
		b, err := loadMember(m.Name, m.Data)
		if err != nil || b == nil {
			continue
		}
		formats[b.Format] = struct{}{}
		if len(sections) == 0 {
			mode = b.Mode
		}
		for _, s := range b.Sections {
			if s.Mode == 0 {
				s.Mode = b.Mode
			}
			s.Name = m.Name + "/" + s.Name
			sections = append(sections, s)
		}
	}
	if len(sections) == 0 {
		return nil, fmt.Errorf("archive has no x86 object code")
	}
	format := "archive"
	if len(formats) == 1 {
		for k := range formats {
			format = "archive of " + k
		}
	}
	return &Binary{
		Name:     name,
		Format:   format,
		Mode:     mode,
		Sections: sections,
	}, nil
}

func loadMember(name string, data []byte) (*Binary, error) {
	if len(data) < 8 {
		return nil, fmt.Errorf("member is too small")
	}
	// A Windows import header is not an object file.
	if data[0] == 0 && data[1] == 0 && data[2] == 0xff && data[3] == 0xff {
		return nil, fmt.Errorf("import header")
	}
	r := bytes.NewReader(data)
	var magic [8]byte
	copy(magic[:], data)
	switch {
	case bytes.Equal(magic[:4], []byte{0x7f, 'E', 'L', 'F'}):
		return loadELFFile(name, r)
	case magic[0] == 'M' && magic[1] == 'Z':
		return loadPEFile(name, r, false)
	case isMachO(magic[:4]):
		return loadMachOFile(name, r, "")
	case isFat(magic[:4]):
		return loadFatFile(name, r)
	default:
		return loadPEFile(name, r, true)
	}
}

func readArchive(r io.ReaderAt) ([]arMember, error) {
	var magic [8]byte
	if _, err := r.ReadAt(magic[:], 0); err != nil {
		return nil, err
	}
	if string(magic[:]) != "!<arch>\n" {
		return nil, fmt.Errorf("not an archive")
	}
	var members []arMember
	var longNames []byte
	off := int64(8)
	for {
		var hdr [60]byte
		n, err := r.ReadAt(hdr[:], off)
		if n == 0 || err == io.EOF {
			break
		}
		if n < 60 {
			break
		}
		if hdr[58] != '`' || hdr[59] != '\n' {
			return nil, fmt.Errorf("bad archive header at %#x", off)
		}
		size, err := strconv.ParseInt(strings.TrimSpace(string(hdr[48:58])), 10, 64)
		if err != nil || size < 0 {
			return nil, fmt.Errorf("bad archive member size")
		}
		if size > 256<<20 {
			return nil, fmt.Errorf("archive member is too large")
		}
		name := strings.TrimRight(string(hdr[:16]), " ")
		data := make([]byte, size)
		if _, err := r.ReadAt(data, off+60); err != nil {
			return nil, err
		}
		next := off + 60 + size
		if next%2 != 0 {
			next++
		}
		off = next

		if strings.HasPrefix(name, "#1/") {
			n, err := strconv.Atoi(name[3:])
			if err != nil || n < 0 || n > len(data) {
				continue
			}
			name = strings.TrimRight(string(data[:n]), "\x00 ")
			data = data[n:]
		}
		switch {
		case name == "/":
			continue
		case name == "//":
			longNames = data
			continue
		case strings.HasPrefix(name, "/"):
			idx, err := strconv.Atoi(name[1:])
			if err != nil {
				continue
			}
			name = archiveLongName(longNames, idx)
		}
		name = strings.TrimSuffix(strings.TrimSpace(name), "/")
		if name == "" {
			continue
		}
		members = append(members, arMember{Name: name, Data: data})
	}
	return members, nil
}

func archiveLongName(table []byte, idx int) string {
	if idx < 0 || idx >= len(table) {
		return ""
	}
	end := idx
	for end < len(table) && table[end] != '\n' && table[end] != 0 {
		end++
	}
	return strings.TrimSuffix(string(table[idx:end]), "/")
}
