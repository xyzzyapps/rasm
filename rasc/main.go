// Command rasc compiles a tiny, strongly typed C dialect to Readable Assembly.
// There is no C standard library and no optimisation. Each operation is translated
// on its own. An asm block is copied into the output as rasm.
//
//	rasc -o out.asm prog.c
//
// Assemble the result from the repo root:
//
//	nasm -f win64 out.asm -o out.o -I . && gcc out.o -o out.exe
package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	outFlag := flag.String("o", "", "output .asm file")
	flag.Usage = func() {
		fmt.Fprintf(os.Stderr, "usage: rasc [-o out.asm] file.c\n")
		flag.PrintDefaults()
	}
	flag.Parse()
	if flag.NArg() != 1 {
		flag.Usage()
		os.Exit(2)
	}
	input := flag.Arg(0)
	src, err := os.ReadFile(input)
	if err != nil {
		fmt.Fprintf(os.Stderr, "rasc: %v\n", err)
		os.Exit(1)
	}
	asm, err := Compile(string(src))
	if err != nil {
		fmt.Fprintf(os.Stderr, "rasc: %v\n", err)
		os.Exit(1)
	}
	output := *outFlag
	if output == "" {
		output = strings.TrimSuffix(input, filepath.Ext(input)) + ".asm"
	}
	if err := os.WriteFile(output, []byte(asm), 0o644); err != nil {
		fmt.Fprintf(os.Stderr, "rasc: %v\n", err)
		os.Exit(1)
	}
}

// Compile parses, type-checks, and translates src to rasm text.
func Compile(src string) (string, error) {
	prog, err := parse(src)
	if err != nil {
		return "", err
	}
	return generate(prog)
}
