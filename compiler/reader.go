package main

import (
	"fmt"
	"strconv"
	"strings"
)

// Node is a parsed s-expression. The reader produces these trees; because the
// language is a thin wrapper over rasm, the s-expression tree *is* the AST and
// is passed straight to the code generator.
type Node interface{ isNode() }

// Num is an integer literal (decimal or 0x hex, optionally negative).
type Num struct{ Val int64 }

// Sym is a symbol: a variable, register, operator, keyword, or struct field.
type Sym struct{ Name string }

// Mem is a raw "[...]" memory operand token, valid only inside (asm ...).
type Mem struct{ Text string }

// List is a parenthesized form.
type List struct{ Items []Node }

func (Num) isNode()  {}
func (Sym) isNode()  {}
func (Mem) isNode()  {}
func (List) isNode() {}

func (n Num) String() string  { return fmt.Sprintf("(num %d)", n.Val) }
func (n Sym) String() string  { return fmt.Sprintf("(sym %s)", n.Name) }
func (n Mem) String() string  { return fmt.Sprintf("(mem %s)", n.Text) }
func (n List) String() string { return fmt.Sprintf("(list %v)", n.Items) }

// Reader tokenizes and parses a Lisp source string into a slice of top-level
// forms. Comments run from ';' to end of line. '[' ... ']' is consumed as a
// single raw memory-operand token (bracket nesting counted, contents preserved
// verbatim including the brackets).
type Reader struct {
	src string
	pos int
}

// NewReader returns a Reader over src.
func NewReader(src string) *Reader {
	return &Reader{src: src}
}

// ReadAll parses every top-level form in the source.
func (r *Reader) ReadAll() ([]Node, error) {
	var forms []Node
	for {
		r.skipSpace()
		if r.eof() {
			return forms, nil
		}
		f, err := r.readForm()
		if err != nil {
			return nil, err
		}
		forms = append(forms, f)
	}
}

func (r *Reader) eof() bool { return r.pos >= len(r.src) }

func (r *Reader) peek() byte {
	if r.eof() {
		return 0
	}
	return r.src[r.pos]
}

func (r *Reader) skipSpace() {
	for !r.eof() {
		c := r.src[r.pos]
		switch c {
		case ' ', '\t', '\r', '\n':
			r.pos++
		case ';':
			for !r.eof() && r.src[r.pos] != '\n' {
				r.pos++
			}
		default:
			return
		}
	}
}

func (r *Reader) readForm() (Node, error) {
	r.skipSpace()
	if r.eof() {
		return nil, fmt.Errorf("unexpected end of input")
	}
	switch r.peek() {
	case '(':
		return r.readList()
	case '[':
		return r.readMem()
	case ':':
		// ':' is invisible punctuation (used in (name : type) field syntax)
		r.pos++
		return r.readForm()
	default:
		return r.readAtom()
	}
}

func (r *Reader) readList() (Node, error) {
	// caller guarantees r.peek() == '('
	r.pos++ // consume '('
	var items []Node
	for {
		r.skipSpace()
		if r.eof() {
			return nil, fmt.Errorf("unclosed list (missing ')')")
		}
		if r.peek() == ')' {
			r.pos++
			return List{Items: items}, nil
		}
		f, err := r.readForm()
		if err != nil {
			return nil, err
		}
		items = append(items, f)
	}
}

func (r *Reader) readMem() (Node, error) {
	// caller guarantees r.peek() == '['
	start := r.pos
	depth := 0
	for !r.eof() {
		c := r.src[r.pos]
		switch c {
		case '[':
			depth++
		case ']':
			depth--
			if depth == 0 {
				r.pos++
				return Mem{Text: r.src[start:r.pos]}, nil
			}
		}
		r.pos++
	}
	return nil, fmt.Errorf("unclosed memory operand starting at offset %d", start)
}

func (r *Reader) readAtom() (Node, error) {
	start := r.pos
	for !r.eof() {
		c := r.src[r.pos]
		if c == ' ' || c == '\t' || c == '\r' || c == '\n' || c == '(' || c == ')' || c == '[' || c == ']' || c == ';' || c == ':' {
			break
		}
		r.pos++
	}
	if start == r.pos {
		return nil, fmt.Errorf("unexpected character %q at offset %d", r.src[r.pos], r.pos)
	}
	text := r.src[start:r.pos]
	// Try integer (decimal or 0x hex). Note: standalone "-" stays a symbol.
	if v, err := strconv.ParseInt(text, 0, 64); err == nil {
		return Num{Val: v}, nil
	}
	return Sym{Name: text}, nil
}

// AtomName returns the name of a symbol node, or "" if n is not a symbol.
func AtomName(n Node) string {
	if s, ok := n.(Sym); ok {
		return s.Name
	}
	return ""
}

// ListItems returns the items of a list node, or nil.
func ListItems(n Node) []Node {
	if l, ok := n.(List); ok {
		return l.Items
	}
	return nil
}

// QuoteMem emits the raw memory token, e.g. "[buf + data_64*8]".
func QuoteMem(n Node) string {
	if m, ok := n.(Mem); ok {
		return m.Text
	}
	if s, ok := n.(Sym); ok {
		return s.Name
	}
	return fmt.Sprintf("%v", n)
}

// String renders a node back to Lisp-ish text (used in error messages).
func NodeString(n Node) string {
	switch v := n.(type) {
	case Num:
		return strconv.FormatInt(v.Val, 10)
	case Sym:
		return v.Name
	case Mem:
		return v.Text
	case List:
		parts := make([]string, len(v.Items))
		for i, it := range v.Items {
			parts[i] = NodeString(it)
		}
		return "(" + strings.Join(parts, " ") + ")"
	default:
		return "?"
	}
}
