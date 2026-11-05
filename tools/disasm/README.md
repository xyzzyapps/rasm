# rasmdis

A disassembler with a Fyne window. The instruction column uses Readable
Assembly names (`move accumulator, 0x2a`). Select a line to see the Intel
mnemonic (`mov rax, 0x2a`).

The names are the same ones `readable_macros.nasm` and `readablify` use.
The core instruction set is translated. SSE, AVX, and other extensions keep
their Intel mnemonic. Register names inside them are still translated
(`xmm0` becomes `xmm_0`).

## Files

| System | Files |
|---|---|
| Windows | `.exe`, `.dll`, `.lib`, COFF `.obj` |
| Linux | ELF executable, `.so`, `.o`, `.a` |
| macOS | Mach-O executable, `.dylib`, `.o`, `.a`, universal (x86 slice) |

`.lib` and `.a` are archives of object files. The section list shows
`member.o/.text`. A universal Mach-O file uses its x86_64 or i386 slice.

## Build

The window needs CGO and a C compiler (MinGW gcc on Windows).

```bash
cd tools/disasm
go build -o ../../build/rasmdis.exe .
```

## Window

```bash
build/rasmdis.exe
build/rasmdis.exe build/hello.exe
```

- **Open** reads the Windows, Linux, and macOS files in the table above.
  You can also drop a file on the window. Raw bytes still open.
- You can also drop a file on the window.
- **Paste hex** decodes a byte string. `0x` prefixes, spaces, and an objdump
  address column are accepted.
- The section list marks code sections. Base and start take hex (`0x1000`).
  Press Enter to apply them.
- **Filter** keeps rows whose address, Intel text, or readable text matches.
- **Export** writes a text listing. **Copy line** copies the selected row.
- A byte the decoder rejects is shown as `define_byte`.

## Listing without the window

```bash
rasmdis -dump build/hello_elf.o
rasmdis -dump build/hello.exe -section .text
rasmdis -dump shell.bin -mode 64 -base 0x401000 -start 0
```

## Tests

```bash
cd tools/disasm
go test ./internal/disasm/
```

The tests decode known byte strings and load `build/hello_elf.o`,
`build/hello_win.o`, and `build/hello.exe` when those files are present.
