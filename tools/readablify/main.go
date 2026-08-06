// readablify converts cryptic NASM source into Readable Assembly.
//
// It rewrites raw x86-64 mnemonics (mov, push, cmp, je, ...) and register
// names (rax, rbx, eax, ...) into the English-style macros of the
// readable_macros.nasm library, preserving labels, comments, strings and
// any instruction it does not know.
//
// Usage:
//
//	readablify input.asm                 # write readable version to stdout
//	readablify -o out.asm input.asm      # write to a file
//	readablify -w input.asm              # convert in place
//	readablify -verify input.asm         # also assemble both and compare code bytes
package main

import (
	"flag"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"strings"
)

// ---------------------------------------------------------------------------
// Register table: canonical NASM spelling -> readable alias
// ---------------------------------------------------------------------------

var regMap = map[string]string{
	// 64-bit
	"rax": "accumulator", "rbx": "base", "rcx": "counter", "rdx": "data",
	"rsi": "source_index", "rdi": "destination_index",
	"rbp": "base_pointer", "rsp": "stack_pointer", "rip": "register_rip",
	// 32-bit
	"eax": "accumulator_32", "ebx": "base_32", "ecx": "counter_32", "edx": "data_32",
	"esi": "source_index_32", "edi": "destination_index_32",
	"ebp": "base_pointer_32", "esp": "stack_pointer_32",
	// 16-bit
	"ax": "accumulator_16", "bx": "base_16", "cx": "counter_16", "dx": "data_16",
	"si": "source_index_16", "di": "destination_index_16",
	"bp": "base_pointer_16", "sp": "stack_pointer_16",
	// 8-bit low
	"al": "accumulator_8", "bl": "base_8", "cl": "counter_8", "dl": "data_8",
	"sil": "source_index_8", "dil": "destination_index_8",
	"bpl": "base_pointer_8", "spl": "stack_pointer_8",
	// 8-bit high
	"ah": "accumulator_8_high", "bh": "base_8_high",
	"ch": "counter_8_high", "dh": "data_8_high",
	// flags & special
	"eflags": "register_eflags", "rflags": "register_rflags", "mxcsr": "register_mxcsr",
}

func init() {
	// extended registers r8-r15 with explicit spelling
	for i := 8; i <= 15; i++ {
		n := fmt.Sprintf("r%d", i)
		regMap[n] = "register_" + n
		regMap[n+"d"] = "register_" + n + "_32"
		regMap[n+"w"] = "register_" + n + "_16"
		regMap[n+"b"] = "register_" + n + "_8"
	}
}

// ---------------------------------------------------------------------------
// Instruction table: mnemonic -> readable name
// ---------------------------------------------------------------------------

var insMap = map[string]string{
	// data movement
	"mov": "move", "lea": "load_effective_address", "xchg": "exchange",
	"xadd": "exchange_and_add", "bswap": "byte_swap", "xlat": "translate_byte",
	"push": "push_onto_stack", "pop": "pop_from_stack",
	"pusha": "push_all", "pushad": "push_all", "popa": "pop_all", "popad": "pop_all",
	"pushf": "push_flags", "pushfw": "push_flags_word",
	"pushfd": "push_flags_dword", "pushfq": "push_flags_qword",
	"popf": "pop_flags", "popfw": "pop_flags_word",
	"popfd": "pop_flags_dword", "popfq": "pop_flags_qword",
	"movsb": "move_string_byte", "movsw": "move_string_word",
	"movsd": "move_string_dword", "movsq": "move_string_qword",
	"movzx": "move_with_zero_extend", "movsx": "move_with_sign_extend",
	"movsxd": "move_with_sign_extend_dword",
	// arithmetic
	"add": "add", "adc": "add_with_carry",
	"adcx": "add_with_carry_flag", "adox": "add_with_overflow_flag",
	"sub": "subtract", "sbb": "subtract_with_borrow",
	"inc": "increment", "dec": "decrement",
	"mul": "multiply", "imul": "signed_multiply",
	"div": "divide", "idiv": "signed_divide",
	"neg": "negate", "cmp": "compare",
	// logic
	"and": "logical_and", "andn": "logical_and_not",
	"or": "logical_or", "xor": "logical_xor", "not": "logical_not",
	"test": "test",
	// shifts & rotates
	"shl": "shift_logical_left", "sal": "shift_arithmetic_left",
	"shr": "shift_logical_right", "sar": "shift_arithmetic_right",
	"rol": "rotate_left", "ror": "rotate_right",
	"rcl": "rotate_left_through_carry", "rcr": "rotate_right_through_carry",
	"shld": "shift_left_double", "shrd": "shift_right_double",
	"shlx": "shift_left_without_affecting_flags",
	"sarx": "shift_right_arithmetic_without_affecting_flags",
	"shrx": "shift_right_logical_without_affecting_flags",
	"rorx": "rotate_right_without_affecting_flags",
	// bit manipulation
	"bsf": "bit_scan_forward", "bsr": "bit_scan_reverse",
	"bt": "bit_test", "btc": "bit_test_and_complement",
	"btr": "bit_test_and_reset", "bts": "bit_test_and_set",
	"lzcnt": "count_leading_zeros", "tzcnt": "count_trailing_zeros",
	"popcnt": "population_count",
	"pdep": "parallel_bits_deposit", "pext": "parallel_bits_extract",
	"bextr": "bit_field_extract", "blsi": "extract_lowest_set_isolated_bit",
	"blsmsk": "get_mask_up_to_lowest_set_bit", "blsr": "reset_lowest_set_bit",
	"bzhi": "zero_high_bits",
	// control flow
	"jmp": "jump",
	"je": "jump_if_equal", "jz": "jump_if_zero",
	"jne": "jump_if_not_equal", "jnz": "jump_if_not_zero",
	"jg": "jump_if_greater", "jge": "jump_if_greater_or_equal",
	"jl": "jump_if_less", "jle": "jump_if_less_or_equal",
	"ja": "jump_if_above", "jae": "jump_if_above_or_equal",
	"jb": "jump_if_below", "jbe": "jump_if_below_or_equal",
	"jc": "jump_if_carry", "jnc": "jump_if_not_carry",
	"jo": "jump_if_overflow", "jno": "jump_if_not_overflow",
	"js": "jump_if_sign", "jns": "jump_if_not_sign",
	"jp": "jump_if_parity", "jnp": "jump_if_no_parity",
	"jpe": "jump_if_parity_even", "jpo": "jump_if_parity_odd",
	"jcxz": "jump_if_cx_zero", "jecxz": "jump_if_ecx_zero", "jrcxz": "jump_if_rcx_zero",
	"call": "call_procedure",
	"ret": "return_from_procedure", "retn": "return_from_procedure",
	"retf": "return_far",
	"loop": "loop", "loope": "loop_if_equal", "loopz": "loop_if_zero",
	"loopne": "loop_if_not_equal", "loopnz": "loop_if_not_zero",
	"enter": "enter_stack_frame", "leave": "leave_stack_frame",
	// conditional moves
	"cmove": "move_if_equal", "cmovz": "move_if_zero",
	"cmovne": "move_if_not_equal", "cmovnz": "move_if_not_zero",
	"cmovg": "move_if_greater", "cmovge": "move_if_greater_or_equal",
	"cmovl": "move_if_less", "cmovle": "move_if_less_or_equal",
	"cmova": "move_if_above", "cmovae": "move_if_above_or_equal",
	"cmovb": "move_if_below", "cmovbe": "move_if_below_or_equal",
	"cmovc": "move_if_carry", "cmovnc": "move_if_not_carry",
	"cmovo": "move_if_overflow", "cmovno": "move_if_not_overflow",
	"cmovs": "move_if_sign", "cmovns": "move_if_not_sign",
	"cmovp": "move_if_parity", "cmovnp": "move_if_no_parity",
	"cmovpe": "move_if_parity_even", "cmovpo": "move_if_parity_odd",
	"cmovna": "move_if_not_above", "cmovnae": "move_if_not_above_or_equal",
	"cmovnb": "move_if_not_below", "cmovnbe": "move_if_not_below_or_equal",
	"cmovng": "move_if_not_greater", "cmovnge": "move_if_not_greater_or_equal",
	"cmovnl": "move_if_not_less", "cmovnle": "move_if_not_less_or_equal",
	// condition codes
	"sete": "set_if_equal", "setz": "set_if_zero",
	"setne": "set_if_not_equal", "setnz": "set_if_not_zero",
	"setg": "set_if_greater", "setge": "set_if_greater_or_equal",
	"setl": "set_if_less", "setle": "set_if_less_or_equal",
	"seta": "set_if_above", "setae": "set_if_above_or_equal",
	"setb": "set_if_below", "setbe": "set_if_below_or_equal",
	"setc": "set_if_carry", "setnc": "set_if_not_carry",
	"seto": "set_if_overflow", "setno": "set_if_not_overflow",
	"sets": "set_if_sign", "setns": "set_if_not_sign",
	"setp": "set_if_parity", "setnp": "set_if_no_parity",
	"setpe": "set_if_parity_even", "setpo": "set_if_parity_odd",
	"setna": "set_if_not_above", "setnae": "set_if_not_above_or_equal",
	"setnb": "set_if_not_below", "setnbe": "set_if_not_below_or_equal",
	"setng": "set_if_not_greater", "setnge": "set_if_not_greater_or_equal",
	"setnl": "set_if_not_less", "setnle": "set_if_not_less_or_equal",
	// string ops
	"cmpsb": "compare_string_byte", "cmpsw": "compare_string_word",
	"cmpsd": "compare_string_dword", "cmpsq": "compare_string_qword",
	"stosb": "store_string_byte", "stosw": "store_string_word",
	"stosd": "store_string_dword", "stosq": "store_string_qword",
	"lodsb": "load_string_byte", "lodsw": "load_string_word",
	"lodsd": "load_string_dword", "lodsq": "load_string_qword",
	"scasb": "scan_string_byte", "scasw": "scan_string_word",
	"scasd": "scan_string_dword", "scasq": "scan_string_qword",
	// flags
	"clc": "clear_carry_flag", "stc": "set_carry_flag",
	"cld": "clear_direction_flag", "std": "set_direction_flag",
	"cli": "clear_interrupt_flag", "sti": "set_interrupt_flag",
	"clac": "clear_ac_flag", "stac": "set_ac_flag",
	"cmc": "complement_carry_flag",
	"lahf": "load_flags_into_ah", "sahf": "store_ah_into_flags",
	// converts
	"cbw": "convert_byte_to_word", "cwde": "convert_word_to_dword",
	"cdqe": "convert_dword_to_qword",
	"cwd": "convert_word_to_dword_pair", "cdq": "convert_dword_to_qword_pair",
	"cqo": "convert_qword_to_oword_pair",
	// system
	"syscall": "syscall_invoke",
	"sysenter": "system_enter", "sysexit": "system_exit", "sysret": "system_return",
	"int": "interrupt", "int3": "interrupt_3", "int1": "interrupt_1",
	"into": "interrupt_on_overflow",
	"iret": "return_from_interrupt", "iretd": "return_from_interrupt_dword",
	"iretq": "return_from_interrupt_qword",
	"hlt": "halt", "nop": "no_operation", "pause": "pause",
	"cpuid": "cpu_identification", "ud2": "undefined_instruction",
	"lock": "lock_bus",
	"rdtsc": "read_time_stamp_counter", "rdtscp": "read_time_stamp_counter_and_processor_id",
	"rdmsr": "read_model_specific_register", "wrmsr": "write_model_specific_register",
	"rdpmc": "read_performance_counter",
	"rdrand": "read_random_value", "rdseed": "read_seed_value",
	// x87 FPU (common subset)
	"fld": "fpu_load", "fst": "fpu_store", "fstp": "fpu_store_and_pop",
	"fld1": "fpu_load_one", "fldz": "fpu_load_zero", "fldpi": "fpu_load_pi",
	"fadd": "fpu_add", "faddp": "fpu_add_and_pop",
	"fsub": "fpu_subtract", "fsubp": "fpu_subtract_and_pop",
	"fmul": "fpu_multiply", "fmulp": "fpu_multiply_and_pop",
	"fdiv": "fpu_divide", "fdivp": "fpu_divide_and_pop",
	"fsqrt": "fpu_square_root", "fsin": "fpu_sine", "fcos": "fpu_cosine",
	"fabs": "fpu_absolute_value", "fchs": "fpu_change_sign",
	"fxch": "fpu_exchange", "fcom": "fpu_compare", "fcomp": "fpu_compare_and_pop",
	"finit": "fpu_initialize", "fwait": "fpu_wait", "fnop": "fpu_no_operation",
	"emms": "mmx_empty_state",
}

// sizedIns are mnemonics whose _byte/_word/_dword/_qword variants exist in
// the library; the tool uses the sized form when an operand carries an
// explicit size qualifier (e.g. "add dword [x], 1").
var sizedIns = map[string]bool{
	"mov": true, "cmp": true, "add": true, "sub": true, "inc": true, "dec": true,
	"neg": true, "and": true, "or": true, "xor": true, "not": true,
	"shl": true, "sal": true, "shr": true, "sar": true,
	"rol": true, "ror": true, "rcl": true, "rcr": true,
	"mul": true, "imul": true, "div": true, "idiv": true,
	"adc": true, "sbb": true,
}

var sizeSuffix = map[string]string{
	"byte": "_byte", "word": "_word", "dword": "_dword", "qword": "_qword",
	"tword": "_tword", "oword": "_oword",
}

// data directives
var dataDef = map[string]string{
	"db": "define_byte", "dw": "define_word", "dd": "define_dword",
	"dq": "define_qword", "dt": "define_tword", "do": "define_oword",
	"dy": "define_yword", "dz": "define_zword",
}
var dataRes = map[string]string{
	"resb": "reserve_byte", "resw": "reserve_word", "resd": "reserve_dword",
	"resq": "reserve_qword", "rest": "reserve_tword", "reso": "reserve_oword",
	"resy": "reserve_yword", "resz": "reserve_zword",
}

// directives passed through unchanged
var directives = map[string]bool{
	"section": true, "segment": true, "global": true, "extern": true,
	"common": true, "absolute": true, "align": true, "bits": true,
	"org": true, "default": true, "cpu": true, "format": true,
	"times": true, "struc": true, "endstruc": true, "istruc": true,
	"at": true, "iend": true, "use16": true, "use32": true, "use64": true,
	"option": true, "pragma": true,
}

// ---------------------------------------------------------------------------
// Line helpers
// ---------------------------------------------------------------------------

// splitComment returns the code part and the comment part (starting at ';').
// Quote-aware: ';' inside string literals is not a comment.
func splitComment(line string) (string, string) {
	var sb strings.Builder
	inQ := false
	for i := 0; i < len(line); i++ {
		c := line[i]
		if c == '"' {
			inQ = !inQ
		}
		if c == ';' && !inQ {
			return sb.String(), line[i:]
		}
		sb.WriteByte(c)
	}
	return sb.String(), ""
}

// identRegex matches NASM identifier-ish tokens (registers, labels, numbers).
var identRegex = regexp.MustCompile(`[A-Za-z_.$][A-Za-z0-9_.$@~?#]*`)

// replaceRegisters rewrites register names in an operand string, skipping
// string literals. Non-register tokens are preserved exactly.
func replaceRegisters(s string) string {
	var sb strings.Builder
	i := 0
	for i < len(s) {
		if s[i] == '"' {
			j := i + 1
			for j < len(s) && s[j] != '"' {
				j++
			}
			if j < len(s) {
				j++
			}
			sb.WriteString(s[i:j])
			i = j
			continue
		}
		loc := identRegex.FindStringIndex(s[i:])
		if loc == nil {
			sb.WriteString(s[i:])
			break
		}
		sb.WriteString(s[i : i+loc[0]])
		tok := s[i+loc[0] : i+loc[1]]
		if rep, ok := regMap[strings.ToLower(tok)]; ok {
			sb.WriteString(rep)
		} else {
			sb.WriteString(tok)
		}
		i += loc[1]
	}
	return sb.String()
}

// splitOperands splits an operand list on commas, respecting brackets and
// string literals.
func splitOperands(s string) []string {
	var parts []string
	depth := 0
	inQ := false
	start := 0
	for i := 0; i < len(s); i++ {
		c := s[i]
		switch {
		case c == '"':
			inQ = !inQ
		case !inQ && (c == '[' || c == '('):
			depth++
		case !inQ && (c == ']' || c == ')'):
			depth--
		case !inQ && c == ',' && depth == 0:
			parts = append(parts, strings.TrimSpace(s[start:i]))
			start = i + 1
		}
	}
	parts = append(parts, strings.TrimSpace(s[start:]))
	return parts
}

func firstWord(s string) string {
	s = strings.TrimSpace(s)
	if i := strings.IndexAny(s, " \t"); i >= 0 {
		return s[:i]
	}
	return s
}

// ---------------------------------------------------------------------------
// Line conversion
// ---------------------------------------------------------------------------

type lineParts struct {
	label    string // without trailing colon
	mnem     string // lowercase
	operands string // raw operand substring, unmodified
}

// parseLine splits a code line into label / mnemonic / operands.
// ok is false when the line should pass through untouched.
func parseLine(code string) (parts lineParts, ok bool) {
	toks := strings.Fields(code)
	if len(toks) == 0 {
		return parts, false
	}
	first := strings.ToLower(toks[0])

	if strings.HasPrefix(code, "%") || directives[first] {
		return parts, false
	}

	if isMnemonic(first) {
		parts.mnem = first
	} else if len(toks) >= 2 && isMnemonic(strings.ToLower(toks[1])) {
		parts.label = strings.TrimSuffix(toks[0], ":")
		parts.mnem = strings.ToLower(toks[1])
	} else if strings.HasSuffix(first, ":") && len(toks) >= 2 {
		parts.label = strings.TrimSuffix(first, ":")
		parts.mnem = strings.ToLower(toks[1])
	} else if len(toks) == 1 && strings.HasSuffix(first, ":") {
		parts.label = strings.TrimSuffix(first, ":")
		return parts, true
	} else {
		return parts, false
	}

	// operand substring: everything after the mnemonic token
	parts.operands = operandsAfter(code, toks, parts.label != "", parts.mnem)
	return parts, true
}

// operandsAfter returns the raw text following the mnemonic token.
func operandsAfter(code string, toks []string, hasLabel bool, mnem string) string {
	idx := 0
	if hasLabel {
		idx = 1
	}
	pos := 0
	for i := 0; i <= idx; i++ {
		for pos < len(code) && (code[pos] == ' ' || code[pos] == '\t') {
			pos++
		}
		start := pos
		for pos < len(code) && code[pos] != ' ' && code[pos] != '\t' {
			pos++
		}
		if i == idx {
			return strings.TrimSpace(code[pos:])
		}
		_ = start
	}
	return ""
}

// isMnemonic reports whether the token is a known instruction or directive.
func isMnemonic(tok string) bool {
	tok = strings.ToLower(tok)
	return insMap[tok] != "" || dataDef[tok] != "" || dataRes[tok] != "" || tok == "equ"
}

// convertLine transforms a parsed line into readable form.
// Returns false when the mnemonic is unknown (caller passes through).
func convertLine(p lineParts) (readable string, ok bool) {
	switch {
	case p.mnem == "equ":
		return formatLine("", "equate", p.label+", "+replaceRegisters(p.operands)), true
	case dataDef[p.mnem] != "":
		return formatLine(p.label, dataDef[p.mnem], replaceRegisters(p.operands)), true
	case dataRes[p.mnem] != "":
		return formatLine(p.label, dataRes[p.mnem], replaceRegisters(p.operands)), true
	}

	readable = insMap[p.mnem]
	if readable == "" {
		return "", false
	}

	ops := p.operands

	// imul: pick the form by operand count
	if p.mnem == "imul" {
		switch len(splitOperands(p.operands)) {
		case 1:
			readable = "signed_multiply"
		case 2:
			readable = "signed_multiply_immediate"
		case 3:
			readable = "signed_multiply_immediate_3"
		}
	}

	// sized forms: explicit size qualifier on the destination operand
	if sizedIns[p.mnem] {
		parts := splitOperands(p.operands)
		if len(parts) > 0 {
			kw := strings.ToLower(firstWord(parts[0]))
			if suf, ok := sizeSuffix[kw]; ok {
				readable += suf
				rest := strings.TrimSpace(strings.TrimPrefix(p.operands, kw))
				rest = strings.TrimSpace(rest)
				ops = rest
			}
		}
	}

	// movzx/movsx: size comes from the SOURCE operand
	if readable == "move_with_zero_extend" || readable == "move_with_sign_extend" {
		parts := splitOperands(p.operands)
		if len(parts) >= 2 {
			kw := strings.ToLower(firstWord(parts[1]))
			if suf, ok := sizeSuffix[kw]; ok {
				readable += suf
				second := strings.TrimSpace(parts[1])
				second = strings.TrimSpace(strings.TrimPrefix(second, kw))
				ops = strings.TrimSpace(parts[0]) + ", " + second
			}
		}
	}

	return formatLine(p.label, readable, replaceRegisters(ops)), true
}

// formatLine renders "label: mnemonic operands" with alignment.
func formatLine(label, mnem, ops string) string {
	var sb strings.Builder
	sb.WriteString("    ")
	if label != "" {
		sb.WriteString(label)
		sb.WriteString(": ")
	}
	if len(mnem) < 12 {
		sb.WriteString(mnem)
		sb.WriteString(strings.Repeat(" ", 12-len(mnem)))
	} else {
		sb.WriteString(mnem)
		sb.WriteString(" ")
	}
	sb.WriteString(ops)
	return strings.TrimRight(sb.String(), " ")
}

// ---------------------------------------------------------------------------
// File conversion
// ---------------------------------------------------------------------------

const includeLine = `%include "readable_macros.nasm"`

func convertFile(src []byte, addInclude bool) []byte {
	lines := strings.Split(string(src), "\n")
	var out []string
	hasInclude := false

	for _, line := range lines {
		code, comment := splitComment(line)

		if p, ok := parseLine(code); ok {
			if readable, conv := convertLine(p); conv {
				if comment != "" {
					readable += "  " + comment
				}
				out = append(out, readable)
				continue
			}
		}

		// passthrough: rewrite registers even in unknown lines
		if strings.TrimSpace(code) != "" && !strings.HasPrefix(strings.TrimSpace(code), "%") {
			if rewritten := replaceRegisters(code); rewritten != code {
				line = rewritten + comment
			}
		}
		if strings.Contains(line, includeLine) {
			hasInclude = true
		}
		out = append(out, line)
	}

	if addInclude && !hasInclude {
		out = append([]string{banner(), includeLine, ""}, out...)
	}
	return []byte(strings.Join(out, "\n"))
}

func banner() string {
	return "; Converted to Readable Assembly by readablify"
}

// ---------------------------------------------------------------------------
// Verification
// ---------------------------------------------------------------------------

func run(args ...string) (string, error) {
	cmd := exec.Command(args[0], args[1:]...)
	var out strings.Builder
	cmd.Stdout = &out
	cmd.Stderr = &out
	err := cmd.Run()
	return out.String(), err
}

func findTool(names ...string) string {
	for _, c := range names {
		if p, err := exec.LookPath(c); err == nil {
			return p
		}
		// git-bash style path (/c/msys64/...): convert for Go on Windows
		if p, ok := msysToWinPath(c); ok {
			if _, err := os.Stat(p); err == nil {
				return p
			}
		}
	}
	return ""
}

// msysToWinPath converts "/c/msys64/bin/x" to "C:\\msys64\\bin\\x".
func msysToWinPath(p string) (string, bool) {
	if len(p) < 4 || p[0] != '/' || p[2] != '/' {
		return "", false
	}
	drive := strings.ToUpper(p[1:2])
	rest := strings.ReplaceAll(p[3:], "/", "\\")
	return drive + ":\\" + rest, true
}

// findIncludeDir locates the directory holding readable_macros.nasm.
func findIncludeDir(input string) string {
	cands := []string{
		filepath.Dir(input),
		".",
	}
	if exe, err := os.Executable(); err == nil {
		cands = append(cands, filepath.Join(filepath.Dir(exe), "..", ".."))
	}
	for _, c := range cands {
		if _, err := os.Stat(filepath.Join(c, "readable_macros.nasm")); err == nil {
			return c
		}
	}
	return "."
}

func verify(input, output, format string) error {
	nasm := findTool("nasm", "/c/msys64/usr/bin/nasm.exe", "/usr/bin/nasm")
	if nasm == "" {
		return fmt.Errorf("nasm not found; verification skipped")
	}
	dir := filepath.Dir(output)
	inObj := filepath.Join(dir, ".readablify_in.o")
	outObj := filepath.Join(dir, ".readablify_out.o")
	defer os.Remove(inObj)
	defer os.Remove(outObj)

	if msg, err := run(nasm, "-f", format, input, "-o", inObj); err != nil {
		return fmt.Errorf("input does not assemble: %s", strings.TrimSpace(msg))
	}
	if msg, err := run(nasm, "-f", format, "-I", findIncludeDir(input), output, "-o", outObj); err != nil {
		return fmt.Errorf("converted output does not assemble: %s", strings.TrimSpace(msg))
	}
	fmt.Println("  OK  both files assemble")

	objcopy := findTool("objcopy", "/c/msys64/mingw64/bin/objcopy.exe", "/usr/bin/objcopy")
	if objcopy == "" {
		return fmt.Errorf("objcopy not found; machine-code comparison skipped")
	}
	inBin := filepath.Join(dir, ".readablify_in.bin")
	outBin := filepath.Join(dir, ".readablify_out.bin")
	defer os.Remove(inBin)
	defer os.Remove(outBin)
	if msg, err := run(objcopy, "-O", "binary", "--only-section=.text", inObj, inBin); err != nil {
		return fmt.Errorf("objcopy input: %s", strings.TrimSpace(msg))
	}
	if msg, err := run(objcopy, "-O", "binary", "--only-section=.text", outObj, outBin); err != nil {
		return fmt.Errorf("objcopy output: %s", strings.TrimSpace(msg))
	}
	a, _ := os.ReadFile(inBin)
	b, _ := os.ReadFile(outBin)
	if len(a) != len(b) || !bytesEqual(a, b) {
		return fmt.Errorf("machine code differs (%d vs %d bytes)", len(a), len(b))
	}
	fmt.Printf("  OK  .text machine code identical (%d bytes)\n", len(a))
	return nil
}

func bytesEqual(a, b []byte) bool {
	for i := range a {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}

// ---------------------------------------------------------------------------
// main
// ---------------------------------------------------------------------------

func usage() {
	fmt.Fprintf(os.Stderr, `readablify - convert cryptic NASM into Readable Assembly

Usage:
  readablify [options] input.asm

Options (place them before the input file):
  -o file       write the readable version to file (default: stdout)
  -w            convert the input file in place
  -f format     assembly format for verification (default: elf64)
  -no-include   do not add %s
  -verify       assemble the input and the output and compare machine code
  -h            show this help
`, includeLine)
}

func main() {
	var (
		flagOut     = flag.String("o", "", "output file")
		flagInPlace = flag.Bool("w", false, "convert in place")
		flagFormat  = flag.String("f", "elf64", "assembly format")
		flagNoInc   = flag.Bool("no-include", false, "do not add the include line")
		flagVerify  = flag.Bool("verify", false, "verify machine code is identical")
	)
	flag.Usage = usage
	flag.Parse()

	args := flag.Args()
	if len(args) != 1 {
		usage()
		os.Exit(2)
	}
	input := args[0]
	src, err := os.ReadFile(input)
	if err != nil {
		fmt.Fprintf(os.Stderr, "readablify: %v\n", err)
		os.Exit(1)
	}

	out := convertFile(src, !*flagNoInc)

	dest := ""
	switch {
	case *flagInPlace:
		dest = input
	case *flagOut != "":
		dest = *flagOut
	default:
		os.Stdout.Write(out)
	}

	if dest != "" {
		if err := os.WriteFile(dest, out, 0o644); err != nil {
			fmt.Fprintf(os.Stderr, "readablify: %v\n", err)
			os.Exit(1)
		}
		fmt.Printf("readablify: wrote %s\n", dest)
	}

	if *flagVerify {
		if dest == "" {
			tmp := filepath.Join(os.TempDir(), "readablify_out.asm")
			if err := os.WriteFile(tmp, out, 0o644); err != nil {
				fmt.Fprintf(os.Stderr, "readablify: %v\n", err)
				os.Exit(1)
			}
			dest = tmp
			defer os.Remove(tmp)
		}
		if err := verify(input, dest, *flagFormat); err != nil {
			fmt.Fprintf(os.Stderr, "readablify: verification failed: %v\n", err)
			os.Exit(1)
		}
	}
}
