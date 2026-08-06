# Readable Assembly — Tutorial

Welcome! This tutorial teaches you to write x86-64 assembly using **Readable
Assembly**, a set of NASM macros that replace cryptic instruction mnemonics
with descriptive English names.

```nasm
move accumulator, 10        ; instead of: mov rax, 10
add  accumulator, 5         ; instead of: add rax, 5
compare accumulator, 15     ; instead of: cmp rax, 15
jump_if_equal done          ; instead of: je done
```

Nothing is hidden — every macro expands to exactly one real instruction.
There is **zero runtime overhead**; the macros only exist while assembling.

---

## 1. What you need

| Tool | Why |
|---|---|
| **NASM 2.14+** | The assembler. The macros are plain NASM preprocessor macros. |
| **A linker** | Linux: `ld` (or `gcc`). Windows: MinGW-w64 `gcc`. |
| **SDL2** *(optional)* | Only needed for the game demo (`examples/sdl_rectangle.asm`). |

**Install NASM**

- **Linux (Debian/Ubuntu):** `sudo apt install nasm`
- **Linux (Fedora):** `sudo dnf install nasm`
- **Windows (MSYS2):** `pacman -S nasm mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-SDL2`

---

## 2. Your first program

### Linux

Save this as `hello.asm`:

```nasm
%include "readable_macros.nasm"

section .data
    message: define_byte "Hello, Readable Assembly!", 10, 0
    msg_len equ $ - message

section .text
    global _start

_start:
    ; write(1, message, msg_len)  -- Linux syscall 1
    move accumulator, 1                  ; sys_write
    move destination_index, 1            ; fd = stdout
    load_effective_address source_index, [message]
    move data, msg_len
    syscall_invoke

    ; exit(0)  -- Linux syscall 60
    move accumulator, 60
    move destination_index, 0
    syscall_invoke
```

Assemble and run:

```bash
nasm -f elf64 hello.asm -o hello.o
ld hello.o -o hello
./hello
```

You should see:

```
Hello, Readable Assembly!
```

### Windows

Save this as `hello.asm` (console programs are easiest with the C runtime):

```nasm
%include "readable_macros.nasm"
default rel                          ; needed on Windows x64

extern printf
extern exit

section .data
    message: define_byte "Hello, Readable Assembly!", 10, 0

section .text
    global main

main:
    ; Windows x64: 32 bytes shadow space + 8 bytes stack alignment
    sub stack_pointer, 40

    move counter, message        ; 1st argument: format string
    call_procedure printf

    move counter, 0              ; exit code
    call_procedure exit
```

Assemble and run (from an MSYS2 / MinGW shell):

```bash
nasm -f win64 hello.asm -o hello.o
gcc hello.o -o hello.exe
./hello.exe
```

---

## 3. The five core ideas

### 3.1 Operands follow Intel order: destination first

```nasm
move accumulator, base         ; rax = rbx   (copy rbx INTO rax)
add  accumulator, 5            ; rax = rax + 5
subtract counter, data         ; rcx = rcx - rdx
```

The destination is always the first operand, exactly like Intel syntax.

### 3.2 Registers read like English

`accumulator` is the traditional name of the A register — 64-bit `rax`. The
width is **explicit in the name**, so you never have to remember that `eax`
is 32-bit or that `al` is 8-bit:

| Readable | Real | Width |
|---|---|---|
| `accumulator` / `accumulator_64` | `rax` | 64-bit |
| `accumulator_32` | `eax` | 32-bit |
| `accumulator_16` | `ax` | 16-bit |
| `accumulator_8` | `al` | 8-bit |
| `accumulator_8_high` | `ah` | 8-bit (high byte) |

Every traditional register has a name, all with the same `_64` / `_32` / `_16`
/ `_8` forms:

| Traditional name | Real | | Traditional name | Real |
|---|---|---|---|---|
| `accumulator` | `rax` | | `source_index` | `rsi` |
| `base` | `rbx` | | `destination_index` | `rdi` |
| `counter` | `rcx` | | `base_pointer` | `rbp` |
| `data` | `rdx` | | `stack_pointer` | `rsp` |

The extended set keeps the explicit spelling: `register_r8` (64-bit),
`register_r8_32` (`r8d`), `register_r8_16` (`r8w`), `register_r8_8` (`r8b`),
up to `register_r15`.

The exact names (`rax`, `eax`, `ax`, `al`) always work too — the readable
names are aliases, not replacements.

### 3.3 Memory operands need a size

Assembly can't tell whether `[address]` holds a byte, word, dword, or qword.
Use the **sized forms** — every core macro has `_byte`, `_word`, `_dword`,
`_qword` variants:

```nasm
section .data
    score:  define_qword 0     ; 8 bytes
    health: define_byte 100    ; 1 byte

section .text
    add_dword [score], 10          ; add dword [score], 10
    compare_byte [health], 0       ; cmp byte [health], 0
    increment_word [score]         ; inc word [score]
    move_qword [score], 999        ; mov qword [score], 999
```

The `move` family already had these: `move_byte`, `move_word`, `move_dword`,
`move_qword`. The sized pattern covers `add/subtract`, `compare`,
`logical_and/or/xor/not`, `shift_logical_left/right`, `rotate_left/right`,
`multiply`, `divide`, `increment`, `decrement`, and `negate`.

### 3.4 Comparing and jumping

`compare a, b` sets the flags, then a conditional jump reads them:

```nasm
compare accumulator, 10
jump_if_equal   is_ten        ; je  (rax == 10)
jump_if_greater is_ten        ; jg  (rax >  10, signed)
jump_if_above   is_ten        ; ja  (rax >  10, unsigned)
jump_if_less_or_equal done    ; jle (rax <= 10, signed)
```

The vocabulary mirrors the real mnemonics:

| Readable | Real | Meaning |
|---|---|---|
| `jump_if_equal` / `jump_if_not_equal` | `je` / `jne` | `==` / `!=` |
| `jump_if_greater` / `jump_if_less` | `jg` / `jl` | signed `>` / `<` |
| `jump_if_above` / `jump_if_below` | `ja` / `jb` | unsigned `>` / `<` |
| `jump_if_zero` / `jump_if_not_zero` | `jz` / `jnz` | flag-based |

`jump target` is an unconditional `jmp`.

### 3.5 Procedures and the stack

```nasm
    call_procedure my_function      ; call my_function
    ; ... execution continues here after the return

my_function:
    push_onto_stack base_pointer      ; push rbp
    move base_pointer, stack_pointer  ; mov rbp, rsp  (frame pointer)
    ; ... body ...
    pop_from_stack base_pointer       ; pop rbp
    return_from_procedure           ; ret
```

`push_onto_stack` / `pop_from_stack` are the explicit forms; `push` / `pop`
also exist.

### 3.6 Defining data

The data directives get readable names too:

| Readable | Directive | Purpose |
|---|---|---|
| `define_byte` / `define_word` | `db` / `dw` | bytes / 16-bit values |
| `define_dword` / `define_qword` | `dd` / `dq` | 32-bit / 64-bit values |
| `reserve_byte` … `reserve_qword` | `resb` … `resq` | uninitialized storage |
| `equate name, value` | `name equ value` | named constant |

```nasm
section .data
    greeting: define_byte "Hello!", 10, 0
    score:    define_dword 100
    max_size: equate 256

section .bss
    buffer:   reserve_byte max_size
```

---

## 4. Example: a counting loop

```nasm
%include "readable_macros.nasm"

section .data
    result dq 0

section .text
    global _start

_start:
    move counter, 10        ; loop counter
    move accumulator, 0     ; running sum

sum_loop:
    add accumulator, counter
    loop sum_loop           ; dec rcx, loop while rcx != 0

    move [result], accumulator  ; store 55
    ; ... exit ...
```

`loop target` decrements `rcx` and jumps while `rcx != 0`. There are also
`loop_if_equal`, `loop_if_not_equal`, `loop_if_zero`, and `loop_if_not_zero`.

---

## 5. Example: a factorial procedure

```nasm
%include "readable_macros.nasm"

section .text
    global _start

_start:
    move accumulator, 5
    call_procedure factorial       ; rax = 5! = 120
    ; ... exit ...

; factorial: takes n in rax, returns n! in rax
factorial:
    move base, accumulator         ; n
    move accumulator, 1            ; result = 1
.next:
    compare base, 1
    jump_if_less_or_equal .done
    multiply base                  ; rax = rax * rbx
    decrement base
    jump .next
.done:
    return_from_procedure
```

`multiply x` is `mul x` — the implicit-accumulator form that multiplies
`rax` by `x`. `signed_multiply` maps to `imul`.

---

## 6. Example: the SDL2 game

The repo ships a complete game, `examples/sdl_rectangle.asm` — it opens an
800×600 window, draws a cyan rectangle on a dark background, and moves it with
the arrow keys.

**Linux** (from the repo root):

```bash
nasm -f elf64 examples/sdl_rectangle.asm -o sdl_rectangle.o
gcc sdl_rectangle.o -o sdl_rectangle -lSDL2 -no-pie
./sdl_rectangle
```

**Windows (MinGW)** (from the repo root):

```bash
nasm -f win64 examples/sdl_rectangle.asm -o sdl_rectangle.o
gcc sdl_rectangle.o -o sdl_rectangle.exe -lSDL2
sdl_rectangle.exe
```

Close it by pressing **Escape** or the window's close button.

Reading `examples/sdl_rectangle.asm` is a great way to see the macros in a real
program: it uses `call_procedure` for every SDL function, `compare` +
`jump_if_equal` for event handling, and `add_dword`/`subtract_dword` on
memory for moving the rectangle.

---

## 7. Exploring the library

### Include everything

```nasm
%include "readable_macros.nasm"
```

### Or include only what you need

Every category is a separate file in `macros/`:

```nasm
%include "macros/01-registers.nasm"
%include "macros/05-data-movement.nasm"
%include "macros/06-arithmetic.nasm"
%include "macros/10-jumps.nasm"
```

| Category | File | Examples |
|---|---|---|
| Registers | `01-registers.nasm` | `accumulator`, `base`, `counter`, `register_r8` |
| Data movement | `05-data-movement.nasm` | `move`, `move_dword`, `load_effective_address`, `move_if_equal` |
| Arithmetic | `06-arithmetic.nasm` | `add`, `add_dword`, `multiply`, `compare` |
| Logic | `07-logic.nasm` | `logical_and`, `logical_not` |
| Shift/rotate | `08-shift-rotate.nasm` | `shift_logical_left`, `rotate_right` |
| Bit manipulation | `09-bit-manipulation.nasm` | `bit_scan_forward`, `count_leading_zeros`, `byte_swap` |
| Jumps | `10-jumps.nasm` | `jump`, `jump_if_equal`, `jump_if_greater` |
| Loops | `11-loops.nasm` | `loop`, `loop_if_not_zero` |
| Procedures | `12-procedures.nasm` | `call_procedure`, `return_from_procedure` |
| Stack | `13-stack.nasm` | `push_onto_stack`, `pop_from_stack`, `push_flags_qword` |
| Flags | `14-flag-control.nasm` | `clear_carry_flag`, `set_interrupt_flag` |
| Condition codes | `15-setcc.nasm` | `set_if_equal`, `set_if_above` |
| Strings | `16-strings.nasm` | `move_string_byte`, `compare_string_dword` |
| System | `20-system.nasm` | `syscall_invoke`, `no_operation`, `halt` |
| FPU | `23-29-fpu-*.nasm` | `fpu_add`, `fpu_sine`, `fpu_square_root` |
| SSE/AVX | `31-42-*.nasm` | `sse_add_packed_single`, `avx_multiply_packed_double` |
| Crypto | `37-aes.nasm`, `43-sha.nasm` | `aes_encrypt_round`, `sha_next_round` |

### Find a macro

The macro files are plain text — grep is your friend:

```bash
grep -rn "macro compare" macros/
grep -rn "macro.*byte" macros/06-arithmetic.nasm
```

Every macro body shows the real instruction it expands to, so
`grep -A2 "macro add_dword" macros/06-arithmetic.nasm` teaches you the
underlying mnemonic too.

---

## 8. Common mistakes

1. **Hyphens, not underscores.** NASM identifiers cannot contain `-`. Write
   `move_byte`, never `move-byte`. (This library originally used hyphens;
   it was renamed precisely because NASM rejects them.)
2. **Operand order.** Destination first. `move accumulator, base`
   copies `rbx` into `rax`, not the other way around.
3. **Forgetting memory sizes.** `add [score], 10` fails to assemble — you
   must write `add_dword [score], 10`.
4. **Signed vs unsigned jumps.** Use `greater`/`less` for signed values and
   `above`/`below` for unsigned.
5. **Windows needs `default rel`.** Add `default rel` near the top of any
   Windows x64 program so data references are RIP-relative.
6. **Windows x64 calling convention.** Arguments go in `rcx, rdx, r8, r9`
   (then the stack), you must reserve 32 bytes of shadow space, and `rsp`
   must be 16-byte aligned at every `call`. The `examples/sdl_rectangle.asm`
   file shows the pattern.
7. **Register words are macro names.** `accumulator`, `base`, `counter`,
   `data`, `source_index`, `destination_index`, `base_pointer`, and
   `stack_pointer` are preprocessor aliases — avoid using them as labels
   or symbols in your own code.

---

## 9. Running the tests

```bash
bash tests/run_tests.sh
```

The suite checks that every macro file assembles, both `examples/example.asm`
and `examples/sdl_rectangle.asm` build for Linux and Windows, the runtime
smoke test (`tests/smoke_test.asm`) executes real code through the macros and
verifies the results, and the SDL demo launches without crashing.

---

## 10. Where to go next

- **`examples/example.asm`** — a tour of the most common macros with `; real
  instruction` comments on every line.
- **`examples/fibonacci.asm`** / **`examples/fibonacci_raw.asm`** — the same
  program written with and without readable macros, side by side.
- **`examples/sdl_rectangle.asm`** — a complete interactive program.
- **`tests/smoke_test.asm`** — readable macros in runtime-verified code
  (recursion, condition codes, sized memory operations).
- **`README.md`** — full macro categories and the cheat sheet.
- **`tools/readablify/`** — a Go tool that converts raw NASM source into
  readable macros and verifies the machine code is unchanged.

Happy assembling!
