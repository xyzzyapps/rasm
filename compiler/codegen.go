package main

import (
	_ "embed"
	"fmt"
	"strconv"
	"strings"
)

// ============================================================================
// rasl code generator
//
// Translates the minimal-Lisp s-expression tree into readable assembly built
// on the rasm macro vocabulary (readable_macros.nasm). The generated file is
// a thin wrapper: each construct maps to a small, commented rasm block.
//
// Calling convention (defined by the compiler, used on both ends):
//   - function arguments are pushed on the stack in order,
//   - the result is left in accumulator_64,
//   - arguments live at [base_pointer + 16 + 8*i] inside the callee.
//
// Values are raw 64-bit integers: #t = 1, #f = 0. No tags, no heap, no GC.
// ============================================================================

//go:embed runtime.rasm
var runtimeSource string

// symKind classifies declared names.
type symKind int

const (
	kindScalar symKind = iota
	kindArray
	kindStruct
	kindFunc
)

// fieldInfo describes one struct field (size reserved for future sized access).
type fieldInfo struct {
	size int
}

// symInfo is one entry in the symbol table.
type symInfo struct {
	kind       symKind
	count      int                  // arrays: element count
	fields     map[string]fieldInfo // structs: field name -> info
	fieldOrder []string             // structs: field declaration order
}

// Emitter accumulates generated lines.
type Emitter struct {
	lines []string
}

func (e *Emitter) emitf(format string, args ...any) {
	e.lines = append(e.lines, fmt.Sprintf(format, args...))
}

func (e *Emitter) emit(s string) {
	e.lines = append(e.lines, s)
}

func (e *Emitter) String() string { return strings.Join(e.lines, "\n") + "\n" }

// Compiler holds symbol state and emits the program.
type Compiler struct {
	logf      func(format string, args ...any)
	syms      map[string]*symInfo
	order     []string        // declaration order
	inits     []Node          // top-level initializer forms (run at startup)
	funcForms map[string]Node // function name -> defining form
	labelN    int             // internal label counter
	em        *Emitter
	userMain  bool // user defined (define (main) ...)
}

// NewCompiler returns a Compiler; logf may be nil.
func NewCompiler(logf func(format string, args ...any)) *Compiler {
	if logf == nil {
		logf = func(string, ...any) {}
	}
	return &Compiler{
		logf:      logf,
		syms:      map[string]*symInfo{},
		funcForms: map[string]Node{},
		em:        &Emitter{},
	}
}

// ============================================================================
// Pass 1: register top-level declarations
// ============================================================================

func (c *Compiler) registerTop(f Node) error {
	items := ListItems(f)
	if items == nil {
		return fmt.Errorf("top-level form must be a list, got %s", NodeString(f))
	}
	head := AtomName(items[0])
	switch head {
	case "define":
		if len(items) < 2 {
			return fmt.Errorf("define needs a name: %s", NodeString(f))
		}
		if inner := ListItems(items[1]); inner != nil {
			// (define (f args...) body...) — function definition
			name := AtomName(inner[0])
			if name == "" {
				return fmt.Errorf("function name must be a symbol: %s", NodeString(f))
			}
			if err := c.register(name, &symInfo{kind: kindFunc}); err != nil {
				return err
			}
			c.funcForms[name] = f
			if name == "main" {
				c.userMain = true
			}
			c.logf("registered function %s", name)
			return nil
		}
		if AtomName(items[1]) == "" {
			return fmt.Errorf("define name must be a symbol or function: %s", NodeString(f))
		}
		if err := c.register(AtomName(items[1]), &symInfo{kind: kindScalar}); err != nil {
			return err
		}
		c.inits = append(c.inits, f) // initializer runs at startup
		c.logf("registered global %s", AtomName(items[1]))
		return nil
	case "global":
		if len(items) != 2 || AtomName(items[1]) == "" {
			return fmt.Errorf("global needs one symbol: %s", NodeString(f))
		}
		if err := c.register(AtomName(items[1]), &symInfo{kind: kindScalar}); err != nil {
			return err
		}
		c.logf("registered global %s", AtomName(items[1]))
		return nil
	case "define-array":
		if len(items) != 3 || AtomName(items[1]) == "" {
			return fmt.Errorf("define-array needs a name and a count: %s", NodeString(f))
		}
		n, ok := items[2].(Num)
		if !ok || n.Val < 0 {
			return fmt.Errorf("define-array count must be a non-negative literal: %s", NodeString(f))
		}
		if err := c.register(AtomName(items[1]), &symInfo{kind: kindArray, count: int(n.Val)}); err != nil {
			return err
		}
		c.logf("registered array %s[%d]", AtomName(items[1]), n.Val)
		return nil
	case "define-struct":
		if len(items) < 2 || AtomName(items[1]) == "" {
			return fmt.Errorf("define-struct needs a name: %s", NodeString(f))
		}
		si := &symInfo{kind: kindStruct, fields: map[string]fieldInfo{}}
		for _, fld := range items[2:] {
			name, size, err := parseStructField(fld)
			if err != nil {
				return fmt.Errorf("%s (in %s)", err, NodeString(f))
			}
			if _, dup := si.fields[name]; dup {
				return fmt.Errorf("duplicate struct field %s in %s", name, NodeString(f))
			}
			si.fields[name] = fieldInfo{size: size}
			si.fieldOrder = append(si.fieldOrder, name)
			c.logf("struct %s field %s size %d", AtomName(items[1]), name, size)
		}
		if err := c.register(AtomName(items[1]), si); err != nil {
			return err
		}
		return nil
	default:
		// Bare top-level expression: evaluate at startup, discard the value.
		c.inits = append(c.inits, f)
		return nil
	}
}

// parseStructField accepts either a symbol (qword field) or
// (name) / (name type) with type in {byte, word, dword, qword}.
// The ':' in (name : type) is invisible punctuation to the reader.
func parseStructField(f Node) (string, int, error) {
	typeSizes := map[string]int{"byte": 1, "word": 2, "dword": 4, "qword": 8}
	if name := AtomName(f); name != "" {
		return name, 8, nil
	}
	items := ListItems(f)
	if items == nil || len(items) == 0 || len(items) > 2 {
		return "", 0, fmt.Errorf("struct field must be a symbol or (name [type])")
	}
	name := AtomName(items[0])
	if name == "" {
		return "", 0, fmt.Errorf("struct field name must be a symbol")
	}
	size := 8
	if len(items) == 2 {
		t := AtomName(items[1])
		var ok bool
		size, ok = typeSizes[t]
		if !ok {
			return "", 0, fmt.Errorf("unknown struct field type %q (want byte|word|dword|qword)", t)
		}
	}
	return name, size, nil
}

func (c *Compiler) register(name string, si *symInfo) error {
	if isReservedName(name) {
		return fmt.Errorf("%s is a reserved rasm name (register alias); pick another name", name)
	}
	if _, dup := c.syms[name]; dup {
		return fmt.Errorf("duplicate definition of %s", name)
	}
	c.syms[name] = si
	c.order = append(c.order, name)
	return nil
}

// isReservedName reports whether name collides with a rasm register alias.
// Defining such a name would break assembly, since the preprocessor expands
// e.g. `counter` to `rcx` everywhere it appears.
func isReservedName(name string) bool {
	base := []string{
		"accumulator", "base", "counter", "data",
		"source_index", "destination_index",
		"base_pointer", "stack_pointer",
	}
	for _, b := range base {
		for _, suf := range []string{"", "_64", "_32", "_16", "_8", "_8_high"} {
			if name == b+suf {
				return true
			}
		}
	}
	for i := 8; i <= 15; i++ {
		if name == fmt.Sprintf("register_r%d", i) {
			return true
		}
	}
	for _, p := range []string{"xmm_", "ymm_", "zmm_", "segment_", "control_", "debug_"} {
		if strings.HasPrefix(name, p) {
			return true
		}
	}
	return false
}

// ============================================================================
// Pass 2: emit the program
// ============================================================================

// Compile translates top-level forms into a single rasm source string.
func (c *Compiler) Compile(forms []Node) (string, error) {
	for _, f := range forms {
		if err := c.registerTop(f); err != nil {
			return "", err
		}
	}
	c.logf("registered %d top-level names", len(c.order))

	c.emitHeader()
	c.emitStructs()
	c.emitData()
	if err := c.emitText(); err != nil {
		return "", err
	}
	c.logf("emitted %d lines", len(c.em.lines))
	return c.em.String(), nil
}

func (c *Compiler) emitHeader() {
	c.em.emit("; ============================================================================")
	c.em.emit("; Generated by rasl - a minimal Lisp that compiles to Readable Assembly")
	c.em.emit("; Assemble from the repo root so the %include resolves:")
	c.em.emit(";   nasm -f win64 out.asm -o out.o && gcc out.o -o out.exe   (Windows)")
	c.em.emit(";   nasm -f elf64 out.asm -o out.o && ld out.o -o out       (Linux)")
	c.em.emit("; ============================================================================")
	c.em.emit("%include \"readable_macros.nasm\"")
	c.em.emit("default rel")
	c.em.emit("")
}

func (c *Compiler) emitStructs() {
	for _, name := range c.order {
		si := c.syms[name]
		if si.kind != kindStruct {
			continue
		}
		c.em.emitf("; ----------------------------------------------------------------------------")
		c.em.emitf("; struct %s", name)
		c.em.emitf("begin_struct %s", name)
		// C-style layout: fields in declaration order, each aligned to its
		// size; explicit padding fills the gaps (the rasm struct macros do
		// not align on their own).
		offset := 0
		padN := 0
		for _, fld := range si.fieldOrder {
			size := si.fields[fld].size
			aligned := (offset + size - 1) / size * size
			if gap := aligned - offset; gap > 0 {
				c.em.emitf("    struct_field pad%d, %d", padN, gap)
				padN++
			}
			c.em.emitf("    struct_%s %s", structMacroSuffix(size), fld)
			offset = aligned + size
		}
		c.em.emitf("end_struct")
		c.em.emit("")
	}
}

func structMacroSuffix(size int) string {
	switch size {
	case 1:
		return "byte"
	case 2:
		return "word"
	case 4:
		return "dword"
	default:
		return "qword"
	}
}

// fieldLoad emits a zero-extended sized read of struct.field into
// accumulator_64 (the language's values are always 64-bit integers).
func (c *Compiler) fieldLoad(field string, size int) {
	switch size {
	case 1:
		c.em.emitf("    move_with_zero_extend_byte accumulator_64, [data_64 + %s]", field)
	case 2:
		c.em.emitf("    move_with_zero_extend_word accumulator_64, [data_64 + %s]", field)
	case 4:
		// no rasm macro for dword zero-extension; raw movzx always works
		c.em.emitf("    movzx accumulator_64, dword [data_64 + %s]   ; dword field", field)
	default:
		c.em.emitf("    move accumulator_64, [data_64 + %s]", field)
	}
}

// fieldStore emits a sized store of accumulator's low bits into struct.field.
func (c *Compiler) fieldStore(field string, size int) {
	switch size {
	case 1:
		c.em.emitf("    move_byte [data_64 + %s], accumulator_8", field)
	case 2:
		c.em.emitf("    move_word [data_64 + %s], accumulator_16", field)
	case 4:
		c.em.emitf("    move_dword [data_64 + %s], accumulator_32", field)
	default:
		c.em.emitf("    move [data_64 + %s], accumulator_64", field)
	}
}

func (c *Compiler) emitData() {
	hasData := false
	for _, name := range c.order {
		if c.syms[name].kind == kindScalar {
			if !hasData {
				c.em.emit("section .data")
				hasData = true
			}
			c.em.emitf("    %s: define_qword 0", name)
		}
	}
	hasBss := false
	for _, name := range c.order {
		if c.syms[name].kind == kindArray {
			if !hasBss {
				c.em.emit("section .bss")
				hasBss = true
			}
			c.em.emitf("    %s: reserve_qword %d", name, c.syms[name].count)
		}
	}
	if !hasBss {
		c.em.emit("section .bss")
	}
	c.em.emit("    rasl_buf: reserve_byte 32")
	c.em.emit("")
}

func (c *Compiler) emitText() error {
	c.em.emit("section .text")

	// Functions in declaration order.
	for _, name := range c.order {
		si := c.syms[name]
		if si.kind != kindFunc {
			continue
		}
		form := c.funcForm(name)
		if err := c.emitFunction(name, form); err != nil {
			return err
		}
	}

	// Startup initializer.
	if err := c.emitInit(); err != nil {
		return err
	}

	// Default entry if the user did not define (define (main) ...).
	if !c.userMain {
		c.em.emit("; default entry: return 0")
		c.em.emit("rasl_main:")
		c.em.emit("    move accumulator_64, 0")
		c.em.emit("    return_from_procedure")
		c.em.emit("")
	}

	c.em.emit(runtimeSource)
	return nil
}

// funcForm returns the original (define (name args...) body...) form.
func (c *Compiler) funcForm(name string) Node {
	return c.funcForms[name]
}

func (c *Compiler) emitFunction(name string, form Node) error {
	items := ListItems(form)
	inner := ListItems(items[1])
	args := make([]string, 0, len(inner)-1)
	for _, a := range inner[1:] {
		if AtomName(a) == "" {
			return fmt.Errorf("function %s argument must be a symbol", name)
		}
		args = append(args, AtomName(a))
	}
	body := items[2:]

	c.em.emitf("; ----------------------------------------------------------------------------")
	c.em.emitf("; (define (%s %s) ...)", name, strings.Join(args, " "))
	c.em.emitf("%s:", c.funcLabel(name))
	c.em.emit("    push_onto_stack base_pointer")
	c.em.emit("    move base_pointer, stack_pointer")

	locals := map[string]string{}
	for i, a := range args {
		locals[a] = fmt.Sprintf("[base_pointer + %d]", 16+8*i)
	}
	for _, b := range body {
		if err := c.compileExpr(b, locals); err != nil {
			return fmt.Errorf("in function %s: %w", name, err)
		}
	}
	c.em.emit("    move stack_pointer, base_pointer")
	c.em.emit("    pop_from_stack base_pointer")
	c.em.emit("    return_from_procedure")
	c.em.emit("")
	return nil
}

func (c *Compiler) emitInit() error {
	c.em.emit("; ----------------------------------------------------------------------------")
	c.em.emit("; global initializers (run once at startup)")
	c.em.emit("rasl_init:")
	c.em.emit("    push_onto_stack base_pointer")
	c.em.emit("    move base_pointer, stack_pointer")
	for _, f := range c.inits {
		items := ListItems(f)
		if head := AtomName(items[0]); head == "define" && ListItems(items[1]) == nil {
			name := AtomName(items[1])
			if err := c.compileExpr(items[2], nil); err != nil {
				return fmt.Errorf("in initializer of %s: %w", name, err)
			}
			c.em.emitf("    move [%s], accumulator_64", name)
		} else {
			if err := c.compileExpr(f, nil); err != nil {
				return err
			}
		}
	}
	c.em.emit("    move stack_pointer, base_pointer")
	c.em.emit("    pop_from_stack base_pointer")
	c.em.emit("    return_from_procedure")
	c.em.emit("")
	return nil
}

// ============================================================================
// Expression compilation
// ============================================================================

func (c *Compiler) compileExpr(n Node, locals map[string]string) error {
	switch v := n.(type) {
	case Num:
		c.em.emitf("    move accumulator_64, %d", v.Val)
		return nil
	case Sym:
		return c.compileSym(v.Name, locals)
	case Mem:
		return fmt.Errorf("memory operand %s is only valid inside (asm ...)", v.Text)
	case List:
		return c.compileList(v, locals)
	default:
		return fmt.Errorf("cannot compile %s", NodeString(n))
	}
}

func (c *Compiler) compileSym(name string, locals map[string]string) error {
	if off, ok := locals[name]; ok {
		c.em.emitf("    move accumulator_64, %s", off)
		return nil
	}
	si, ok := c.syms[name]
	if !ok {
		return fmt.Errorf("undefined symbol %s", name)
	}
	switch si.kind {
	case kindScalar:
		c.em.emitf("    move accumulator_64, [%s]", name)
	case kindArray:
		// An array name evaluates to its base address.
		c.em.emitf("    load_effective_address accumulator_64, [%s]", name)
	default:
		return fmt.Errorf("%s is not a value (it is a %s)", name, kindName(si.kind))
	}
	return nil
}

func kindName(k symKind) string {
	switch k {
	case kindScalar:
		return "global"
	case kindArray:
		return "array"
	case kindStruct:
		return "struct"
	case kindFunc:
		return "function"
	}
	return "?"
}

func (c *Compiler) compileList(l List, locals map[string]string) error {
	items := l.Items
	if len(items) == 0 {
		return fmt.Errorf("empty list is not a valid expression")
	}
	head := AtomName(items[0])
	if head == "" {
		return fmt.Errorf("first element of a form must be a symbol: %s", NodeString(l))
	}

	need := func(n int) error {
		if len(items) != n+1 {
			return fmt.Errorf("%s expects %d argument(s), got %d", head, n, len(items)-1)
		}
		return nil
	}

	switch head {
	case "if":
		if err := need(3); err != nil {
			return err
		}
		lab := c.newLabel("if")
		if err := c.compileExpr(items[1], locals); err != nil {
			return err
		}
		c.em.emit("    compare accumulator_64, 0")
		c.em.emitf("    jump_if_equal .%s_else", lab)
		if err := c.compileExpr(items[2], locals); err != nil {
			return err
		}
		c.em.emitf("    jump .%s_end", lab)
		c.em.emitf(".%s_else:", lab)
		if err := c.compileExpr(items[3], locals); err != nil {
			return err
		}
		c.em.emitf(".%s_end:", lab)
		return nil

	case "cond":
		lab := c.newLabel("cond")
		clauses := items[1:]
		if len(clauses) == 0 {
			return fmt.Errorf("cond needs at least one clause")
		}
		for i, cl := range clauses {
			ci := ListItems(cl)
			if ci == nil || len(ci) != 2 {
				return fmt.Errorf("cond clause must be (test result), got %s", NodeString(cl))
			}
			if AtomName(ci[0]) == "else" {
				if err := c.compileExpr(ci[1], locals); err != nil {
					return err
				}
				c.em.emitf("    jump .%s_end", lab)
				break
			}
			if err := c.compileExpr(ci[0], locals); err != nil {
				return err
			}
			c.em.emit("    compare accumulator_64, 0")
			c.em.emitf("    jump_if_equal .%s_next%d", lab, i)
			if err := c.compileExpr(ci[1], locals); err != nil {
				return err
			}
			c.em.emitf("    jump .%s_end", lab)
			c.em.emitf(".%s_next%d:", lab, i)
		}
		c.em.emitf(".%s_end:", lab)
		return nil

	case "while":
		if len(items) < 2 {
			return fmt.Errorf("while needs a test expression")
		}
		lab := c.newLabel("while")
		c.em.emitf(".%s_start:", lab)
		if err := c.compileExpr(items[1], locals); err != nil {
			return err
		}
		c.em.emit("    compare accumulator_64, 0")
		c.em.emitf("    jump_if_equal .%s_end", lab)
		for _, b := range items[2:] {
			if err := c.compileExpr(b, locals); err != nil {
				return err
			}
		}
		c.em.emitf("    jump .%s_start", lab)
		c.em.emitf(".%s_end:", lab)
		return nil

	case "begin":
		for _, b := range items[1:] {
			if err := c.compileExpr(b, locals); err != nil {
				return err
			}
		}
		return nil

	case "set!":
		if err := need(2); err != nil {
			return err
		}
		target, err := c.resolveStoreTarget(AtomName(items[1]), locals)
		if err != nil {
			return err
		}
		if err := c.compileExpr(items[2], locals); err != nil {
			return err
		}
		c.em.emitf("    move %s, accumulator_64", target)
		return nil

	case "asm":
		for _, st := range items[1:] {
			if err := c.emitAsmStmt(st); err != nil {
				return err
			}
		}
		return nil

	case "label":
		if err := need(1); err != nil {
			return err
		}
		c.em.emitf("%s:", AtomName(items[1]))
		return nil

	case "goto":
		if err := need(1); err != nil {
			return err
		}
		c.em.emitf("    jump %s", AtomName(items[1]))
		return nil

	case "print":
		if err := need(1); err != nil {
			return err
		}
		if err := c.compileExpr(items[1], locals); err != nil {
			return err
		}
		c.em.emit("    call_procedure rasl_print")
		return nil

	case "exit":
		if err := need(1); err != nil {
			return err
		}
		if err := c.compileExpr(items[1], locals); err != nil {
			return err
		}
		c.emitExit()
		return nil

	case "+", "-", "*", "/":
		return c.compileArith(head, items, locals)

	case "<", ">", "=":
		return c.compileCompare(head, items, locals)

	case "zero?":
		if err := need(1); err != nil {
			return err
		}
		if err := c.compileExpr(items[1], locals); err != nil {
			return err
		}
		c.em.emit("    compare accumulator_64, 0")
		c.em.emit("    move accumulator_64, 0")
		c.em.emit("    set_if_equal accumulator_8")
		return nil

	case "array-get":
		return c.compileArrayGet(items, locals)
	case "array-set":
		return c.compileArraySet(items, locals)
	case "struct-get":
		return c.compileStructGet(items, locals)
	case "struct-set":
		return c.compileStructSet(items, locals)

	case "define", "global", "define-array", "define-struct":
		return fmt.Errorf("%s is only allowed at top level", head)

	default:
		return c.compileCall(head, items[1:], locals)
	}
}

func (c *Compiler) resolveStoreTarget(name string, locals map[string]string) (string, error) {
	if off, ok := locals[name]; ok {
		return off, nil
	}
	si, ok := c.syms[name]
	if !ok {
		return "", fmt.Errorf("set!: undefined symbol %s", name)
	}
	if si.kind != kindScalar {
		return "", fmt.Errorf("set!: %s is not a scalar global", name)
	}
	return "[" + name + "]", nil
}

// emitAsmStmt renders one rasm statement inside (asm ...).
func (c *Compiler) emitAsmStmt(st Node) error {
	switch v := st.(type) {
	case Sym:
		c.em.emitf("    %s", v.Name)
		return nil
	case List:
		if len(v.Items) == 0 {
			return fmt.Errorf("empty asm statement")
		}
		op := AtomName(v.Items[0])
		if op == "" {
			return fmt.Errorf("asm statement must start with a rasm instruction name")
		}
		parts := []string{op}
		for _, a := range v.Items[1:] {
			parts = append(parts, asmOperand(a))
		}
		c.em.emitf("    %s", strings.Join(parts, ", "))
		return nil
	default:
		return fmt.Errorf("asm statement must be a rasm instruction, got %s", NodeString(st))
	}
}

func asmOperand(n Node) string {
	switch v := n.(type) {
	case Num:
		return strconv.FormatInt(v.Val, 10)
	case Sym:
		return v.Name
	case Mem:
		return v.Text
	default:
		return NodeString(n)
	}
}

// emitExit terminates the process with the status currently in accumulator_64.
// The runtime's rasl_exit handles the platform-specific termination.
func (c *Compiler) emitExit() {
	c.em.emit("; exit with status in accumulator_64")
	c.em.emit("    jump rasl_exit")
}

func (c *Compiler) compileArith(op string, items []Node, locals map[string]string) error {
	args := items[1:]
	if len(args) == 0 {
		return fmt.Errorf("%s needs at least one argument", op)
	}
	switch op {
	case "+":
		if err := c.compileExpr(args[0], locals); err != nil {
			return err
		}
		for _, a := range args[1:] {
			c.em.emit("    push_onto_stack accumulator_64")
			if err := c.compileExpr(a, locals); err != nil {
				return err
			}
			c.em.emit("    pop_from_stack data_64")
			c.em.emit("    add accumulator_64, data_64")
		}
		return nil
	case "-":
		if len(args) == 1 {
			if err := c.compileExpr(args[0], locals); err != nil {
				return err
			}
			c.em.emit("    negate accumulator_64")
			return nil
		}
		if err := c.compileExpr(args[0], locals); err != nil {
			return err
		}
		for _, a := range args[1:] {
			c.em.emit("    push_onto_stack accumulator_64")
			if err := c.compileExpr(a, locals); err != nil {
				return err
			}
			c.em.emit("    pop_from_stack data_64")
			c.em.emit("    subtract data_64, accumulator_64")
			c.em.emit("    move accumulator_64, data_64")
		}
		return nil
	case "*":
		if err := c.compileExpr(args[0], locals); err != nil {
			return err
		}
		for _, a := range args[1:] {
			c.em.emit("    push_onto_stack accumulator_64")
			if err := c.compileExpr(a, locals); err != nil {
				return err
			}
			c.em.emit("    pop_from_stack data_64")
			c.em.emit("    signed_multiply data_64")
		}
		return nil
	case "/":
		if len(args) != 2 {
			return fmt.Errorf("/ expects exactly 2 arguments")
		}
		// unsigned division: a / b
		if err := c.compileExpr(args[0], locals); err != nil {
			return err
		}
		c.em.emit("    push_onto_stack accumulator_64")
		if err := c.compileExpr(args[1], locals); err != nil {
			return err
		}
		c.em.emit("    move counter_64, accumulator_64      ; divisor")
		c.em.emit("    pop_from_stack accumulator_64        ; dividend")
		c.em.emit("    move data_64, 0                      ; zero high half (unsigned)")
		c.em.emit("    divide counter_64")
		return nil
	}
	return fmt.Errorf("unknown arithmetic operator %s", op)
}

func (c *Compiler) compileCompare(op string, items []Node, locals map[string]string) error {
	if len(items) != 3 {
		return fmt.Errorf("%s expects exactly 2 arguments", op)
	}
	setcc := map[string]string{
		"<": "set_if_less",
		">": "set_if_greater",
		"=": "set_if_equal",
	}[op]
	if err := c.compileExpr(items[1], locals); err != nil {
		return err
	}
	c.em.emit("    push_onto_stack accumulator_64")
	if err := c.compileExpr(items[2], locals); err != nil {
		return err
	}
	c.em.emit("    pop_from_stack data_64")
	c.em.emit("    compare data_64, accumulator_64")
	c.em.emit("    move accumulator_64, 0")
	c.em.emitf("    %s accumulator_8", setcc)
	return nil
}

func (c *Compiler) compileCall(fname string, args []Node, locals map[string]string) error {
	if _, ok := c.syms[fname]; !ok {
		return fmt.Errorf("undefined function %s", fname)
	}
	if c.syms[fname].kind != kindFunc {
		return fmt.Errorf("%s is not a function", fname)
	}
	for _, a := range args {
		if err := c.compileExpr(a, locals); err != nil {
			return err
		}
		c.em.emit("    push_onto_stack accumulator_64")
	}
	c.em.emitf("    call_procedure %s", c.funcLabel(fname))
	if n := len(args); n > 0 {
		c.em.emitf("    add stack_pointer, %d        ; pop %d argument(s)", 8*n, n)
	}
	return nil
}

func (c *Compiler) compileArrayGet(items []Node, locals map[string]string) error {
	if len(items) != 3 {
		return fmt.Errorf("array-get expects (array-get array index)")
	}
	name := AtomName(items[1])
	si, ok := c.syms[name]
	if !ok || si.kind != kindArray {
		return fmt.Errorf("array-get: %s is not an array", name)
	}
	if err := c.compileExpr(items[2], locals); err != nil {
		return err
	}
	c.em.emit("    move data_64, accumulator_64             ; index")
	// Load the base address into a register: a symbol + index displacement
	// would need a 32-bit absolute relocation, which win64 rejects.
	c.em.emitf("    load_effective_address counter_64, [%s]  ; base address", name)
	c.em.emit("    move accumulator_64, [counter_64 + data_64*8]")
	return nil
}

func (c *Compiler) compileArraySet(items []Node, locals map[string]string) error {
	if len(items) != 4 {
		return fmt.Errorf("array-set expects (array-set array index value)")
	}
	name := AtomName(items[1])
	si, ok := c.syms[name]
	if !ok || si.kind != kindArray {
		return fmt.Errorf("array-set: %s is not an array", name)
	}
	if err := c.compileExpr(items[3], locals); err != nil {
		return err
	}
	c.em.emit("    push_onto_stack accumulator_64           ; value")
	if err := c.compileExpr(items[2], locals); err != nil {
		return err
	}
	c.em.emit("    move data_64, accumulator_64             ; index")
	c.em.emit("    pop_from_stack accumulator_64")
	c.em.emitf("    load_effective_address counter_64, [%s]  ; base address", name)
	c.em.emit("    move [counter_64 + data_64*8], accumulator_64")
	return nil
}

func (c *Compiler) compileStructGet(items []Node, locals map[string]string) error {
	if len(items) != 3 {
		return fmt.Errorf("struct-get expects (struct-get address struct.field)")
	}
	field, size, err := c.checkField(items[2])
	if err != nil {
		return fmt.Errorf("struct-get: %w", err)
	}
	if err := c.compileExpr(items[1], locals); err != nil {
		return err
	}
	c.em.emit("    move data_64, accumulator_64             ; address")
	c.fieldLoad(field, size)
	return nil
}

func (c *Compiler) compileStructSet(items []Node, locals map[string]string) error {
	if len(items) != 4 {
		return fmt.Errorf("struct-set expects (struct-set address struct.field value)")
	}
	field, size, err := c.checkField(items[2])
	if err != nil {
		return fmt.Errorf("struct-set: %w", err)
	}
	if err := c.compileExpr(items[3], locals); err != nil {
		return err
	}
	c.em.emit("    push_onto_stack accumulator_64           ; value")
	if err := c.compileExpr(items[1], locals); err != nil {
		return err
	}
	c.em.emit("    move data_64, accumulator_64             ; address")
	c.em.emit("    pop_from_stack accumulator_64")
	c.fieldStore(field, size)
	return nil
}

// checkField validates a "struct.field" symbol against the symbol table and
// returns the canonical spelling and the field size.
func (c *Compiler) checkField(n Node) (string, int, error) {
	name := AtomName(n)
	if name == "" {
		return "", 0, fmt.Errorf("field must be a struct.field symbol, got %s", NodeString(n))
	}
	dot := strings.IndexByte(name, '.')
	if dot <= 0 || dot == len(name)-1 {
		return "", 0, fmt.Errorf("field must be struct.field, got %s", name)
	}
	sn, fn := name[:dot], name[dot+1:]
	si, ok := c.syms[sn]
	if !ok || si.kind != kindStruct {
		return "", 0, fmt.Errorf("unknown struct %s", sn)
	}
	info, ok := si.fields[fn]
	if !ok {
		return "", 0, fmt.Errorf("struct %s has no field %s", sn, fn)
	}
	return name, info.size, nil
}

func (c *Compiler) newLabel(prefix string) string {
	lab := fmt.Sprintf("%s_%d", prefix, c.labelN)
	c.labelN++
	return lab
}

// funcLabel returns the emitted label for a function. The user's (define
// (main) ...) is emitted as rasl_main so it does not collide with the
// platform entry label `main` emitted by the runtime wrapper.
func (c *Compiler) funcLabel(name string) string {
	if name == "main" {
		return "rasl_main"
	}
	return name
}
