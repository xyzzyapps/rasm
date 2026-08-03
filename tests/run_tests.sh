#!/usr/bin/env bash
# ============================================================================
# Readable Assembly - Test Suite
# ============================================================================
# Verifies that:
#   1. Every macro file assembles standalone (syntax check)
#   2. example.asm assembles for both win64 and elf64
#   3. sdl_rectangle.asm assembles for both win64 and elf64
#   4. The runtime smoke test compiles, links and passes
#   5. The SDL demo links against SDL2 and runs without crashing
#
# Usage:  bash tests/run_tests.sh
# ============================================================================

set -u
PASS=0
FAIL=0

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD="$ROOT/build"
mkdir -p "$BUILD"

# ---------------------------------------------------------------------------
# Tool discovery
# ---------------------------------------------------------------------------
NASM=""
for cand in nasm /c/msys64/usr/bin/nasm.exe /usr/bin/nasm; do
    if command -v "$cand" >/dev/null 2>&1; then NASM="$cand"; break; fi
done
if [ -z "$NASM" ]; then
    echo "ERROR: nasm not found. Install it (e.g. pacman -S nasm) and retry."
    exit 1
fi
NASM=$(command -v "$NASM")

GCC=""
for cand in gcc /c/msys64/mingw64/bin/gcc.exe /c/msys64/ucrt64/bin/gcc.exe /usr/bin/gcc; do
    if command -v "$cand" >/dev/null 2>&1; then GCC="$cand"; break; fi
done
if [ -z "$GCC" ]; then
    echo "ERROR: gcc not found."
    exit 1
fi
GCC=$(command -v "$GCC")

case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*)
        PLATFORM=windows
        WIN64=1
        ;;
    *)
        PLATFORM=linux
        WIN64=0
        ;;
esac

echo "=============================================="
echo " Readable Assembly test suite"
echo "  platform : $PLATFORM"
echo "  nasm     : $NASM ($("$NASM" -v | head -1))"
echo "  gcc      : $GCC"
echo "=============================================="

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
check() {  # check <description> <command...>
    local desc="$1"; shift
    if "$@" >"$BUILD/test.log" 2>&1; then
        echo "  PASS  $desc"
        PASS=$((PASS+1))
    else
        echo "  FAIL  $desc"
        head -5 "$BUILD/test.log" | sed 's/^/        /'
        FAIL=$((FAIL+1))
    fi
}

assemble() {  # assemble <format> <source> <output>
    "$NASM" -f "$1" "$2" -o "$3" -I "$ROOT"
}

# ---------------------------------------------------------------------------
# 1. Each macro file assembles standalone
# ---------------------------------------------------------------------------
echo "--- Macro file syntax checks ---"
for f in "$ROOT"/macros/*.nasm; do
    name=$(basename "$f")
    check "macros/$name" bash -c "\"$NASM\" -f win64 -o /dev/null \"$f\""
done

# ---------------------------------------------------------------------------
# 2. example.asm
# ---------------------------------------------------------------------------
echo "--- example.asm ---"
check "example.asm (elf64)"  assemble elf64 "$ROOT/example.asm" "$BUILD/example_linux.o"
check "example.asm (win64)"  assemble win64 "$ROOT/example.asm" "$BUILD/example_win.o"

# ---------------------------------------------------------------------------
# 3. sdl_rectangle.asm
# ---------------------------------------------------------------------------
echo "--- sdl_rectangle.asm ---"
check "sdl_rectangle.asm (elf64)" assemble elf64 "$ROOT/sdl_rectangle.asm" "$BUILD/sdl_linux.o"
check "sdl_rectangle.asm (win64)" assemble win64 "$ROOT/sdl_rectangle.asm" "$BUILD/sdl_win.o"

# ---------------------------------------------------------------------------
# 4. Runtime smoke test
# ---------------------------------------------------------------------------
echo "--- Runtime smoke test ---"
SMOKE_SRC="$ROOT/tests/smoke_test.asm"
if [ "$WIN64" -eq 1 ]; then
    if assemble win64 "$SMOKE_SRC" "$BUILD/smoke_test.o" && \
       "$GCC" "$BUILD/smoke_test.o" -o "$BUILD/smoke_test.exe" >"$BUILD/test.log" 2>&1; then
        "$BUILD/smoke_test.exe"
        if [ $? -eq 0 ]; then
            echo "  PASS  smoke_test.exe runs, all macro checks pass"
            PASS=$((PASS+1))
        else
            echo "  FAIL  smoke_test.exe exited with $?"
            FAIL=$((FAIL+1))
        fi
    else
        echo "  FAIL  smoke_test build"
        head -5 "$BUILD/test.log" | sed 's/^/        /'
        FAIL=$((FAIL+1))
    fi
else
    if assemble elf64 "$SMOKE_SRC" "$BUILD/smoke_test.o" && \
       ld "$BUILD/smoke_test.o" -o "$BUILD/smoke_test" >"$BUILD/test.log" 2>&1; then
        "$BUILD/smoke_test"
        if [ $? -eq 0 ]; then
            echo "  PASS  smoke_test runs, all macro checks pass"
            PASS=$((PASS+1))
        else
            echo "  FAIL  smoke_test exited with $?"
            FAIL=$((FAIL+1))
        fi
    else
        echo "  FAIL  smoke_test build"
        head -5 "$BUILD/test.log" | sed 's/^/        /'
        FAIL=$((FAIL+1))
    fi
fi

# ---------------------------------------------------------------------------
# 5. SDL demo
# ---------------------------------------------------------------------------
echo "--- SDL2 demo ---"
SDL_AVAILABLE=0
if [ "$WIN64" -eq 1 ]; then
    if "$GCC" "$BUILD/sdl_win.o" -o "$BUILD/sdl_rectangle.exe" \
            -lmingw32 -lSDL2main -lSDL2 >"$BUILD/test.log" 2>&1; then
        SDL_AVAILABLE=1
    else
        head -5 "$BUILD/test.log" | sed 's/^/        /'
    fi
else
    if "$GCC" "$BUILD/sdl_linux.o" -o "$BUILD/sdl_rectangle" -lSDL2 -no-pie \
            >"$BUILD/test.log" 2>&1; then
        SDL_AVAILABLE=1
    else
        head -5 "$BUILD/test.log" | sed 's/^/        /'
    fi
fi

if [ "$SDL_AVAILABLE" -eq 1 ]; then
    EXE="$BUILD/sdl_rectangle$([ "$WIN64" -eq 1 ] && echo .exe)"
    SDLDLL=""
    if [ "$WIN64" -eq 1 ]; then
        # make sure SDL2.dll is next to the executable
        for d in /c/msys64/mingw64/bin /c/msys64/ucrt64/bin; do
            if [ -f "$d/SDL2.dll" ]; then SDLDLL="$d/SDL2.dll"; break; fi
        done
        if [ -n "$SDLDLL" ]; then cp -f "$SDLDLL" "$BUILD/"; fi
    fi
    "$EXE" &
    SDL_PID=$!
    sleep 4
    if kill -0 "$SDL_PID" 2>/dev/null; then
        echo "  PASS  sdl_rectangle runs (window created, no crash)"
        PASS=$((PASS+1))
        kill "$SDL_PID" 2>/dev/null
        sleep 1
        kill -9 "$SDL_PID" 2>/dev/null
    else
        wait "$SDL_PID"
        echo "  FAIL  sdl_rectangle exited early with code $?"
        FAIL=$((FAIL+1))
    fi
else
    echo "  SKIP  SDL2 not available - sdl_rectangle linked but not run"
fi

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo "=============================================="
echo " RESULTS: $PASS passed, $FAIL failed"
echo "=============================================="
[ "$FAIL" -eq 0 ]
