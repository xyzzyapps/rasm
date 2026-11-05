package disasm

import (
	"fmt"
	"strings"

	"golang.org/x/arch/x86/x86asm"
)

// prefixWords are Intel prefix spellings that stay in front of the mnemonic.
// rep/repne are wrapped with the readable repeat macros instead.
var prefixWords = map[string]bool{
	"rep": true, "repe": true, "repz": true, "repne": true, "repnz": true,
	"lock": true, "bnd": true, "xacquire": true, "xrelease": true,
	"addr16": true, "addr32": true, "data16": true, "data32": true,
	"hint-taken": true, "hint-not-taken": true,
}

var sizeOrder = []string{"qword", "dword", "word", "byte"}

var extraPtrSizes = []string{"zmmword", "ymmword", "xmmword", "tword", "oword"}

// toReadable converts one Intel-syntax instruction into Readable Assembly.
// Unknown mnemonics keep their Intel spelling. Register names are still translated.
func toReadable(intel string) string {
	s := strings.TrimSpace(intel)
	if s == "" || strings.HasPrefix(s, "db ") || strings.HasPrefix(s, "define_byte ") {
		return s
	}

	var prefs []string
	for {
		word, rest, ok := cutWord(s)
		if !ok || !prefixWords[word] {
			break
		}
		prefs = append(prefs, word)
		s = rest
	}

	mnem, operands := splitMnemonic(s)
	vector := hasVector(operands)
	ambiguous := vector && (mnem == "movsd" || mnem == "movss" || mnem == "cmpsd")

	if !ambiguous && implicitOperand[mnem] {
		operands = ""
	}

	size := firstPtrSize(operands)
	fold := ""
	if !ambiguous && foldSize(mnem, size) {
		fold = size
	}
	operands = stripPtrs(operands, fold)
	operands = renameRegs(operands)
	operands = strings.TrimSpace(operands)

	name := mnem
	if !ambiguous {
		if n := readableName(mnem, operands); n != "" {
			name = n
		}
	}
	if fold != "" {
		if suf, ok := sizeSuffix[fold]; ok && !strings.HasSuffix(name, suf) {
			name += suf
		}
	}
	line := name
	if operands != "" {
		line += " " + operands
	}
	return applyPrefixes(prefs, mnem, line)
}

func cutWord(s string) (word, rest string, ok bool) {
	s = strings.TrimSpace(s)
	if s == "" {
		return "", "", false
	}
	i := strings.IndexAny(s, " \t")
	if i < 0 {
		return s, "", true
	}
	return s[:i], strings.TrimSpace(s[i+1:]), true
}

func splitMnemonic(s string) (mnem, operands string) {
	for _, two := range []string{"call far", "jmp far", "ret far"} {
		if s == two || strings.HasPrefix(s, two+" ") || strings.HasPrefix(s, two+"\t") {
			return two, strings.TrimSpace(s[len(two):])
		}
	}
	word, rest, _ := cutWord(s)
	return word, rest
}

func hasVector(s string) bool {
	for _, p := range []string{"xmm", "ymm", "zmm", "mmx"} {
		if strings.Contains(s, p) {
			return true
		}
	}
	return false
}

func foldSize(mnem, size string) bool {
	if size == "" {
		return false
	}
	if _, ok := sizeSuffix[size]; !ok {
		return false
	}
	if mnem == "movzx" || mnem == "movsx" {
		return size == "byte" || size == "word" || size == "dword"
	}
	return sizedIns[mnem]
}

func readableName(mnem, operands string) string {
	if mnem == "imul" {
		switch len(splitOperands(operands)) {
		case 2:
			return "signed_multiply_immediate"
		case 3:
			return "signed_multiply_immediate_3"
		default:
			return "signed_multiply"
		}
	}
	return insMap[mnem]
}

func applyPrefixes(prefs []string, mnem, line string) string {
	if len(prefs) == 1 {
		switch prefs[0] {
		case "rep":
			if strings.HasPrefix(mnem, "cmps") || strings.HasPrefix(mnem, "scas") {
				return "repeat_if_equal " + line
			}
			return "repeat " + line
		case "repe", "repz":
			return "repeat_if_equal " + line
		case "repne", "repnz":
			return "repeat_if_not_equal " + line
		}
	}
	if len(prefs) == 0 {
		return line
	}
	return strings.Join(prefs, " ") + " " + line
}

func firstPtrSize(s string) string {
	bestAt := -1
	best := ""
	for _, sz := range sizeOrder {
		i := findToken(s, sz+" ptr")
		if i >= 0 && (bestAt < 0 || i < bestAt) {
			bestAt = i
			best = sz
		}
	}
	return best
}

func findToken(s, token string) int {
	start := 0
	for {
		i := strings.Index(s[start:], token)
		if i < 0 {
			return -1
		}
		i += start
		if boundaryBefore(s, i) && boundaryAfter(s, i+len(token)) {
			return i
		}
		start = i + 1
		if start >= len(s) {
			return -1
		}
	}
}

func boundaryBefore(s string, i int) bool {
	return i == 0 || !isIdentByte(s[i-1])
}

func boundaryAfter(s string, i int) bool {
	return i >= len(s) || !isIdentByte(s[i])
}

func isIdentByte(c byte) bool {
	return c == '_' || c >= 'a' && c <= 'z' || c >= 'A' && c <= 'Z' || c >= '0' && c <= '9'
}

func stripPtrs(rest, fold string) string {
	if fold != "" {
		token := fold + " ptr"
		if i := findToken(rest, token); i >= 0 {
			rest = rest[:i] + rest[i+len(token):]
		}
	}
	for _, sz := range append(append([]string{}, sizeOrder...), extraPtrSizes...) {
		rest = strings.ReplaceAll(rest, sz+" ptr", sz)
	}
	return strings.Join(strings.Fields(rest), " ")
}

func renameRegs(s string) string {
	var b strings.Builder
	i := 0
	for i < len(s) {
		if isIdentStart(s[i]) {
			j := i + 1
			for j < len(s) && isIdentByte(s[j]) {
				j++
			}
			tok := s[i:j]
			if rep, ok := regMap[tok]; ok {
				b.WriteString(rep)
			} else {
				b.WriteString(tok)
			}
			i = j
			continue
		}
		b.WriteByte(s[i])
		i++
	}
	return b.String()
}

func isIdentStart(c byte) bool {
	return c == '_' || c >= 'a' && c <= 'z' || c >= 'A' && c <= 'Z'
}

func splitOperands(s string) []string {
	s = strings.TrimSpace(s)
	if s == "" {
		return nil
	}
	var parts []string
	depth := 0
	start := 0
	for i := 0; i < len(s); i++ {
		switch s[i] {
		case '[', '(':
			depth++
		case ']', ')':
			if depth > 0 {
				depth--
			}
		case ',':
			if depth == 0 {
				parts = append(parts, strings.TrimSpace(s[start:i]))
				start = i + 1
			}
		}
	}
	parts = append(parts, strings.TrimSpace(s[start:]))
	return parts
}

// annotate replaces a numeric target with a relocation symbol name.
func annotate(intel string, inst x86asm.Inst, pc uint64, reloc string) string {
	if reloc == "" || strings.Contains(intel, reloc) {
		return intel
	}
	for _, arg := range inst.Args {
		if arg == nil {
			break
		}
		switch a := arg.(type) {
		case x86asm.Rel:
			var tok string
			if pc == 0 {
				tok = fmt.Sprintf(".%+#x", int64(a))
			} else {
				tok = fmt.Sprintf("%#x", pc+uint64(inst.Len)+uint64(a))
			}
			if strings.Contains(intel, tok) {
				return strings.Replace(intel, tok, reloc, 1)
			}
		case x86asm.Mem:
			if a.Base == x86asm.RIP || a.Base == x86asm.EIP {
				base := "rip"
				if a.Base == x86asm.EIP {
					base = "eip"
				}
				if a.Disp != 0 {
					needle := base + fmt.Sprintf("%+#x", a.Disp)
					if strings.Contains(intel, needle) {
						return strings.Replace(intel, needle, reloc, 1)
					}
				} else if strings.Contains(intel, base) {
					return strings.Replace(intel, base, reloc, 1)
				}
			}
		case x86asm.Imm:
			tok := fmt.Sprintf("%#x", int64(a))
			if strings.Contains(intel, tok) {
				return strings.Replace(intel, tok, reloc, 1)
			}
		}
	}
	return intel + " ; " + reloc
}
