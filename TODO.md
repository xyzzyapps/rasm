# TODO

## rasl — a minimal Lisp that compiles to Readable Assembly (rasm)

A Go tool that translates a minimal Lisp (no lists, no closures, no GC) into
readable assembly built on the `readable_macros.nasm` vocabulary. The language
is intentionally a thin wrapper over rasm: structs map to `begin_struct`,
arrays to `reserve_qword` blocks, and inline assembly is a first-class block
form written in rasm itself.

### Task list

- [x] Create TODO.md with project plan
- [x] Set up compiler/ Go module (go.mod)
- [x] Implement s-expr reader (reader.go) + tests
- [x] Implement codegen (codegen.go: symbols, emitter, compile) + tests
- [x] Write runtime.rasm (entry wrapper, print via puts/syscall, %ifidn win64/elf64)
- [x] Implement CLI (main.go: -o, -v)
- [x] gofmt + go vet + go build
- [x] Write sample program examples/lisp/hello.lisp exercising all features
- [x] End-to-end: compile -> nasm win64 -> gcc link -> run -> verify output
- [x] Add compiler section to tests/run_tests.sh
- [x] Update README.md, SPEC.md, TUTORIAL.md
- [x] Commit

### Language summary (v1)

- Values: raw 64-bit integers. #t = 1, #f = 0. No tags, no heap, no GC.
- Forms: define, global, define-array, define-struct, set!, if, cond, while,
  begin, label, goto, asm, print, exit, + - * / < > = zero?, array-get/set,
  struct-get/set, function calls.
- Functions: global labels, args on stack, result in accumulator_64.
- Inline asm: `(asm (move accumulator_64 60) (syscall_invoke))` — verbatim rasm.
- Entry: `(define (main) ...)`; the compiler emits a `main`/`_start` wrapper
  that runs global initializers then calls the user entry.
- Structs: C-style aligned layout (declaration order, explicit padding),
  sized field access (byte/word zero-extended, sized stores).

### Notes

- Verified macro names against the repo: call_procedure, return_from_procedure,
  push_onto_stack, pop_from_stack, set_if_*, divide, signed_multiply, negate,
  move_byte, reserve_qword, define_qword, syscall_invoke, jump_if_equal,
  logical_and, load_effective_address.
- Generated output assembles with `nasm -f win64` (gcc link) AND
  `nasm -f elf64` (ld link) from the repo root; the runtime selects entry and
  print/exit via `%ifidn __OUTPUT_FORMAT__, win64`.
- Known gotchas solved during development: symbol+index addressing needs a
  32-bit absolute relocation that win64 rejects (use lea into a register);
  register-alias names (`counter`) must be rejected as identifiers;
  win64 libc calls need 16-byte-aligned rsp + 32-byte shadow space; the
  cleanest win64 termination is `ret` from `main` (like smoke_test.asm).

### Ideas for later

- Local variables with real stack frames.
- define-macro.
- Per-function tail calls.
- FFI to external C functions.
