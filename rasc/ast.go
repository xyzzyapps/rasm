package main

// A Type is exact. There are no implicit conversions.
type Type struct {
	kind typeKind
	elem *Type
}

type typeKind int

const (
	tyVoid typeKind = iota
	tyBool
	tyInt8
	tyInt16
	tyInt32
	tyInt64
	tyUint8
	tyUint16
	tyUint32
	tyUint64
	tyPtr
)

func (t *Type) String() string {
	if t == nil {
		return "<none>"
	}
	switch t.kind {
	case tyVoid:
		return "void"
	case tyBool:
		return "bool"
	case tyInt8:
		return "int8"
	case tyInt16:
		return "int16"
	case tyInt32:
		return "int32"
	case tyInt64:
		return "int64"
	case tyUint8:
		return "uint8"
	case tyUint16:
		return "uint16"
	case tyUint32:
		return "uint32"
	case tyUint64:
		return "uint64"
	case tyPtr:
		return t.elem.String() + "*"
	default:
		return "<bad type>"
	}
}

func (t *Type) equal(o *Type) bool {
	if t == nil || o == nil {
		return t == o
	}
	if t.kind != o.kind {
		return false
	}
	if t.kind == tyPtr {
		return t.elem.equal(o.elem)
	}
	return true
}

func (t *Type) isInteger() bool {
	switch t.kind {
	case tyInt8, tyInt16, tyInt32, tyInt64, tyUint8, tyUint16, tyUint32, tyUint64:
		return true
	default:
		return false
	}
}

func (t *Type) isSigned() bool {
	switch t.kind {
	case tyInt8, tyInt16, tyInt32, tyInt64:
		return true
	default:
		return false
	}
}

func (t *Type) bits() int {
	switch t.kind {
	case tyBool, tyInt8, tyUint8:
		return 8
	case tyInt16, tyUint16:
		return 16
	case tyInt32, tyUint32:
		return 32
	default:
		return 64
	}
}

type Program struct {
	Decls []Decl
}

type Decl interface{ decl() }

type Param struct {
	Name string
	Type *Type
	Line int
}

type Func struct {
	Name   string
	Ret    *Type
	Params []Param
	Body   *Block
	Line   int
}

func (*Func) decl() {}

type Global struct {
	Name string
	Type *Type
	Init Expr
	Line int
}

func (*Global) decl() {}

type Stmt interface{ stmt() }

type Block struct {
	Stmts []Stmt
	Line  int
}

func (*Block) stmt() {}

type If struct {
	Cond Expr
	Then Stmt
	Else Stmt
	Line int
}

func (*If) stmt() {}

type While struct {
	Cond Expr
	Body Stmt
	Line int
}

func (*While) stmt() {}

type Return struct {
	Value Expr
	Line  int
}

func (*Return) stmt() {}

type Asm struct {
	Body string
	Line int
}

func (*Asm) stmt() {}

type Var struct {
	Name string
	Type *Type
	Init Expr
	Line int
}

func (*Var) stmt() {}

type ExprStmt struct {
	X    Expr
	Line int
}

func (*ExprStmt) stmt() {}

type Expr interface{ expr() }

type Name struct {
	Text string
	Line int
}

func (*Name) expr() {}

type Number struct {
	Text string
	Line int
}

func (*Number) expr() {}

type BoolLit struct {
	Value bool
	Line  int
}

func (*BoolLit) expr() {}

type Unary struct {
	Op   string
	X    Expr
	Line int
}

func (*Unary) expr() {}

type Binary struct {
	Op   string
	L    Expr
	R    Expr
	Line int
}

func (*Binary) expr() {}

type Assign struct {
	Dst  Expr
	Src  Expr
	Line int
}

func (*Assign) expr() {}

type Call struct {
	Name string
	Args []Expr
	Line int
}

func (*Call) expr() {}

type Cast struct {
	Type *Type
	X    Expr
	Line int
}

func (*Cast) expr() {}
