package disasm

import (
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
)

func repoPath(t *testing.T, rel string) string {
	t.Helper()
	_, file, _, ok := runtime.Caller(0)
	if !ok {
		t.Fatal("no caller")
	}
	p := filepath.Join(filepath.Dir(file), "..", "..", "..", "..", rel)
	if _, err := os.Stat(p); err != nil {
		t.Skip(err)
	}
	return p
}

func TestLoadSamples(t *testing.T) {
	samples := []string{
		filepath.Join("build", "hello_elf.o"),
		filepath.Join("build", "hello_win.o"),
		filepath.Join("build", "hello.exe"),
	}
	for _, rel := range samples {
		path := repoPath(t, rel)
		bin, err := LoadFile(path)
		if err != nil {
			t.Fatalf("%s: %v", rel, err)
		}
		if len(bin.Sections) == 0 {
			t.Fatalf("%s: no sections", rel)
		}
		idx := DefaultSection(bin)
		sec := bin.Sections[idx]
		res := Disassemble(sec, Options{Base: sec.Addr, Mode: bin.Mode})
		insns := 0
		labels := 0
		readable := 0
		for _, row := range res.Rows {
			if row.Kind == RowLabel {
				labels++
				continue
			}
			insns++
			if strings.Contains(row.Readable, "move") ||
				strings.Contains(row.Readable, "push_onto_stack") ||
				strings.Contains(row.Readable, "call_procedure") ||
				strings.Contains(row.Readable, "jump") {
				readable++
			}
		}
		if insns < 3 {
			t.Fatalf("%s: only %d instructions in %s", rel, insns, sec.Name)
		}
		if readable == 0 {
			t.Fatalf("%s: no readable instructions in %s\n%s", rel, sec.Name, FormatListing(bin, sec, sec.Addr, res.Rows[:min(8, len(res.Rows))]))
		}
		t.Logf("%s format=%s section=%s insns=%d labels=%d readable=%d", rel, bin.Format, sec.Name, insns, labels, readable)
	}
}
