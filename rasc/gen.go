package main

import (
	"fmt"
	"strings"
)

type place struct {
	sym *sym
}

type gen struct {
	p      *Program
	b      strings.Builder
	locals map[string]*sym
	label  int
}

func generate(p *Program) (string, error) {
	if err := check(p); err != nil {
		return "", err
	}
	g := &gen{p: p, locals: map[string]*sym{}}
	g.line("%include \"readable_macros.nasm\"")
	g.line("default rel")
	g.line("")
	g.line("section .data")
	for _, d := range p.Decls {
		gl, ok := d.(*Global)
		if !ok || gl.Init == nil {
			continue
		}
		g.emitGlobal(gl)
	}
	g.line("")
	g.line("section .bss")
	for _, d := range p.Decls {
		gl, ok := d.(*Global)
		if !ok || gl.Init != nil {
			continue
		}
		g.line(fmt.Sprintf("%s: reserve_quad_word 1", gl.Name))
	}
	g.line("")
	g.line("section .text")
	g.emitEntry()
	for _, d := range p.Decls {
		fn, ok := d.(*Func)
		if !ok {
			continue
		}
		if err := g.emitFunc(fn); err != nil {
			return "", err
		}
	}
	return g.b.String(), nil
}

func (g *gen) line(s string) { g.b.WriteString(s); g.b.WriteByte('\n') }

func (g *gen) emitGlobal(gl *Global) {
	switch n := gl.Init.(type) {
	case *Number:
		v, _ := parseNumber(n.Text)
		g.line(fmt.Sprintf("%s: define_quad_word %d", gl.Name, v))
	case *BoolLit:
		bit := 0
		if n.Value {
			bit = 1
		}
		g.line(fmt.Sprintf("%s: define_byte %d", gl.Name, bit))
	case *Cast:
		if num, ok := n.X.(*Number); ok {
			v, _ := parseNumber(num.Text)
			g.line(fmt.Sprintf("%s: define_quad_word %d", gl.Name, v))
			return
		}
		g.line(fmt.Sprintf("%s: define_quad_word 0", gl.Name))
	default:
		g.line(fmt.Sprintf("%s: define_quad_word 0", gl.Name))
	}
}

func (g *gen) emitEntry() {
	g.line("%ifidn __OUTPUT_FORMAT__, win64")
	g.line("    global main")
	g.line("main:")
	g.line("    subtract stack_pointer_64, 40")
	g.line("    call_procedure rasc_main")
	g.line("    add stack_pointer_64, 40")
	g.line("    return_from_procedure")
	g.line("%else")
	g.line("    global _start")
	g.line("_start:")
	g.line("    call_procedure rasc_main")
	g.line("    move destination_index_64, accumulator_64")
	g.line("    move accumulator_64, 60")
	g.line("    syscall_invoke")
	g.line("%endif")
	g.line("")
}

func (g *gen) emitFunc(fn *Func) error {
	g.locals = map[string]*sym{}
	off := 8
	var locals []*sym
	collectLocals(fn.Body, &locals)
	for _, s := range locals {
		s.offset = -off
		s.kind = "local"
		g.locals[s.name] = s
		off += 8
	}
	for i, p := range fn.Params {
		g.locals[p.Name] = &sym{
			name:   p.Name,
			typ:    p.Type,
			kind:   "param",
			offset: 16 + 8*i,
		}
	}
	name := fn.Name
	if name == "main" {
		name = "rasc_main"
	}
	frame := off - 8
	if frame < 0 {
		frame = 0
	}
	g.line(name + ":")
	g.line("    push_onto_stack base_pointer_64")
	g.line("    move base_pointer_64, stack_pointer_64")
	if frame > 0 {
		g.line(fmt.Sprintf("    subtract stack_pointer_64, %d", frame))
	}
	if err := g.stmt(fn.Body); err != nil {
		return err
	}
	g.epilogue(frame)
	g.line("")
	return nil
}

func collectLocals(s Stmt, out *[]*sym) {
	switch s := s.(type) {
	case *Block:
		for _, st := range s.Stmts {
			collectLocals(st, out)
		}
	case *Var:
		*out = append(*out, &sym{name: s.Name, typ: s.Type})
		if s.Init != nil {
			// initializer is not a nested statement
		}
	case *If:
		collectLocals(s.Then, out)
		if s.Else != nil {
			collectLocals(s.Else, out)
		}
	case *While:
		collectLocals(s.Body, out)
	}
}

func (g *gen) epilogue(frame int) {
	if frame > 0 {
		g.line("    move stack_pointer_64, base_pointer_64")
	}
	g.line("    pop_from_stack base_pointer_64")
	g.line("    return_from_procedure")
}

func (g *gen) stmt(s Stmt) error {
	switch s := s.(type) {
	case *Block:
		for _, st := range s.Stmts {
			if err := g.stmt(st); err != nil {
				return err
			}
		}
		return nil
	case *Var:
		if s.Init == nil {
			return nil
		}
		if err := g.expr(s.Init); err != nil {
			return err
		}
		g.store(g.locals[s.Name].typ, g.addr(g.locals[s.Name]))
		return nil
	case *If:
		elseL := g.fresh("else")
		endL := g.fresh("end_if")
		if err := g.expr(s.Cond); err != nil {
			return err
		}
		g.line("    compare accumulator_64, 0")
		g.line("    jump_if_equal " + elseL)
		if err := g.stmt(s.Then); err != nil {
			return err
		}
		if s.Else != nil {
			g.line("    jump " + endL)
		}
		g.line(elseL + ":")
		if s.Else != nil {
			if err := g.stmt(s.Else); err != nil {
				return err
			}
			g.line(endL + ":")
		}
		return nil
	case *While:
		head := g.fresh("while")
		done := g.fresh("end_while")
		g.line(head + ":")
		if err := g.expr(s.Cond); err != nil {
			return err
		}
		g.line("    compare accumulator_64, 0")
		g.line("    jump_if_equal " + done)
		if err := g.stmt(s.Body); err != nil {
			return err
		}
		g.line("    jump " + head)
		g.line(done + ":")
		return nil
	case *Return:
		if s.Value != nil {
			if err := g.expr(s.Value); err != nil {
				return err
			}
		}
		frame := 0
		if len(g.locals) > 0 {
			// frame size is the most negative offset
			for _, s := range g.locals {
				if s.kind == "local" && -s.offset > frame {
					frame = -s.offset
				}
			}
		}
		g.epilogue(frame)
		return nil
	case *Asm:
		for _, line := range strings.Split(s.Body, "\n") {
			g.line("    " + g.subst(line))
		}
		return nil
	case *ExprStmt:
		return g.expr(s.X)
	default:
		return fmt.Errorf("cannot generate statement")
	}
}

func (g *gen) fresh(kind string) string {
	g.label++
	return fmt.Sprintf(".rasc_%s_%d", kind, g.label)
}

func (g *gen) subst(line string) string {
	for {
		i := indexAsm(line)
		if i < 0 {
			return line
		}
		j := strings.IndexByte(line[i:], '}')
		if j < 0 {
			return line
		}
		j += i
		name := line[i+2 : j]
		rep := "0"
		if s := g.locals[name]; s != nil {
			rep = g.addr(s)
		} else {
			rep = "[" + name + "]"
		}
		line = line[:i] + rep + line[j+1:]
	}
}

func (g *gen) addr(s *sym) string {
	if s.kind == "global" || s.offset == 0 && s.kind == "" {
		return "[" + s.name + "]"
	}
	if s.offset < 0 {
		return fmt.Sprintf("[base_pointer_64 - %d]", -s.offset)
	}
	return fmt.Sprintf("[base_pointer_64 + %d]", s.offset)
}

func (g *gen) expr(e Expr) error {
	switch e := e.(type) {
	case *Number:
		v, _ := parseNumber(e.Text)
		g.line(fmt.Sprintf("    move accumulator_64, %d", v))
		return nil
	case *BoolLit:
		bit := 0
		if e.Value {
			bit = 1
		}
		g.line(fmt.Sprintf("    move accumulator_64, %d", bit))
		return nil
	case *Name:
		s := g.find(e.Text)
		return g.load(s.typ, g.addr(s))
	case *Cast:
		return g.expr(e.X)
	case *Unary:
		return g.unary(e)
	case *Binary:
		return g.binary(e)
	case *Assign:
		if err := g.expr(e.Src); err != nil {
			return err
		}
		return g.storeDst(e.Dst)
	case *Call:
		for i := len(e.Args) - 1; i >= 0; i-- {
			if err := g.expr(e.Args[i]); err != nil {
				return err
			}
			g.line("    push_onto_stack accumulator_64")
		}
		target := e.Name
		if target == "main" {
			target = "rasc_main"
		}
		g.line("    call_procedure " + target)
		if n := len(e.Args); n > 0 {
			g.line(fmt.Sprintf("    add stack_pointer_64, %d", 8*n))
		}
		return nil
	default:
		return fmt.Errorf("cannot generate expression")
	}
}

func (g *gen) find(name string) *sym {
	if s, ok := g.locals[name]; ok {
		return s
	}
	for _, d := range g.p.Decls {
		if gl, ok := d.(*Global); ok && gl.Name == name {
			return &sym{name: name, typ: gl.Type, kind: "global"}
		}
	}
	return nil
}

func (g *gen) unary(e *Unary) error {
	switch e.Op {
	case "!":
		if err := g.expr(e.X); err != nil {
			return err
		}
		g.line("    compare accumulator_64, 0")
		g.line("    set_if_equal accumulator_8")
		g.line("    move_with_zero_extend_byte accumulator_64, accumulator_8")
		return nil
	case "-":
		if err := g.expr(e.X); err != nil {
			return err
		}
		g.line("    negate accumulator_64")
		return nil
	case "&":
		n, ok := e.X.(*Name)
		if !ok {
			return fmt.Errorf("line %d: & is supported on a name", e.Line)
		}
		s := g.find(n.Text)
		if s.kind == "global" {
			g.line("    load_effective_address accumulator_64, [" + s.name + "]")
			return nil
		}
		g.line("    load_effective_address accumulator_64, " + g.addr(s))
		return nil
	case "*":
		if err := g.expr(e.X); err != nil {
			return err
		}
		g.line("    move base_64, accumulator_64")
		return g.load(g.typeOf(e.X).elem, "[base_64]")
	default:
		return fmt.Errorf("line %d: bad operator", e.Line)
	}
}

func (g *gen) binary(e *Binary) error {
	if e.Op == "&&" || e.Op == "||" {
		return g.logic(e)
	}
	if err := g.expr(e.R); err != nil {
		return err
	}
	g.line("    push_onto_stack accumulator_64")
	if err := g.expr(e.L); err != nil {
		return err
	}
	g.line("    pop_from_stack base_64")
	lt := g.typeOf(e.L)
	rt := g.typeOf(e.R)
	switch e.Op {
	case "+":
		g.scalePtr(lt, rt, true)
		g.line("    add accumulator_64, base_64")
	case "-":
		g.scalePtr(lt, rt, false)
		g.line("    subtract accumulator_64, base_64")
	case "*":
		g.line("    signed_multiply_immediate accumulator_64, base_64")
	case "/", "%":
		if lt.isSigned() {
			g.line("    convert_quad_word_to_octa_word_pair")
			g.line("    signed_divide base_64")
		} else {
			g.line("    move data_64, 0")
			g.line("    divide base_64")
		}
		if e.Op == "%" {
			g.line("    move accumulator_64, data_64")
		}
	case "==":
		g.cmp("set_if_equal")
	case "!=":
		g.cmp("set_if_not_equal")
	case "<":
		g.cmp("set_if_less")
	case "<=":
		g.cmp("set_if_less_or_equal")
	case ">":
		g.cmp("set_if_greater")
	case ">=":
		g.cmp("set_if_greater_or_equal")
	default:
		return fmt.Errorf("line %d: bad operator %s", e.Line, e.Op)
	}
	return nil
}

func (g *gen) scalePtr(lt, rt *Type, add bool) {
	size := 1
	if lt != nil && lt.kind == tyPtr {
		size = lt.elem.bits() / 8
		if size > 1 {
			g.line(fmt.Sprintf("    signed_multiply_immediate base_64, %d", size))
		}
		return
	}
	if add && rt != nil && rt.kind == tyPtr {
		size = rt.elem.bits() / 8
		if size > 1 {
			g.line(fmt.Sprintf("    signed_multiply_immediate accumulator_64, %d", size))
		}
	}
}

func (g *gen) typeOf(e Expr) *Type {
	switch e := e.(type) {
	case *Name:
		if s := g.find(e.Text); s != nil {
			return s.typ
		}
	case *BoolLit:
		return &Type{kind: tyBool}
	case *Cast:
		return e.Type
	case *Unary:
		inner := g.typeOf(e.X)
		if e.Op == "&" {
			return &Type{kind: tyPtr, elem: inner}
		}
		if e.Op == "*" && inner != nil && inner.kind == tyPtr {
			return inner.elem
		}
		return inner
	case *Binary:
		switch e.Op {
		case "==", "!=", "<", "<=", ">", ">=", "&&", "||":
			return &Type{kind: tyBool}
		}
		lt := g.typeOf(e.L)
		rt := g.typeOf(e.R)
		if lt != nil && lt.kind == tyPtr && rt != nil && rt.kind == tyInt64 {
			return lt
		}
		if e.Op == "+" && rt != nil && rt.kind == tyPtr {
			return rt
		}
		if e.Op == "-" && lt != nil && lt.kind == tyPtr && rt != nil && rt.kind == tyPtr {
			return &Type{kind: tyInt64}
		}
		return lt
	case *Assign:
		return g.typeOf(e.Dst)
	case *Call:
		for _, d := range g.p.Decls {
			if fn, ok := d.(*Func); ok && fn.Name == e.Name {
				return fn.Ret
			}
		}
	}
	return &Type{kind: tyInt64}
}

func (g *gen) cmp(set string) {
	g.line("    compare accumulator_64, base_64")
	g.line("    " + set + " accumulator_8")
	g.line("    move_with_zero_extend_byte accumulator_64, accumulator_8")
}

func (g *gen) logic(e *Binary) error {
	end := g.fresh("logic")
	if err := g.expr(e.L); err != nil {
		return err
	}
	g.line("    compare accumulator_64, 0")
	if e.Op == "&&" {
		g.line("    jump_if_equal " + end)
	} else {
		g.line("    jump_if_not_equal " + end)
	}
	if err := g.expr(e.R); err != nil {
		return err
	}
	g.line(end + ":")
	return nil
}

func (g *gen) storeDst(dst Expr) error {
	switch d := dst.(type) {
	case *Name:
		s := g.find(d.Text)
		g.store(s.typ, g.addr(s))
		return nil
	case *Unary:
		if d.Op != "*" {
			return fmt.Errorf("line %d: cannot store", d.Line)
		}
		g.line("    push_onto_stack accumulator_64")
		if err := g.expr(d.X); err != nil {
			return err
		}
		g.line("    move base_64, accumulator_64")
		g.line("    pop_from_stack accumulator_64")
		g.store(g.typeOf(d.X).elem, "[base_64]")
		return nil
	default:
		return fmt.Errorf("cannot store")
	}
}

func (g *gen) load(t *Type, addr string) error {
	switch t.bits() {
	case 8:
		if t.isSigned() {
			g.line("    move_with_sign_extend_byte accumulator_64, " + addr)
		} else {
			g.line("    move_with_zero_extend_byte accumulator_64, " + addr)
		}
	case 16:
		if t.isSigned() {
			g.line("    move_with_sign_extend_word accumulator_64, " + addr)
		} else {
			g.line("    move_with_zero_extend_word accumulator_64, " + addr)
		}
	case 32:
		if t.isSigned() {
			g.line("    move_with_sign_extend_double_word accumulator_64, " + addr)
		} else {
			// A 32-bit move into a register clears the upper half.
			g.line("    move accumulator_32, " + addr)
		}
	default:
		g.line("    move accumulator_64, " + addr)
	}
	return nil
}

func (g *gen) store(t *Type, addr string) {
	switch t.bits() {
	case 8:
		g.line("    move_byte " + addr + ", accumulator_8")
	case 16:
		g.line("    move_word " + addr + ", accumulator_16")
	case 32:
		g.line("    move_double_word " + addr + ", accumulator_32")
	default:
		g.line("    move " + addr + ", accumulator_64")
	}
}
