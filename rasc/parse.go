package main

import (
	"fmt"
	"strconv"
)

type parser struct {
	lx   *lexer
	cur  token
	peek token
	err  error
}

func parse(src string) (*Program, error) {
	p := &parser{lx: newLexer(src)}
	if err := p.advance(); err != nil {
		return nil, err
	}
	if err := p.advance(); err != nil {
		return nil, err
	}
	prog := &Program{}
	for p.cur.kind != tokEOF {
		d, err := p.decl()
		if err != nil {
			return nil, err
		}
		prog.Decls = append(prog.Decls, d)
	}
	return prog, nil
}

func (p *parser) advance() error {
	p.cur = p.peek
	tok, err := p.lx.next()
	if err != nil {
		return err
	}
	p.peek = tok
	return nil
}

func (p *parser) want(k tokenKind, what string) error {
	if p.cur.kind != k {
		return fmt.Errorf("line %d: expected %s", p.cur.line, what)
	}
	return p.advance()
}

func (p *parser) decl() (Decl, error) {
	line := p.cur.line
	ty, err := p.parseType()
	if err != nil {
		return nil, err
	}
	if p.cur.kind != tokIdent {
		return nil, fmt.Errorf("line %d: expected a name", p.cur.line)
	}
	name := p.cur.text
	if err := p.advance(); err != nil {
		return nil, err
	}
	if p.cur.kind == tokLParen {
		return p.function(line, name, ty)
	}
	g := &Global{Name: name, Type: ty, Line: line}
	if p.cur.kind == tokAssign {
		if err := p.advance(); err != nil {
			return nil, err
		}
		g.Init, err = p.expr()
		if err != nil {
			return nil, err
		}
	}
	if err := p.want(tokSemi, ";"); err != nil {
		return nil, err
	}
	return g, nil
}

func (p *parser) function(line int, name string, ret *Type) (*Func, error) {
	if err := p.want(tokLParen, "("); err != nil {
		return nil, err
	}
	var params []Param
	if p.cur.kind != tokRParen {
		for {
			ty, err := p.parseType()
			if err != nil {
				return nil, err
			}
			if p.cur.kind != tokIdent {
				return nil, fmt.Errorf("line %d: expected a parameter name", p.cur.line)
			}
			params = append(params, Param{Name: p.cur.text, Type: ty, Line: p.cur.line})
			if err := p.advance(); err != nil {
				return nil, err
			}
			if p.cur.kind == tokComma {
				if err := p.advance(); err != nil {
					return nil, err
				}
				continue
			}
			break
		}
	}
	if err := p.want(tokRParen, ")"); err != nil {
		return nil, err
	}
	body, err := p.block()
	if err != nil {
		return nil, err
	}
	return &Func{Name: name, Ret: ret, Params: params, Body: body, Line: line}, nil
}

func (p *parser) parseType() (*Type, error) {
	if p.cur.kind != tokIdent {
		return nil, fmt.Errorf("line %d: expected a type", p.cur.line)
	}
	base, ok := namedType(p.cur.text)
	if !ok {
		return nil, fmt.Errorf("line %d: unknown type %s", p.cur.line, p.cur.text)
	}
	if err := p.advance(); err != nil {
		return nil, err
	}
	for p.cur.kind == tokStar {
		base = &Type{kind: tyPtr, elem: base}
		if err := p.advance(); err != nil {
			return nil, err
		}
	}
	return base, nil
}

func namedType(s string) (*Type, bool) {
	kinds := map[string]typeKind{
		"void": tyVoid, "bool": tyBool,
		"int8": tyInt8, "int16": tyInt16, "int32": tyInt32, "int64": tyInt64,
		"uint8": tyUint8, "uint16": tyUint16, "uint32": tyUint32, "uint64": tyUint64,
	}
	k, ok := kinds[s]
	if !ok {
		return nil, false
	}
	return &Type{kind: k}, true
}

func (p *parser) block() (*Block, error) {
	line := p.cur.line
	if err := p.want(tokLBrace, "{"); err != nil {
		return nil, err
	}
	b := &Block{Line: line}
	for p.cur.kind != tokRBrace && p.cur.kind != tokEOF {
		s, err := p.stmt()
		if err != nil {
			return nil, err
		}
		b.Stmts = append(b.Stmts, s)
	}
	if err := p.want(tokRBrace, "}"); err != nil {
		return nil, err
	}
	return b, nil
}

func (p *parser) stmt() (Stmt, error) {
	switch p.cur.kind {
	case tokLBrace:
		return p.block()
	case tokIdent:
		if p.cur.text == "if" {
			return p.ifStmt()
		}
		if p.cur.text == "while" {
			return p.whileStmt()
		}
		if p.cur.text == "return" {
			return p.returnStmt()
		}
		if p.cur.text == "asm" {
			return p.asmStmt()
		}
		if _, ok := namedType(p.cur.text); ok {
			return p.varStmt()
		}
	}
	line := p.cur.line
	x, err := p.expr()
	if err != nil {
		return nil, err
	}
	if err := p.want(tokSemi, ";"); err != nil {
		return nil, err
	}
	return &ExprStmt{X: x, Line: line}, nil
}

func (p *parser) ifStmt() (Stmt, error) {
	line := p.cur.line
	if err := p.advance(); err != nil {
		return nil, err
	}
	if err := p.want(tokLParen, "("); err != nil {
		return nil, err
	}
	cond, err := p.expr()
	if err != nil {
		return nil, err
	}
	if err := p.want(tokRParen, ")"); err != nil {
		return nil, err
	}
	thenS, err := p.stmt()
	if err != nil {
		return nil, err
	}
	var elseS Stmt
	if p.cur.kind == tokIdent && p.cur.text == "else" {
		if err := p.advance(); err != nil {
			return nil, err
		}
		elseS, err = p.stmt()
		if err != nil {
			return nil, err
		}
	}
	return &If{Cond: cond, Then: thenS, Else: elseS, Line: line}, nil
}

func (p *parser) whileStmt() (Stmt, error) {
	line := p.cur.line
	if err := p.advance(); err != nil {
		return nil, err
	}
	if err := p.want(tokLParen, "("); err != nil {
		return nil, err
	}
	cond, err := p.expr()
	if err != nil {
		return nil, err
	}
	if err := p.want(tokRParen, ")"); err != nil {
		return nil, err
	}
	body, err := p.stmt()
	if err != nil {
		return nil, err
	}
	return &While{Cond: cond, Body: body, Line: line}, nil
}

func (p *parser) returnStmt() (Stmt, error) {
	line := p.cur.line
	if err := p.advance(); err != nil {
		return nil, err
	}
	var v Expr
	var err error
	if p.cur.kind != tokSemi {
		v, err = p.expr()
		if err != nil {
			return nil, err
		}
	}
	if err := p.want(tokSemi, ";"); err != nil {
		return nil, err
	}
	return &Return{Value: v, Line: line}, nil
}

func (p *parser) asmStmt() (Stmt, error) {
	line := p.cur.line
	if err := p.advance(); err != nil {
		return nil, err
	}
	if p.cur.kind != tokLBrace {
		return nil, fmt.Errorf("line %d: expected {", p.cur.line)
	}
	// peek has already read past the brace. Restart at the brace itself.
	p.lx.i = p.cur.pos
	p.lx.line = p.cur.line
	body, _, err := p.lx.rawBrace()
	if err != nil {
		return nil, err
	}
	// rawBrace consumed the braces directly, so resync the token stream.
	tok, err := p.lx.next()
	if err != nil {
		return nil, err
	}
	p.cur = tok
	tok, err = p.lx.next()
	if err != nil {
		return nil, err
	}
	p.peek = tok
	if p.cur.kind == tokSemi {
		if err := p.advance(); err != nil {
			return nil, err
		}
	}
	return &Asm{Body: body, Line: line}, nil
}

func (p *parser) varStmt() (Stmt, error) {
	line := p.cur.line
	ty, err := p.parseType()
	if err != nil {
		return nil, err
	}
	if p.cur.kind != tokIdent {
		return nil, fmt.Errorf("line %d: expected a variable name", p.cur.line)
	}
	name := p.cur.text
	if err := p.advance(); err != nil {
		return nil, err
	}
	var init Expr
	if p.cur.kind == tokAssign {
		if err := p.advance(); err != nil {
			return nil, err
		}
		init, err = p.expr()
		if err != nil {
			return nil, err
		}
	}
	if err := p.want(tokSemi, ";"); err != nil {
		return nil, err
	}
	return &Var{Name: name, Type: ty, Init: init, Line: line}, nil
}

func (p *parser) expr() (Expr, error) { return p.assign() }

func (p *parser) assign() (Expr, error) {
	left, err := p.or()
	if err != nil {
		return nil, err
	}
	if p.cur.kind != tokAssign {
		return left, nil
	}
	line := p.cur.line
	if err := p.advance(); err != nil {
		return nil, err
	}
	right, err := p.assign()
	if err != nil {
		return nil, err
	}
	return &Assign{Dst: left, Src: right, Line: line}, nil
}

func (p *parser) or() (Expr, error)  { return p.bin(p.and, tokOrOr) }
func (p *parser) and() (Expr, error) { return p.bin(p.eq, tokAndAnd) }

func (p *parser) eq() (Expr, error) {
	return p.bin(p.rel, tokEq, tokNotEq)
}

func (p *parser) rel() (Expr, error) {
	return p.bin(p.add, tokLt, tokLtEq, tokGt, tokGtEq)
}

func (p *parser) add() (Expr, error) {
	return p.bin(p.mul, tokPlus, tokMinus)
}

func (p *parser) mul() (Expr, error) {
	return p.bin(p.unary, tokStar, tokSlash, tokPercent)
}

func (p *parser) bin(next func() (Expr, error), ops ...tokenKind) (Expr, error) {
	left, err := next()
	if err != nil {
		return nil, err
	}
	for p.has(ops...) {
		op := p.cur.text
		line := p.cur.line
		if err := p.advance(); err != nil {
			return nil, err
		}
		right, err := next()
		if err != nil {
			return nil, err
		}
		left = &Binary{Op: op, L: left, R: right, Line: line}
	}
	return left, nil
}

func (p *parser) has(ops ...tokenKind) bool {
	for _, op := range ops {
		if p.cur.kind == op {
			return true
		}
	}
	return false
}

func (p *parser) unary() (Expr, error) {
	switch p.cur.kind {
	case tokBang, tokMinus, tokAmp, tokStar:
		op := p.cur.text
		line := p.cur.line
		if err := p.advance(); err != nil {
			return nil, err
		}
		x, err := p.unary()
		if err != nil {
			return nil, err
		}
		return &Unary{Op: op, X: x, Line: line}, nil
	default:
		return p.postfix()
	}
}

func (p *parser) postfix() (Expr, error) {
	x, err := p.primary()
	if err != nil {
		return nil, err
	}
	for p.cur.kind == tokLParen || p.cur.kind == tokStar {
		name, ok := x.(*Name)
		if !ok {
			return nil, fmt.Errorf("line %d: only a name can be called", p.cur.line)
		}
		ty, isType := namedType(name.Text)
		for isType && p.cur.kind == tokStar {
			ty = &Type{kind: tyPtr, elem: ty}
			if err := p.advance(); err != nil {
				return nil, err
			}
		}
		if p.cur.kind != tokLParen {
			return nil, fmt.Errorf("line %d: expected (", p.cur.line)
		}
		line := p.cur.line
		if err := p.advance(); err != nil {
			return nil, err
		}
		var args []Expr
		if p.cur.kind != tokRParen {
			for {
				a, err := p.expr()
				if err != nil {
					return nil, err
				}
				args = append(args, a)
				if p.cur.kind == tokComma {
					if err := p.advance(); err != nil {
						return nil, err
					}
					continue
				}
				break
			}
		}
		if err := p.want(tokRParen, ")"); err != nil {
			return nil, err
		}
		if isType && len(args) == 1 {
			x = &Cast{Type: ty, X: args[0], Line: line}
			continue
		}
		if isType {
			return nil, fmt.Errorf("line %d: a cast takes one value", line)
		}
		x = &Call{Name: name.Text, Args: args, Line: line}
	}
	return x, nil
}

func (p *parser) primary() (Expr, error) {
	switch p.cur.kind {
	case tokIdent:
		if p.cur.text == "true" || p.cur.text == "false" {
			v := p.cur.text == "true"
			line := p.cur.line
			if err := p.advance(); err != nil {
				return nil, err
			}
			return &BoolLit{Value: v, Line: line}, nil
		}
		n := &Name{Text: p.cur.text, Line: p.cur.line}
		if err := p.advance(); err != nil {
			return nil, err
		}
		return n, nil
	case tokNumber:
		n := &Number{Text: p.cur.text, Line: p.cur.line}
		if err := p.advance(); err != nil {
			return nil, err
		}
		return n, nil
	case tokLParen:
		if err := p.advance(); err != nil {
			return nil, err
		}
		x, err := p.expr()
		if err != nil {
			return nil, err
		}
		if err := p.want(tokRParen, ")"); err != nil {
			return nil, err
		}
		return x, nil
	default:
		return nil, fmt.Errorf("line %d: expected an expression", p.cur.line)
	}
}

func parseNumber(text string) (int64, error) {
	if len(text) > 2 && (text[1] == 'x' || text[1] == 'X') {
		v, err := strconv.ParseUint(text, 0, 64)
		return int64(v), err
	}
	v, err := strconv.ParseInt(text, 10, 64)
	return v, err
}
