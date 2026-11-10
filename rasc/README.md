# rasc

A very small compiler. It reads a strict C dialect and writes Readable Assembly.
It does not optimise. It does not use the C standard library.

Types are exact. `int32` does not become `int64` unless the source writes `int64(x)`.
The integer types are `int8`, `int16`, `int32`, `int64`, `uint8`, `uint16`, `uint32`, and `uint64`.
`bool` is `true` or `false`. A pointer is written `int64*`.

`main` is `int64 main()` with no parameters. Its result is the process status.

An `asm` block is copied into the output as rasm. `%{name}` becomes the stack
or global address of that name.

```c
int64 add(int64 a, int64 b) {
    return a + b;
}

int64 main() {
    int64 n = int64(0);
    asm {
        move accumulator_64, 7
        move %{n}, accumulator_64
    };
    return add(n, int64(35));
}
```

```bash
cd rasc
go build -o ../build/rasc.exe .
../build/rasc.exe -o ../build/demo.asm examples/sum.c
nasm -f win64 ../build/demo.asm -o ../build/demo.o -I ..
gcc ../build/demo.o -o ../build/demo.exe
```
