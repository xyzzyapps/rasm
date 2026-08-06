# Readable Assembly (rasm) — Software Requirements Specification

This document is the SRS for the **Readable Assembly** project (also known as
**rasm**): a set of NASM preprocessor macros that give every x86-64
instruction mnemonic an English-descriptive alias, plus a companion
conversion tool (`readablify`) and a test suite.

## 1. Purpose and Scope

### 1.1 Problem

Raw x86-64 assembly uses cryptic mnemonics (`mov`, `push`, `cmp`, `je`) and
register names (`rax`, `rbx`, `rcx`) that make programs hard to read and
self-documenting impossible.

### 1.2 Solution

A macro library that maps every instruction mnemonic and register to a
readable English name while producing **byte-identical machine code**. The
macros are pure NASM preprocessor constructs: they exist only at assemble
time and have zero runtime overhead.

```
mov rax, 10      ->  move accumulator, 10
push rbp         ->  push_onto_stack base_pointer
cmp rax, rbx     ->  compare accumulator, base
je  label        ->  jump_if_equal label
call func        ->  call_procedure func
```

## 2. Naming Convention (normative)

| Rule | Detail |
|---|---|
| Case | All names are lowercase. |
| Separator | Words are joined with underscores (`_`), never hyphens — NASM rejects `-` in identifiers. |
| Operand order | Intel order: destination first, then source. `move accumulator, 10` = `mov rax, 10`. |
| Registers | Traditional names: `accumulator` (rax), `base` (rbx), `counter` (rcx), `data` (rdx), `source_index` (rsi), `destination_index` (rdi), `base_pointer` (rbp), `stack_pointer` (rsp). |
| Width | Explicit in the name: `accumulator_64` (rax), `accumulator_32` (eax), `accumulator_16` (ax), `accumulator_8` (al), `accumulator_8_high` (ah). |
| Extended regs | Explicit spelling `register_r8` .. `register_r15` with `register_r8_32` (r8d), `register_r8_16` (r8w), `register_r8_8` (r8b). |
| Raw names | Exact NASM names (`rax`, `eax`, `ax`, `al`) always work — readable names are aliases, not replacements. |
| Comparisons | Unsigned: `above` / `below` (ja/jb). Signed: `greater` / `less` (jg/jl). |
| Sized memory ops | `_byte` / `_word` / `_dword` / `_qword` variants insert the operand-size qualifier: `add_dword [score], 10` -> `add dword [score], 10`. |
| Data directives | `define_byte` (db), `define_word` (dw), `define_dword` (dd), `define_qword` (dq), `reserve_byte` (resb) .. `reserve_qword` (resq), `equate name, value` (equ). |

## 3. Architecture

```
+---------------------------------------------------------------+
|                        readable_macros.nasm                    |
|   entry point: %includes every file in macros/ in order        |
+-------------------------------+-------------------------------+
                                |
        +-----------------------+-----------------------+
        |                       |                       |
        v                       v                       v
+------------------+   +------------------+   +------------------+
| macros/          |   | examples/        |   | tests/           |
| 01-registers     |   | example.asm      |   | run_tests.sh     |
| 02-flags         |   | fibonacci.asm    |   | smoke_test.asm   |
| ...              |   | fibonacci_raw.asm|   |                  |
| 60-cet-shadow    |   | sdl_rectangle.asm|   |                  |
+------------------+   +------------------+   +------------------+
        ^                        ^                        ^
        |                        |                        |
        +---------+   +----------+------------------------+
                  |   |
                  v   v
        +------------------+         +------------------+
        | NASM (2.14+)     |         | readablify (Go)  |
        | preprocesses     |         | raw NASM ->      |
        | macros -> opcode |         | readable macros  |
        +------------------+         | -verify: machine |
                                     | code byte-identical |
                                     +------------------+
```

### 3.1 Layers

1. **Macro library** (`macros/*.nasm`) — the core deliverable. Split into
   60 numbered category files (registers, flags, data movement, arithmetic,
   logic, shifts, jumps, loops, procedures, stack, FPU, MMX, SSE/AVX,
   crypto, system, etc.).
2. **Entry point** (`readable_macros.nasm`) — includes every category file
   in dependency order so a single `%include "readable_macros.nasm"` loads
   the full library.
3. **Examples** (`examples/*.asm`) — demonstrator programs:
   - `example.asm` — tour of the most common macros.
   - `fibonacci.asm` / `fibonacci_raw.asm` — same program, readable vs raw.
   - `sdl_rectangle.asm` — interactive SDL2 game using the C calling
     convention abstraction.
4. **Tooling** (`tools/readablify/`) — a Go CLI that converts raw NASM
   source to readable assembly and optionally verifies byte-identical
   machine code.
5. **Tests** (`tests/`) — a bash test suite plus a runtime smoke test.

### 3.2 Macro expansion model

Macros are defined with `%macro name N` and expand to exactly one real
instruction. Sized forms wrap the operand-size keyword into the expansion,
e.g. `%macro add_dword 2` expands to `add dword %1, %2`. Registers are
single-token `%define` aliases.

Include resolution note: NASM resolves `%include` relative to the current
working directory, not the source file. All examples therefore document
build commands that run from the repository root (or pass `-I <root>`),
which is also what the test suite does.

### 3.3 Dual-format support

Examples and the smoke test assemble for both `elf64` (Linux, System V ABI)
and `win64` (Windows, Microsoft x64 ABI). The SDL demo abstracts the calling
convention with preprocessor symbols:

```nasm
%ifidn __OUTPUT_FORMAT__, win64
    %define ARG1 rcx     ; 1st integer arg
    %define SHADOW 32    ; shadow space
%else
    %define ARG1 rdi
    %define SHADOW 0
%endif
```

## 4. Modules

### 4.1 `macros/01-registers.nasm`

Defines all readable register aliases:
- Traditional registers with width variants (see section 2).
- Extended registers `register_r8` .. `register_r15` (all widths).
- Legacy `register_*` spellings kept for backwards compatibility.
- Segment, control, debug, XMM/YMM/ZMM, MMX and AVX-512 mask registers.

### 4.2 Core macro categories

| Files | Coverage |
|---|---|
| `02-flags.nasm`, `03-sizes.nasm`, `04-segments.nasm` | Flag/size/segment constants. |
| `05-data-movement.nasm` | `move`, `move_byte..qword`, `load_effective_address`, `exchange`, `compare_and_exchange`, `move_if_*` (cmov), `move_with_*_extend_*`, data directives (`define_*`, `reserve_*`, `equate`). |
| `06-arithmetic.nasm` | `add`, `subtract`, `increment`, `decrement`, `negate`, `multiply`, `signed_multiply`, `divide`, `compare` + sized forms. |
| `07-logic.nasm` | `logical_and`, `logical_or`, `logical_xor`, `logical_not` + sized forms. |
| `08-shift-rotate.nasm` | `shift_logical_left/right`, `shift_arithmetic_right`, `rotate_left/right` + sized forms. |
| `09-bit-manipulation.nasm` | `bit_scan_forward`, `bit_scan_reverse`, `count_leading_zeros`, `byte_swap`, BMI. |
| `10-jumps.nasm` | `jump`, `jump_if_*` (jcc): equal/not_equal, above/below, greater/less, zero, sign, carry, parity, overflow. |
| `11-loops.nasm` | `loop`, `loop_if_*`. |
| `12-procedures.nasm` | `call_procedure`, `return_from_procedure`, `enter`, `leave`. |
| `13-stack.nasm` | `push_onto_stack`, `pop_from_stack`, `push_flags_*`, `pop_flags_*`. |
| `14-flag-control.nasm`, `22-flag-transfer.nasm` | `clear_*_flag`, `set_*_flag`, flag loads/stores. |
| `15-setcc.nasm` | `set_if_*` (setcc). |
| `16-strings.nasm`, `17-repeat-prefixes.nasm` | `move_string_*`, `compare_string_*`, `scan_string_*`, `repeat`. |
| `18-io.nasm`, `19-interrupts.nasm`, `20-system.nasm` | in/out, int/iret, `syscall_invoke`, `no_operation`, `halt`, `pause`. |
| `21-cache-memory.nasm` | cache control and memory ordering. |
| `23`-`29` (FPU) | x87 data transfer, constants, arithmetic, transcendental, comparison, control, conditional move. |
| `30` (MMX) | MMX instructions. |
| `31`-`36` (SSE..SSE4.2), `39`-`42` (AVX..AVX-512) | SIMD families. |
| `37-aes.nasm`, `38-pclmulqdq.nasm`, `43-sha.nasm`, `44-gfni.nasm` | Crypto extensions. |
| `45`-`60` | MPX, BMI, ADX, bound, newer extensions, SGX, XSAVE, TSX, user interrupts, PTWRITE, VMX, CET shadow stack. |

### 4.3 `tools/readablify/` (Go)

- **Input**: raw NASM assembly text.
- **Transforms**: registers (`rax` -> `accumulator`, widths included),
  instructions (core set incl. cmov/setcc, string ops, flag ops, system),
  sized forms (`mov dword [x], 1` -> `move_dword [x], 1`), data directives
  (`db` -> `define_byte`, `resb` -> `reserve_byte`, `equ` -> `equate`),
  `imul` by operand count.
- **Preserves**: labels, comments, string literals, preprocessor lines,
  directives, and unknown instructions (registers inside them still renamed).
- **`-verify` mode**: assembles the original and converted files with NASM
  and compares `.text` machine code; fails unless byte-identical.
- **CLI**: `readablify [flags] input.asm`; flags `-o out.asm`, `-w`
  (in place), `-verify`, `-f <format>`.
- Build: `cd tools/readablify && go build -o readablify .`

## 5. Data model

No runtime data structures — the library is purely preprocessor. The only
"data" is the textual mapping tables:

- **Register map**: canonical NASM register name -> readable alias
  (in `01-registers.nasm` and the `regMap` table in `main.go`).
- **Instruction map**: mnemonic -> readable name, plus operand-count rules
  for ambiguous instructions (e.g. `imul`).
- **Size table**: suffix -> operand-size keyword (`byte`, `word`, `dword`,
  `qword`).

## 6. External interfaces

| Interface | Producer | Consumer |
|---|---|---|
| `%include "readable_macros.nasm"` | user code | NASM preprocessor |
| `%include "macros/<NN>-<name>.nasm"` | user code | NASM preprocessor (partial includes) |
| `readablify input.asm` | tool | stdout / `-o` file / `-w` in place |
| `bash tests/run_tests.sh` | test suite | shell + NASM + gcc |

### 6.1 SDL2 integration (examples/sdl_rectangle.asm)

Uses the C ABI directly via `extern` declarations and the `ARG1..ARG4` /
`SHADOW` abstraction. Calls `SDL_Init`, `SDL_CreateWindow`,
`SDL_CreateRenderer`, `SDL_SetRenderDrawColor`, `SDL_RenderClear`,
`SDL_RenderFillRect`, `SDL_RenderPresent`, `SDL_PollEvent`, `SDL_Delay`,
`SDL_GetKeyboardState`, `SDL_DestroyRenderer`, `SDL_DestroyWindow`,
`SDL_Quit`, `printf` and `exit`.

- Linux link: `gcc sdl_rectangle.o -o sdl_rectangle -lSDL2 -no-pie`
- Windows link: `gcc sdl_rectangle.o -o sdl_rectangle.exe -lmingw32 -lSDL2main -lSDL2`

## 7. Testing

### 7.1 `tests/run_tests.sh`

Runs on Windows (MinGW/MSYS2) and Linux. Discovery order for tools:
`nasm` -> `/c/msys64/usr/bin/nasm.exe` -> `/usr/bin/nasm`; gcc likewise
checks `/c/msys64/mingw64/bin/gcc.exe` and `/c/msys64/ucrt64/bin/gcc.exe`.

Checks:

1. Every `macros/*.nasm` file assembles standalone (`-f win64`).
2. `examples/example.asm` assembles for `elf64` and `win64`.
3. `examples/sdl_rectangle.asm` assembles for `elf64` and `win64`.
4. `tests/smoke_test.asm` compiles, links and **runs**; it exercises
   factorial recursion, arithmetic, logic, shifts/rotates, stack ops,
   condition codes and sized memory operations via the readable macros and
   exits 0 only if every runtime assertion passes.
5. The SDL demo links against SDL2 and is launched; passes if it stays alive
   (window created) or exits cleanly with code 0. SDL2.dll is copied next to
   the executable on Windows when found under MSYS2.

Exit status is nonzero when any check fails. Summary prints
`RESULTS: <pass> passed, <fail> failed`.

### 7.2 `tests/smoke_test.asm`

Runtime-verified program; platform-conditional entry point
(`main` for win64, `_start` for elf64). Exits with code 1 on the first failed
assertion, 0 when all pass.

### 7.3 readablify `-verify`

Assembles original and converted source, compares `.text` bytes. Guarantees
the conversion changes readability, not behavior. Known nuance: `xor rax, rax`
converts to `logical_xor accumulator, accumulator` (not `move accumulator, 0`)
because flags behavior differs.

## 8. Build and run

### 8.1 Requirements

- NASM 2.14+ (tested with 2.16).
- A linker: Linux `ld` or `gcc`; Windows MinGW-w64 `gcc`.
- Go 1.21+ for `readablify`.
- SDL2 (optional) for the game demo.
- bash (Git Bash or MSYS2) for the test suite.

### 8.2 Commands

```bash
# assemble an example (from the repo root)
nasm -f elf64 examples/example.asm -o example.o
ld example.o -o example

# SDL2 demo, Linux
nasm -f elf64 examples/sdl_rectangle.asm -o sdl_rectangle.o
gcc sdl_rectangle.o -o sdl_rectangle -lSDL2 -no-pie

# SDL2 demo, Windows (MinGW)
nasm -f win64 examples/sdl_rectangle.asm -o sdl_rectangle.o
gcc sdl_rectangle.o -o sdl_rectangle.exe -lSDL2

# run the test suite
bash tests/run_tests.sh

# build and use readablify
cd tools/readablify && go build -o readablify .
./readablify -verify examples/fibonacci_raw.asm
```

## 9. Repository layout

```
readable_assembly/
├── readable_macros.nasm      # entry point: includes all macro files
├── macros/                   # 60 numbered category files
├── examples/
│   ├── example.asm           # macro tour
│   ├── fibonacci.asm         # readable Fibonacci
│   ├── fibonacci_raw.asm     # raw Fibonacci (comparison)
│   └── sdl_rectangle.asm     # SDL2 game
├── tests/
│   ├── run_tests.sh          # bash test suite
│   └── smoke_test.asm        # runtime smoke test
├── tools/readablify/         # Go conversion tool
├── README.md                 # overview + quick start
├── TUTORIAL.md               # hands-on guide
└── SPEC.md                   # this document
```

`build/` is generated output (gitignored). `*.o`, `*.exe`, `*.obj` are
gitignored anywhere.

## 10. Known constraints and future work

- NASM include resolution is CWD-relative; examples and tests assume the
  repo root is the working directory (or `-I <root>` is passed).
- `readablify` covers the core instruction set plus a common FPU subset;
  SSE/AVX and exotic mnemonics pass through (registers still renamed).
- The library documents both the primary readable names and the legacy
  `register_*` aliases; the legacy set is maintained for backwards
  compatibility and may be removed in a future major release.
