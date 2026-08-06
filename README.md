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
│   └── sdl_rectangle.asm     # SDL2 game demo
├── tests/
│   ├── run_tests.sh          # Test suite
│   └── smoke_test.asm        # Runtime-verified macro smoke test
└── tools/
    └── readablify/           # Go tool: raw NASM -> readable macros
        ├── main.go
        └── README.md
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

## Testing

Run the full test suite (requires NASM and, on Windows, MinGW gcc + SDL2):

```bash
bash tests/run_tests.sh
```

The suite verifies that:

1. Every macro file in `macros/` assembles standalone
2. `examples/example.asm` assembles for both `elf64` (Linux) and `win64` (Windows)
3. `examples/sdl_rectangle.asm` assembles for both formats
4. `tests/smoke_test.asm` compiles, links and **runs** — exercising arithmetic,
   logic, shifts, stack ops, procedures and recursion via the readable macros
   (exits 0 only if every runtime check passes)
5. The SDL2 demo launches, creates a window, and runs without crashing

## Requirements

- **NASM** — Netwide Assembler (2.14+)
- **Linux**: `ld` or `gcc` for linking
- **Windows**: MinGW-w64 with SDL2 for the game demo

## License

MIT

## Credits

This project was developed with assistance from AI models:

- **Qwen 3.6**
- **DeepSeek**
