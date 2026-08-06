# readablify

A small Go tool that converts cryptic NASM source into **Readable Assembly** —
the English-style macro dialect of this repository.

```
mov rax, 42              →    move        accumulator, 42
push rbp                 →    push_onto_stack base_pointer
cmp rax, rbx             →    compare     accumulator, base
je .done                 →    jump_if_equal .done
add dword [cnt], 1       →    add_dword   [cnt], 1
msg db "Hi!", 0          →    msg: define_byte "Hi!", 0
buf resb 16              →    buf: reserve_byte 16
LIMIT equ 100            →    equate      LIMIT, 100
syscall                  →    syscall_invoke
```

## Build

```bash
cd tools/readablify
go build -o readablify .
```

## Usage

```bash
readablify input.asm                 # readable version to stdout
readablify -o out.asm input.asm      # write to a file
readablify -w input.asm              # convert in place
readablify -verify input.asm         # assemble BOTH versions and compare
                                     # machine code (must be identical)
readablify -f win64 input.asm        # choose the assembly format
```

Options go before the input file.

## What it rewrites

- **Registers** — `rax`→`accumulator`, `rbx`→`base`, `rcx`→`counter`,
  `rdx`→`data`, `rsi`→`source_index`, `rdi`→`destination_index`,
  `rbp`→`base_pointer`, `rsp`→`stack_pointer`, plus all widths
  (`eax`→`accumulator_32`, `al`→`accumulator_8`, `r8d`→`register_r8_32`, ...)
- **Instructions** — the full core set: data movement, arithmetic, logic,
  shifts/rotates, jumps, calls, conditional moves (`cmov*`→`move_if_*`),
  condition codes (`set*`→`set_if_*`), string ops, flag ops, conversions,
  system instructions, and a common FPU subset
- **Sized forms** — `mov dword [x], 1` becomes `move_dword [x], 1`;
  `movzx eax, byte [x]` becomes `move_with_zero_extend_byte accumulator_32, [x]`
- **Data directives** — `db`→`define_byte`, `dq`→`define_qword`,
  `resb`→`reserve_byte`, `equ`→`equate name, value`
- **`imul`** — picked by operand count
  (`signed_multiply` / `signed_multiply_immediate` / `signed_multiply_immediate_3`)

## What it leaves alone

Labels, comments, string literals, preprocessor lines (`%include`, `%macro`,
`%ifidn`, ...), directives (`section`, `global`, `extern`, `times`, `align`,
`default rel`, ...), and any instruction it does not know (SSE/AVX and other
exotic mnemonics pass through, though registers inside them are still
renamed).

## Verification

`-verify` assembles the original and the converted file with NASM and
compares the `.text` machine code — they must be byte-identical. This
guarantees the conversion changes readability, not behavior.

The conversion is intentionally faithful: `xor rax, rax` becomes
`logical_xor accumulator, accumulator` rather than `move accumulator, 0`
because the two instructions differ in how they affect the flags.
