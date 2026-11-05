// rasmdis is a disassembler for x86-64 binaries.
// The listing shows Intel syntax and the Readable Assembly names from
// readable_macros.nasm.
//
//	rasmdis                     open the window
//	rasmdis file.exe            open the window on a file
//	rasmdis -dump file.exe      write a listing to stdout
package main

import (
	"flag"
	"fmt"
	"os"
	"strconv"

	"rasmdis/internal/disasm"
)

func main() {
	dump := flag.String("dump", "", "write a listing of this file to stdout and exit")
	section := flag.String("section", "", "section name to list with -dump")
	mode := flag.Int("mode", 0, "decode mode: 16, 32, or 64. 0 keeps the file default")
	baseFlag := flag.String("base", "", "base address for -dump, for example 0x140001000")
	start := flag.Int("start", 0, "first byte offset inside the section")
	flag.Parse()

	if *dump != "" {
		if err := runDump(*dump, *section, *mode, *baseFlag, *start); err != nil {
			fmt.Fprintln(os.Stderr, "rasmdis:", err)
			os.Exit(1)
		}
		return
	}
	initial := ""
	if flag.NArg() > 0 {
		initial = flag.Arg(0)
	}
	runGUI(initial)
}

func runDump(path, section string, mode int, baseText string, start int) error {
	bin, err := disasm.LoadFile(path)
	if err != nil {
		return err
	}
	idx := disasm.DefaultSection(bin)
	if section != "" {
		found := false
		for i, s := range bin.Sections {
			if s.Name == section {
				idx = i
				found = true
				break
			}
		}
		if !found {
			return fmt.Errorf("section %q not found", section)
		}
	}
	sec := bin.Sections[idx]
	base := sec.Addr
	if baseText != "" {
		base, err = strconv.ParseUint(baseText, 0, 64)
		if err != nil {
			return fmt.Errorf("base: %w", err)
		}
	}
	if mode == 0 {
		mode = bin.Mode
	}
	res := disasm.Disassemble(sec, disasm.Options{
		Base:  base,
		Mode:  mode,
		Start: start,
	})
	fmt.Print(disasm.FormatListing(bin, sec, base, res.Rows))
	if res.Truncated {
		fmt.Fprintf(os.Stderr, "rasmdis: listing stopped after %d bytes\n", disasm.DefaultWindow)
	}
	return nil
}
