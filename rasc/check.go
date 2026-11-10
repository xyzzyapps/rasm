package main

import "fmt"

type sym struct {
	name   string
	typ    *Type
	kind   string // "func", "global", "param", "local"
	offset int    // params: +16+8*i, locals: negative
	index  int
}

type checker struct {
	funcs   map[string]*Func
	globals map[string]*sym
	scope   []map[string]*sym
	fn      *Func
}

func check(p *Program) error {
	c := &checker{
		funcs:   map[string]*Func{},
		globals: map[string]*sym{},
		scope:   []map[string]*sym{{}},
	}
	for _, d := range p.Decls {
		switch d := d.(type) {
		case *Func:
			if _, ok := c.funcs[d.Name]; ok {
				return fmt.Errorf("line %d: %s is already defined", d.Line, d.Name)
			}
			if _, ok := c.globals[d.Name]; ok {
				return fmt.Errorf("line %d: %s is already defined", d.Line, d.Name)
			}
			c.funcs[d.Name] = d
		case *Global:
			if _, ok := c.globals[d.Name]; ok || c.funcs[d.Name] != nil {
				return fmt.Errorf("line %d: %s is already defined", d.Line, d.Name)
			}
			if d.Type.kind == tyVoid {
				return fmt.Errorf("line %d: a global cannot have type void", d.Line)
			}
			c.globals[d.Name] = &sym{name: d.Name, typ: d.Type, kind: "global"}
		}
	}
	mainFn, ok := c.funcs["main"]
	if !ok {
		return fmt.Errorf("missing int64 main()")
	}
	if !mainFn.Ret.equal(&Type{kind: tyInt64}) || len(mainFn.Params) != 0 {
		return fmt.Errorf("main must be int64 main() with no parameters")
	}
	for _, d := range p.Decls {
		g, ok := d.(*Global)
		if !ok || g.Init == nil {
			continue
		}
		got, err := c.exprType(g.Init)
		if err != nil {
			return err
		}
		if !got.equal(g.Type) {
			return fmt.Errorf("line %d: %s needs %s, the initializer is %s", g.Line, g.Name, g.Type, got)
		}
	}
	for _, fn := range c.funcs {
		if err := c.checkFunc(fn); err != nil {
			return err
		}
	}
	return nil
}

func (c *checker) checkFunc(fn *Func) error {
	c.fn = fn
	c.scope = append(c.scope, map[string]*sym{})
	defer func() { c.scope = c.scope[:len(c.scope)-1] }()
	for i, p := range fn.Params {
		if p.Type.kind == tyVoid {
			return fmt.Errorf("line %d: parameter %s cannot have type void", p.Line, p.Name)
		}
		if err := c.bind(&sym{name: p.Name, typ: p.Type, kind: "param", index: i}); err != nil {
			return err
		}
	}
	return c.checkStmt(fn.Body, fn.Ret)
}

func (c *checker) bind(s *sym) error {
	top := c.scope[len(c.scope)-1]
	if _, ok := top[s.name]; ok {
		return fmt.Errorf("%s is already defined in this block", s.name)
	}
	top[s.name] = s
	return nil
}

func (c *checker) lookup(name string) *sym {
	for i := len(c.scope) - 1; i >= 0; i-- {
		if s, ok := c.scope[i][name]; ok {
			return s
		}
	}
	if s, ok := c.globals[name]; ok {
		return s
	}
	return nil
}

func (c *checker) checkStmt(s Stmt, ret *Type) error {
	switch s := s.(type) {
	case *Block:
		c.scope = append(c.scope, map[string]*sym{})
		defer func() { c.scope = c.scope[:len(c.scope)-1] }()
		for _, st := range s.Stmts {
			if err := c.checkStmt(st, ret); err != nil {
				return err
			}
		}
		return nil
	case *Var:
		if s.Type.kind == tyVoid {
			return fmt.Errorf("line %d: %s cannot have type void", s.Line, s.Name)
		}
		if s.Init != nil {
			got, err := c.exprType(s.Init)
			if err != nil {
				return err
			}
			if !got.equal(s.Type) {
				return fmt.Errorf("line %d: %s needs %s, the value is %s", s.Line, s.Name, s.Type, got)
			}
		}
		return c.bind(&sym{name: s.Name, typ: s.Type, kind: "local"})
	case *If:
		got, err := c.exprType(s.Cond)
		if err != nil {
			return err
		}
		if got.kind != tyBool {
			return fmt.Errorf("line %d: if needs a bool condition, got %s", s.Line, got)
		}
		if err := c.checkStmt(s.Then, ret); err != nil {
			return err
		}
		if s.Else != nil {
			return c.checkStmt(s.Else, ret)
		}
		return nil
	case *While:
		got, err := c.exprType(s.Cond)
		if err != nil {
			return err
		}
		if got.kind != tyBool {
			return fmt.Errorf("line %d: while needs a bool condition, got %s", s.Line, got)
		}
		return c.checkStmt(s.Body, ret)
	case *Return:
		if ret.kind == tyVoid {
			if s.Value != nil {
				return fmt.Errorf("line %d: void function returns no value", s.Line)
			}
			return nil
		}
		if s.Value == nil {
			return fmt.Errorf("line %d: return needs a %s value", s.Line, ret)
		}
		got, err := c.exprType(s.Value)
		if err != nil {
			return err
		}
		if !got.equal(ret) {
			return fmt.Errorf("line %d: return needs %s, the value is %s", s.Line, ret, got)
		}
		return nil
	case *Asm:
		return c.checkAsm(s.Body, s.Line)
	case *ExprStmt:
		_, err := c.exprType(s.X)
		return err
	default:
		return fmt.Errorf("unknown statement")
	}
}

func (c *checker) checkAsm(body string, line int) error {
	rest := body
	for {
		i := indexAsm(rest)
		if i < 0 {
			return nil
		}
		rest = rest[i+1:]
		j := 0
		for j < len(rest) && rest[j] != '}' {
			j++
		}
		if j >= len(rest) || j < 1 || rest[0] != '{' {
			return fmt.Errorf("line %d: asm reference must look like %%{name}", line)
		}
		name := rest[1:j]
		if c.lookup(name) == nil {
			return fmt.Errorf("line %d: asm names unknown value %s", line, name)
		}
		rest = rest[j+1:]
	}
}

func indexAsm(s string) int {
	for i := 0; i+1 < len(s); i++ {
		if s[i] == '%' && s[i+1] == '{' {
			return i
		}
	}
	return -1
}

func (c *checker) exprType(e Expr) (*Type, error) {
	switch e := e.(type) {
	case *Name:
		s := c.lookup(e.Text)
		if s == nil || s.kind == "func" {
			return nil, fmt.Errorf("line %d: unknown name %s", e.Line, e.Text)
		}
		return s.typ, nil
	case *Number:
		if _, err := parseNumber(e.Text); err != nil {
			return nil, fmt.Errorf("line %d: bad number %s", e.Line, e.Text)
		}
		return nil, fmt.Errorf("line %d: a number needs a typed context. Write int64(%s)", e.Line, e.Text)
	case *BoolLit:
		return &Type{kind: tyBool}, nil
	case *Cast:
		if _, err := c.exprType(e.X); err != nil {
			if num, ok := e.X.(*Number); ok {
				v, nerr := parseNumber(num.Text)
				if nerr != nil {
					return nil, fmt.Errorf("line %d: bad number", e.Line)
				}
				if !fits(e.Type, v) {
					return nil, fmt.Errorf("line %d: %s does not fit in %s", e.Line, num.Text, e.Type)
				}
				return e.Type, nil
			}
			return nil, err
		}
		src, err := c.exprType(e.X)
		if err != nil {
			return nil, err
		}
		if !canCast(src, e.Type) {
			return nil, fmt.Errorf("line %d: cannot cast %s to %s", e.Line, src, e.Type)
		}
		return e.Type, nil
	case *Unary:
		inner, err := c.exprType(e.X)
		if err != nil {
			return nil, err
		}
		switch e.Op {
		case "!":
			if inner.kind != tyBool {
				return nil, fmt.Errorf("line %d: ! needs a bool", e.Line)
			}
			return inner, nil
		case "-":
			if !inner.isInteger() {
				return nil, fmt.Errorf("line %d: - needs an integer", e.Line)
			}
			return inner, nil
		case "&":
			if !isLValue(e.X) {
				return nil, fmt.Errorf("line %d: & needs a variable", e.Line)
			}
			return &Type{kind: tyPtr, elem: inner}, nil
		case "*":
			if inner.kind != tyPtr {
				return nil, fmt.Errorf("line %d: * needs a pointer", e.Line)
			}
			return inner.elem, nil
		default:
			return nil, fmt.Errorf("line %d: bad operator %s", e.Line, e.Op)
		}
	case *Binary:
		return c.binaryType(e)
	case *Assign:
		if !isLValue(e.Dst) {
			return nil, fmt.Errorf("line %d: the left side cannot be assigned", e.Line)
		}
		dst, err := c.exprType(e.Dst)
		if err != nil {
			return nil, err
		}
		src, err := c.exprType(e.Src)
		if err != nil {
			return nil, err
		}
		if !dst.equal(src) {
			return nil, fmt.Errorf("line %d: cannot assign %s to %s", e.Line, src, dst)
		}
		return dst, nil
	case *Call:
		fn := c.funcs[e.Name]
		if fn == nil {
			return nil, fmt.Errorf("line %d: unknown function %s", e.Line, e.Name)
		}
		if len(e.Args) != len(fn.Params) {
			return nil, fmt.Errorf("line %d: %s needs %d arguments", e.Line, e.Name, len(fn.Params))
		}
		for i, a := range e.Args {
			got, err := c.exprType(a)
			if err != nil {
				return nil, err
			}
			if !got.equal(fn.Params[i].Type) {
				return nil, fmt.Errorf("line %d: argument %d of %s needs %s, got %s", e.Line, i+1, e.Name, fn.Params[i].Type, got)
			}
		}
		return fn.Ret, nil
	default:
		return nil, fmt.Errorf("unknown expression")
	}
}

func (c *checker) binaryType(e *Binary) (*Type, error) {
	lt, err := c.exprType(e.L)
	if err != nil {
		return nil, err
	}
	rt, err := c.exprType(e.R)
	if err != nil {
		return nil, err
	}
	switch e.Op {
	case "&&", "||":
		if lt.kind != tyBool || rt.kind != tyBool {
			return nil, fmt.Errorf("line %d: %s needs bool values", e.Line, e.Op)
		}
		return lt, nil
	case "==", "!=":
		if lt.equal(rt) && (lt.isInteger() || lt.kind == tyBool || lt.kind == tyPtr) {
			return &Type{kind: tyBool}, nil
		}
		return nil, fmt.Errorf("line %d: %s needs two values of the same type", e.Line, e.Op)
	case "<", "<=", ">", ">=":
		if lt.equal(rt) && lt.isInteger() {
			return &Type{kind: tyBool}, nil
		}
		return nil, fmt.Errorf("line %d: %s needs two integers of the same type", e.Line, e.Op)
	case "+", "-":
		if lt.kind == tyPtr && rt.equal(&Type{kind: tyInt64}) {
			return lt, nil
		}
		if e.Op == "+" && rt.kind == tyPtr && lt.equal(&Type{kind: tyInt64}) {
			return rt, nil
		}
		if e.Op == "-" && lt.kind == tyPtr && lt.equal(rt) {
			return &Type{kind: tyInt64}, nil
		}
		if lt.equal(rt) && lt.isInteger() {
			return lt, nil
		}
		return nil, fmt.Errorf("line %d: %s types %s and %s do not match", e.Line, e.Op, lt, rt)
	case "*", "/", "%":
		if lt.equal(rt) && lt.isInteger() {
			return lt, nil
		}
		return nil, fmt.Errorf("line %d: %s needs two integers of the same type", e.Line, e.Op)
	default:
		return nil, fmt.Errorf("line %d: bad operator %s", e.Line, e.Op)
	}
}

func isLValue(e Expr) bool {
	switch e := e.(type) {
	case *Name:
		return true
	case *Unary:
		return e.Op == "*"
	default:
		return false
	}
}

func canCast(src, dst *Type) bool {
	if src.equal(dst) {
		return true
	}
	if src.isInteger() && dst.isInteger() {
		return true
	}
	if src.kind == tyPtr && dst.kind == tyPtr {
		return true
	}
	if src.kind == tyPtr && (dst.kind == tyUint64 || dst.kind == tyInt64) {
		return true
	}
	if (src.kind == tyUint64 || src.kind == tyInt64) && dst.kind == tyPtr {
		return true
	}
	if src.kind == tyBool && dst.isInteger() {
		return true
	}
	return false
}

func fits(t *Type, v int64) bool {
	switch t.kind {
	case tyInt8:
		return v >= -128 && v <= 127
	case tyInt16:
		return v >= -32768 && v <= 32767
	case tyInt32:
		return v >= -2147483648 && v <= 2147483647
	case tyInt64:
		return true
	case tyUint8:
		return v >= 0 && v <= 255
	case tyUint16:
		return v >= 0 && v <= 65535
	case tyUint32:
		return v >= 0 && v <= 4294967295
	case tyUint64:
		return v >= 0
	case tyBool:
		return v == 0 || v == 1
	default:
		return false
	}
}
