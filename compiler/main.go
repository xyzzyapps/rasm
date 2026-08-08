// Command rasl compiles a minimal Lisp (no lists, closures, or GC) into
// Readable Assembly (rasm): a .asm file built on readable_macros.nasm.
//
// Usage:
//
//	rasl [flags] <input.lisp>
//
// Flags:
//
//	-o <file>   write output to <file> (default: input with .asm extension)
//	-v          verbose logging to stderr
//
// The generated .asm must be assembled from the repo root so that
// "%include readable_macros.nasm" resolves:
//
//	Windows: nasm -f win64 out.asm -o out.o && gcc out.o -o out.exe
//	Linux:   nasm -f elf64 out.asm -o out.o && ld out.o -o out
package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	var (
		outFlag = flag.String("o", "", "output .asm file (default: input with .asm)")
		verbose = flag.Bool("v", false, "verbose logging")
	)
	flag.Usage = func() {
		fmt.Fprintf(os.Stderr, "usage: rasl [flags] <input.lisp>\n\n")
		flag.PrintDefaults()
	}
	flag.Parse()

	if flag.NArg() != 1 {
		flag.Usage()
		os.Exit(2)
	}
	input := flag.Arg(0)

	logger := log.New(os.Stderr, "rasl: ", 0)
	var logf func(string, ...any)
	if *verbose {
		logf = func(format string, args ...any) {
			logger.Printf(format, args...)
		}
	} else {
		logf = func(string, ...any) {}
	}

	src, err := os.ReadFile(input)
	if err != nil {
		logger.Fatalf("read %s: %v", input, err)
	}
	logf("read %s (%d bytes)", input, len(src))

	r := NewReader(string(src))
	forms, err := r.ReadAll()
	if err != nil {
		logger.Fatalf("parse %s: %v", input, err)
	}
	logf("parsed %d top-level forms", len(forms))

	c := NewCompiler(logf)
	out, err := c.Compile(forms)
	if err != nil {
		logger.Fatalf("compile %s: %v", input, err)
	}

	output := *outFlag
	if output == "" {
		ext := filepath.Ext(input)
		base := strings.TrimSuffix(input, ext)
		output = base + ".asm"
	}
	if err := os.WriteFile(output, []byte(out), 0o644); err != nil {
		logger.Fatalf("write %s: %v", output, err)
	}
	logf("wrote %s", output)
}
