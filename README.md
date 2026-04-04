# Readable Assembly

English-hyphenated NASM macros that make x86-64 assembly code readable and self-documenting.

## Overview

Readable Assembly provides 1000+ macro definitions that replace cryptic x86-64 instruction mnemonics with descriptive English names. Write assembly that reads like documentation.

| Traditional | Readable Assembly |
|---|---|
| `mov rax, 10` | `move register-ax, 10` |
| `push rbp` | `push-onto-stack register-bp` |
| `cmp rax, rbx` | `compare register-ax, register-bx` |
| `je label` | `jump-if-equal label` |
| `call func` | `call-procedure func` |

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
    move    register-ax, 42
    add     register-ax, 8
    compare register-ax, 50
    jump-if-equal   is_fifty
    jump            done

is_fifty:
    ; rax == 50
    jump done

done:
    move    register-ax, 60
    move    register-di, 0
    syscall-invoke
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
│   ├── 01-registers.nasm     # Register definitions (register-ax, register-bx, etc.)
│   ├── 02-flags.nasm         # Flag definitions
│   ├── 03-sizes.nasm         # Size definitions
│   ├── 04-segments.nasm      # Segment definitions
│   ├── 05-data-movement.nasm # move, load, store, etc.
│   ├── 06-arithmetic.nasm    # add, subtract, multiply, etc.
│   ├── 07-logic.nasm         # logical-and, logical-or, etc.
│   ├── 08-shift-rotate.nasm  # shift/rotate instructions
│   ├── 09-bit-manipulation.nasm
│   ├── 10-jumps.nasm         # jump-if-equal, jump-if-greater, etc.
│   ├── 11-loops.nasm
│   ├── 12-procedures.nasm    # call-procedure, return-from-procedure
│   ├── 13-stack.nasm         # push-onto-stack, pop-from-stack
│   ├── ...
│   └── 60-cet-shadow-stack.nasm
├── example.asm               # Basic usage examples
└── sdl_rectangle.asm         # SDL2 game demo
```

## Macro Categories

| Category | File | Examples |
|---|---|---|
| Registers | `01-registers.nasm` | `register-ax`, `register-bx`, `register-cx` |
| Data Movement | `05-data-movement.nasm` | `move`, `load-effective-address` |
| Arithmetic | `06-arithmetic.nasm` | `add`, `subtract`, `increment`, `multiply` |
| Logic | `07-logic.nasm` | `logical-and`, `logical-or`, `logical-xor` |
| Shift/Rotate | `08-shift-rotate.nasm` | `shift-logical-left`, `rotate-right` |
| Jumps | `10-jumps.nasm` | `jump-if-equal`, `jump-if-greater` |
| Procedures | `12-procedures.nasm` | `call-procedure`, `return-from-procedure` |
| Stack | `13-stack.nasm` | `push-onto-stack`, `pop-from-stack` |
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

## Requirements

- **NASM** — Netwide Assembler (2.14+)
- **Linux**: `ld` or `gcc` for linking
- **Windows**: MinGW-w64 with SDL2 for the game demo

## License

MIT
