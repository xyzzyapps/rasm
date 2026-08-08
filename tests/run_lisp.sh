#!/usr/bin/env bash
# ============================================================================
# rasl end-to-end test
#
# Builds the rasl compiler (Go), compiles examples/lisp/hello.lisp into
# readable assembly, assembles it for both win64 and elf64, and on Windows
# links and runs it, comparing the output against hello.expected.
#
# Usage:  bash tests/run_lisp.sh
# ============================================================================

set -u
PASS=0
FAIL=0

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD="$ROOT/build"
mkdir -p "$BUILD"

check() {  # check <description> <command...>
    local desc="$1"; shift
    if "$@" >"$BUILD/lisp_test.log" 2>&1; then
        echo "  PASS  $desc"
        PASS=$((PASS+1))
    else
        echo "  FAIL  $desc"
        head -5 "$BUILD/lisp_test.log" | sed 's/^/        /'
        FAIL=$((FAIL+1))
    fi
}

# ---------------------------------------------------------------------------
# Tool discovery
# ---------------------------------------------------------------------------
GO=""
for cand in go /usr/bin/go /c/tools/go/bin/go; do
    if command -v "$cand" >/dev/null 2>&1; then GO="$(command -v "$cand")"; break; fi
done
if [ -z "$GO" ]; then
    echo "SKIP  rasl tests: go not found"
    exit 0
fi

NASM=""
for cand in nasm /c/msys64/usr/bin/nasm.exe /usr/bin/nasm; do
    if command -v "$cand" >/dev/null 2>&1; then NASM="$(command -v "$cand")"; break; fi
done
[ -n "$NASM" ] || { echo "ERROR: nasm not found"; exit 1; }

GCC=""
for cand in gcc /c/msys64/mingw64/bin/gcc.exe /usr/bin/gcc; do
    if command -v "$cand" >/dev/null 2>&1; then GCC="$(command -v "$cand")"; break; fi
done
[ -n "$GCC" ] || { echo "ERROR: gcc not found"; exit 1; }

case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*) WIN64=1 ;;
    *) WIN64=0 ;;
esac

echo "--- rasl compiler ---"
check "go build rasl" bash -c "cd \"$ROOT/compiler\" && \"$GO\" build -o \"$BUILD/rasl.exe\" ."

check "go test rasl" bash -c "cd \"$ROOT/compiler\" && \"$GO\" test ./..."

check "rasl compiles hello.lisp" bash -c "\"$BUILD/rasl.exe\" -o \"$BUILD/hello.asm\" \"$ROOT/examples/lisp/hello.lisp\""

echo "--- generated assembly ---"
check "hello.asm (elf64)" bash -c "\"$NASM\" -f elf64 \"$BUILD/hello.asm\" -o \"$BUILD/hello_elf.o\" -I \"$ROOT\""
check "hello.asm (win64)" bash -c "\"$NASM\" -f win64 \"$BUILD/hello.asm\" -o \"$BUILD/hello_win.o\" -I \"$ROOT\""

if [ "$WIN64" -eq 1 ]; then
    echo "--- runtime ---"
    if "$GCC" "$BUILD/hello_win.o" -o "$BUILD/hello.exe" >"$BUILD/lisp_test.log" 2>&1; then
        "$BUILD/hello.exe" >"$BUILD/hello.out"
        # puts (msvcrt) emits CRLF in text mode; strip CR before comparing
        tr -d '\r' <"$BUILD/hello.out" >"$BUILD/hello.out.nocr"
        if diff -q "$BUILD/hello.out.nocr" "$ROOT/examples/lisp/hello.expected" >/dev/null 2>&1; then
            echo "  PASS  hello.exe output matches hello.expected"
            PASS=$((PASS+1))
        else
            echo "  FAIL  hello.exe output differs from hello.expected"
            diff "$BUILD/hello.out.nocr" "$ROOT/examples/lisp/hello.expected" | head -10 | sed 's/^/        /'
            FAIL=$((FAIL+1))
        fi
    else
        echo "  FAIL  hello.exe link"
        head -5 "$BUILD/lisp_test.log" | sed 's/^/        /'
        FAIL=$((FAIL+1))
    fi
else
    echo "  SKIP  runtime check (non-Windows)"
fi

echo "----------------------------------------------"
echo " RESULTS: $PASS passed, $FAIL failed"
echo "----------------------------------------------"
[ "$FAIL" -eq 0 ]
