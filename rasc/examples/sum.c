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
