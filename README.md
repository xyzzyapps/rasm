# Readable Assembly

English-underscore NASM macros that make x86-64 assembly code readable and self-documenting.

## Overview

Readable Assembly provides 1000+ macro definitions that replace cryptic x86-64 instruction mnemonics with descriptive English names. Write assembly that reads like documentation.

| Traditional | Readable Assembly |
|---|---|
| `mov rax, 10` | `move register_ax, 10` |
| `push rbp` | `push_onto_stack register_bp` |
| `cmp rax, rbx` | `compare register_ax, register_bx` |
| `je label` | `jump_if_equal label` |
| `call func` | `call_procedure func` |

## Features

- **Complete x86-64 coverage** — Core instructions, FPU, MMX, SSE, AVX, AVX-512, AES, SHA, BMI, and more
- **Modular includes** — Include the full macro set or pick individual categories
- **Zero runtime overhead** — Pure NASM preprocessor macros, no performance impact
- **Self-documenting code** — Instructions read like English descriptions

## Quick Start

```nasm
%include "readable_macros.nasm"

section .text
    global _start

_start:
    move    register_ax, 42
    add     register_ax, 8
    compare register_ax, 50
    jump_if_equal   is_fifty
    jump            done

is_fifty:
    ; rax == 50
    jump done

done:
    move    register_ax, 60
    move    register_di, 0
    syscall_invoke
```

Assemble with NASM:

```bash
nasm -f elf64 example.asm -o example.o
ld example.o -o example
```

## Project Structure

```
readable_assembly/
├── readable_macros.nasm      # Main entry point (includes all macros)
├── macros/
│   ├── 01-registers.nasm     # Register definitions (register_ax, register_bx, etc.)
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
├── example.asm               # Basic usage examples
└── sdl_rectangle.asm         # SDL2 game demo
```

## Macro Categories

| Category | File | Examples |
|---|---|---|
| Registers | `01-registers.nasm` | `register_ax`, `register_bx`, `register_cx` |
| Data Movement | `05-data-movement.nasm` | `move`, `load-effective-address` |
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

The project includes a complete SDL2 game (`sdl_rectangle.asm`) that draws a colored rectangle and moves it with arrow keys.

**Linux:**
```bash
nasm -f elf64 sdl_rectangle.asm -o sdl_rectangle.o
gcc sdl_rectangle.o -o sdl_rectangle -lSDL2 -no-pie
./sdl_rectangle
```

**Windows (MinGW):**
```bash
nasm -f win64 sdl_rectangle.asm -o sdl_rectangle.o
gcc sdl_rectangle.o -o sdl_rectangle.exe -lSDL2
sdl_rectangle.exe
```

## Testing

Run the full test suite (requires NASM and, on Windows, MinGW gcc + SDL2):

```bash
bash tests/run_tests.sh
```

The suite verifies that:

1. Every macro file in `macros/` assembles standalone
2. `example.asm` assembles for both `elf64` (Linux) and `win64` (Windows)
3. `sdl_rectangle.asm` assembles for both formats
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
