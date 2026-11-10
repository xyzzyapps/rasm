package main

import (
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"testing"
)

func TestRejectsImplicitConversion(t *testing.T) {
	src := `
int64 main() {
    int32 x = int32(1);
    int64 y = x;
    return y;
}
`
	_, err := Compile(src)
	if err == nil || !strings.Contains(err.Error(), "int64") {
		t.Fatalf("got %v", err)
	}
}

func TestSumAndAsm(t *testing.T) {
	src := `
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
`
	out, err := Compile(src)
	if err != nil {
		t.Fatal(err)
	}
	if !strings.Contains(out, "add accumulator_64, base_64") {
		t.Fatalf("missing add:\n%s", out)
	}
	if !strings.Contains(out, "move [base_pointer_64 - 8], accumulator_64") {
		t.Fatalf("asm name was not replaced:\n%s", out)
	}
	if !strings.Contains(out, "rasc_main:") {
		t.Fatal("missing entry function")
	}
}

func TestRunProgram(t *testing.T) {
	nasm := `C:\msys64\usr\bin\nasm.exe`
	if _, err := os.Stat(nasm); err != nil {
		t.Skip("nasm not installed")
	}
	src := `
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
`
	asm, err := Compile(src)
	if err != nil {
		t.Fatal(err)
	}
	dir := t.TempDir()
	asmPath := filepath.Join(dir, "t.asm")
	objPath := filepath.Join(dir, "t.o")
	exePath := filepath.Join(dir, "t.exe")
	if err := os.WriteFile(asmPath, []byte(asm), 0o644); err != nil {
		t.Fatal(err)
	}
	root := filepath.Join("..")
	cmd := exec.Command(nasm, "-f", "win64", asmPath, "-o", objPath, "-I", root)
	cmd.Dir = root
	if out, err := cmd.CombinedOutput(); err != nil {
		t.Fatalf("nasm: %v\n%s\n%s", err, out, asm)
	}
	if out, err := exec.Command("gcc", objPath, "-o", exePath).CombinedOutput(); err != nil {
		t.Fatalf("gcc: %v\n%s", err, out)
	}
	cmd = exec.Command(exePath)
	err = cmd.Run()
	if cmd.ProcessState == nil || cmd.ProcessState.ExitCode() != 42 {
		code := -1
		if cmd.ProcessState != nil {
			code = cmd.ProcessState.ExitCode()
		}
		t.Fatalf("exit %d err %v", code, err)
	}
}
