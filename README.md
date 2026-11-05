# Readable Assembly (rasm)

English-underscore NASM macros that make x86-64 assembly code readable and self-documenting.

> **New here?** Start with [TUTORIAL.md](TUTORIAL.md) — a hands-on guide from
> "Hello, World" to the SDL game demo.

## Overview

Readable Assembly provides 1000+ macro definitions that replace cryptic x86-64 instruction mnemonics with descriptive English names. Write assembly that reads like documentation.

| Traditional | Readable Assembly |
|---|---|
| `mov rax, 10` | `move accumulator, 10` |
| `push rbp` | `push_onto_stack base_pointer` |
| `cmp rax, rbx` | `compare accumulator, base` |
| `je label` | `jump_if_equal label` |
| `call func` | `call_procedure func` |

## Features

- **Complete x86-64 coverage** — Core instructions, FPU, MMX, SSE, AVX, AVX-512, AES, SHA, BMI, and more
- **Modular includes** — Include the full macro set or pick individual categories
- **Zero runtime overhead** — Pure NASM preprocessor macros, no performance impact
- **Self-documenting code** — Instructions read like English descriptions
- **rasl compiler (Go)** — a minimal Lisp (no lists, closures, or GC) that
  compiles directly to readable assembly built on these macros. Structs map to
  `begin_struct`, arrays to `reserve_qword` blocks, and inline assembly is a
  first-class block written in rasm itself. See `compiler/` and
  `examples/lisp/`.

## Naming Conventions

- **Operands follow Intel order** — destination first, source second:
  `move accumulator, 10` means `mov rax, 10`.
- **Registers use their traditional names** — `accumulator` (`rax`), `base`
  (`rbx`), `counter` (`rcx`), `data` (`rdx`), `source_index` (`rsi`),
  `destination_index` (`rdi`), `base_pointer` (`rbp`), `stack_pointer` (`rsp`).
  Widths are explicit in the name: `accumulator_32` is `eax`, `accumulator_16`
  is `ax`, `accumulator_8` is `al`, `accumulator_8_high` is `ah`. The extended
  set keeps the explicit spelling: `register_r8` … `register_r15` with
  `register_r8_32` (`r8d`) forms. Exact names (`rax`, `eax`, `ax`, `al`)
  always work too.
- **Unsigned vs signed comparisons** — jumps and conditional moves use
  `above`/`below` for unsigned and `greater`/`less` for signed, mirroring
  `ja`/`jb` vs `jg`/`jl`.
- **Everything is lowercase, underscore-separated.**
- **Sized forms** — core arithmetic, logic and shift/rotate macros also come in
  `_byte` / `_word` / `_dword` / `_qword` variants that insert the operand-size
  qualifier for memory operands: `add_dword [score], 10` expands to
  `add dword [score], 10`. The same pattern covers `move_*`,
  `compare_*`, `logical_*`, `shift_*`, `rotate_*`, `multiply_*`, `divide_*`,
  `increment_*`, `decrement_*`, `negate_*` and `move_with_*_extend_*`.
- **Numeric sizes** — `byte_size` (1), `word_size` (2), `dword_size` (4),
  `qword_size` (8), `tword_size` (10), `oword_size` (16), `yword_size` (32),
  `zword_size` (64). Use them instead of magic numbers:
  `move accumulator_32, [base + dword_size]` instead of `[base + 4]`.
- **C-like structs** — `begin_struct` / `end_struct` compute field offsets
  for you, with `struct_byte` / `struct_word` / `struct_dword` /
  `struct_qword` / `struct_field` / `struct_nested` members. Access fields by
  name: `[base + player.field_score]`, nested: 
  `[base + entity.field_hitbox + rect.field_bottomright + point.field_y]`.
  Every struct publishes a `Type_size` constant for `reserve_byte`.

## Common Macro Cheat Sheet

| Readable Assembly | Instruction |
|---|---|
| `move dst, src` | `mov` |
| `load_effective_address dst, [mem]` | `lea` |
| `add dst, src` / `subtract dst, src` | `add` / `sub` |
| `add_dword [mem], n` (sized form) | `add dword [mem], n` |
| `increment x` / `decrement x` | `inc` / `dec` |
| `multiply x` / `signed_multiply x` | `mul` / `imul` |
| `compare a, b` | `cmp` |
| `logical_and/or/xor/not` | `and` / `or` / `xor` / `not` |
| `shift_logical_left dst, n` | `shl` |
| `jump label` / `jump_if_equal label` | `jmp` / `je` |
| `call_procedure f` / `return_from_procedure` | `call` / `ret` |
| `push_onto_stack x` / `pop_from_stack x` | `push` / `pop` |
| `syscall_invoke` | `syscall` |
| `no_operation` / `pause` | `nop` / `pause` |
| `greeting: define_byte "Hi!", 10, 0` | `db` (data) |
| `score: define_dword 100` / `define_qword` | `dd` / `dq` (data) |
| `buffer: reserve_byte 256` | `resb` (storage) |
| `equate answer, 42` | `equ` |
| `begin_struct point` / `end_struct` | struct layout (48-structs.nasm) |
| `struct_dword field_x` (member) | `point.field_x` = 0, `point_size` = 4 |
| `struct_nested field_hitbox, rect` | nested struct member |
| `[base + point.field_y]` / `dword_size` | named offset / numeric size |

## Quick Start

```nasm
%include "readable_macros.nasm"

section .text
    global _start

_start:
    move    accumulator, 42
    add     accumulator, 8
    compare accumulator, 50
    jump_if_equal   is_fifty
    jump            done

is_fifty:
    ; rax == 50
    jump done

done:
    move    accumulator, 60
    move    destination_index, 0
    syscall_invoke
```

Assemble with NASM (from the repo root, so `%include "readable_macros.nasm"`
resolves):

```bash
nasm -f elf64 examples/example.asm -o example.o
ld example.o -o example
```

## Project Structure

```
readable_assembly/
├── readable_macros.nasm      # Main entry point (includes all macros)
├── macros/
│   ├── 01-registers.nasm     # Register definitions (accumulator, base, counter, ...)
│   ├── 02-flags.nasm         # Flag definitions
│   ├── 03-sizes.nasm         # Size definitions
│   ├── 04-segments.nasm      # Segment definitions
│   ├── 05-data-movement.nasm # move, load, store, etc.
│   ├── 06-arithmetic.nasm    # add, subtract, multiply, etc.
│   ├── 07-logic.nasm         # logical_and, logical_or, etc.
│   ├── 08-shift-rotate.nasm  # shift/rotate instructions
│   ├── 09-bit-manipulation.nasm
│   ├── 10-jumps.nasm         # jump_if_equal, jump_if_greater, etc.
│   ├── 11-loops.nasm
│   ├── 12-procedures.nasm    # call_procedure, return_from_procedure
│   ├── 13-stack.nasm         # push_onto_stack, pop_from_stack
│   ├── ...
│   └── 60-cet-shadow-stack.nasm
├── examples/
│   ├── example.asm           # Basic usage examples
│   ├── fibonacci.asm         # Fibonacci with readable macros
│   ├── fibonacci_raw.asm     # Same program, raw NASM (for comparison)
│   ├── structs.asm           # C-like structs + nested structs demo
│   ├── sdl_rectangle.asm     # SDL2 game demo
│   └── lisp/
│       ├── hello.lisp        # rasl demo (every language feature)
│       └── hello.expected    # expected output for the test suite
├── compiler/                 # rasl: a Lisp that compiles to rasm (Go)
│   ├── main.go               # CLI
│   ├── reader.go             # s-expression reader
│   ├── codegen.go            # symbol table + code emission
│   ├── runtime.rasm          # embedded runtime (win64/elf64 via %ifidn)
│   └── *_test.go             # reader + codegen unit tests
├── tests/
│   ├── run_tests.sh          # Test suite
│   ├── run_lisp.sh           # rasl end-to-end tests
│   └── smoke_test.asm        # Runtime-verified macro smoke test
└── tools/
    ├── readablify/           # Go tool: raw NASM -> readable macros
    │   ├── main.go
    │   └── README.md
    └── disasm/               # Fyne disassembler: machine code -> rasm names
        ├── main.go
        ├── gui.go
        └── internal/disasm/
```

## Macro Categories

| Category | File | Examples |
|---|---|---|
| Registers | `01-registers.nasm` | `accumulator`, `base`, `counter`, `register_r8` |
| Data Movement | `05-data-movement.nasm` | `move`, `load_effective_address` |
| Arithmetic | `06-arithmetic.nasm` | `add`, `subtract`, `increment`, `multiply` |
| Logic | `07-logic.nasm` | `logical_and`, `logical_or`, `logical_xor` |
| Shift/Rotate | `08-shift-rotate.nasm` | `shift_logical_left`, `rotate_right` |
| Jumps | `10-jumps.nasm` | `jump_if_equal`, `jump_if_greater` |
| Procedures | `12-procedures.nasm` | `call_procedure`, `return_from_procedure` |
| Stack | `13-stack.nasm` | `push_onto_stack`, `pop_from_stack` |
| FPU | `23-29-fpu-*.nasm` | FPU data transfer, arithmetic, transcendental |
| SSE/AVX | `31-42-*.nasm` | SSE through AVX-512 instructions |
| Crypto | `37-aes.nasm`, `43-sha.nasm` | AES, SHA extensions |
| Structs | `48-structs.nasm` | `begin_struct`, `end_struct`, `struct_dword`, `struct_nested` |

## SDL2 Example

The project includes a complete SDL2 game (`examples/sdl_rectangle.asm`) that draws a colored rectangle and moves it with arrow keys.

**Linux:**
```bash
nasm -f elf64 examples/sdl_rectangle.asm -o sdl_rectangle.o
gcc sdl_rectangle.o -o sdl_rectangle -lSDL2 -no-pie
./sdl_rectangle
```

**Windows (MinGW):**
```bash
nasm -f win64 examples/sdl_rectangle.asm -o sdl_rectangle.o
gcc sdl_rectangle.o -o sdl_rectangle.exe -lSDL2
sdl_rectangle.exe
```

## readablify tool

`tools/readablify/` is a Go tool that converts raw NASM source into readable
assembly. It rewrites mnemonics, registers, sized forms and data directives,
then verifies the result is byte-identical machine code:

```bash
cd tools/readablify
go build -o readablify .
./readablify -verify examples/fibonacci_raw.asm
```

See [tools/readablify/README.md](tools/readablify/README.md) for full usage.

## rasmdis — disassembler

`tools/disasm/` is a Fyne window. The instruction column uses Readable
Assembly names. It opens Windows `.exe`, `.dll`, and `.lib` files, Linux ELF
executables and `.so` files, and macOS Mach-O executables and `.dylib` files.
The build needs CGO and gcc.

```bash
cd tools/disasm
go build -o ../../build/rasmdis.exe .
../../build/rasmdis.exe
../../build/rasmdis.exe -dump ../../build/hello.exe -section .text
```

See [tools/disasm/README.md](tools/disasm/README.md).

## rasl — a Lisp that compiles to readable assembly

`compiler/` is a small Go compiler for **rasl**, a minimal Lisp (no lists,
closures, or GC) that translates directly into readable assembly built on the
rasm macros. It is a very thin wrapper over rasm:

- **Values** are raw 64-bit integers. No tags, no heap, no garbage collector.
- **Structs** (`define-struct`) map to `begin_struct` with C-style alignment
  and sized field access: `(struct-set addr point.x v)` emits
  `move [data_64 + point.x], accumulator_64`.
- **Arrays** (`define-array`) are static `reserve_qword` blocks with
  register-based indexing.
- **Inline assembly is a first-class block** written in rasm itself:
  `(asm (move accumulator_64 60) (syscall_invoke))`.
- **Control flow**: `if`, `cond`, `while`, `begin`, `label`/`goto`, and
  recursive functions (arguments on the stack, result in `accumulator_64`).
- **Globals**: `global`, `define`, `set!`, `print`, `exit`.

Build and run the demo:

```bash
# build the compiler
cd compiler && go build -o ../build/rasl.exe . && cd ..

# compile a program into readable assembly
build/rasl.exe examples/lisp/hello.lisp -o build/hello.asm

# assemble + link + run (from the repo root so the %include resolves)
nasm -f win64 build/hello.asm -o build/hello.o -I .
gcc build/hello.o -o build/hello.exe     # Windows
build/hello.exe

nasm -f elf64 build/hello.asm -o build/hello.o -I .
ld build/hello.o -o build/hello          # Linux (syscall-based runtime)
```

The same generated `.asm` assembles for both `win64` and `elf64`; the runtime
picks its entry point and `print`/`exit` implementation with
`%ifidn __OUTPUT_FORMAT__, win64` (libc on Windows, raw syscalls on Linux).
Run `build/rasl.exe -h` for flags (`-o` output, `-v` verbose logging).

## Testing

Run the full test suite (requires NASM and, on Windows, MinGW gcc + SDL2):

```bash
bash tests/run_tests.sh
```

The suite verifies that:

1. Every macro file in `macros/` assembles standalone
2. `examples/example.asm` assembles for both `elf64` (Linux) and `win64` (Windows)
3. `examples/sdl_rectangle.asm` assembles for both formats
4. `examples/structs.asm` assembles for both formats and its runtime
   struct-offset checks pass
5. `tests/smoke_test.asm` compiles, links and **runs** — exercising arithmetic,
   logic, shifts, stack ops, procedures and recursion via the readable macros
   (exits 0 only if every runtime check passes)
6. The SDL2 demo launches, creates a window, and runs without crashing
7. The **rasl compiler** (Go) builds, its unit tests pass, and its end-to-end
   suite (`tests/run_lisp.sh`) compiles `hello.lisp`, assembles the result for
   both formats, and verifies the running program's output matches
   `examples/lisp/hello.expected`
8. The **rasmdis** decoder tests pass (`go test` in `tools/disasm`)

## Requirements

- **NASM** — Netwide Assembler (2.14+)
- **Linux**: `ld` or `gcc` for linking
- **Windows**: MinGW-w64 with SDL2 for the game demo
- **Go 1.21+** — to build the rasl compiler and readablify tool
- **Go 1.24+ and a C compiler** — to build the rasmdis window (CGO)

## License

MIT — see [LICENSE](LICENSE). Copyright (c) 2026 Xyzzy Apps
&lt;xyzzyapps@gmail.com&gt;.

## Credits

This project was developed with assistance from AI models:

- **Qwen 3.6**
- **DeepSeek**
