package main

import (
	"fmt"
	"strings"
	"unicode"
	"unicode/utf8"
)

type tokenKind int

const (
	tokEOF tokenKind = iota
	tokIdent
	tokNumber
	tokLBrace
	tokRBrace
	tokLParen
	tokRParen
	tokSemi
	tokComma
	tokStar
	tokAmp
	tokPlus
	tokMinus
	tokSlash
	tokPercent
	tokBang
	tokAssign
	tokEq
	tokNotEq
	tokLt
	tokLtEq
	tokGt
	tokGtEq
	tokAndAnd
	tokOrOr
)

type token struct {
	kind tokenKind
	text string
	line int
	pos  int
}

type lexer struct {
	src  string
	i    int
	line int
}

func newLexer(src string) *lexer {
	return &lexer{src: src, line: 1}
}

func (l *lexer) next() (token, error) {
	l.skipSpace()
	if l.i >= len(l.src) {
		return token{kind: tokEOF, line: l.line}, nil
	}
	startLine := l.line
	r, w := utf8.DecodeRuneInString(l.src[l.i:])
	switch r {
	case '{':
		pos := l.i
		l.i += w
		return token{kind: tokLBrace, text: "{", line: startLine, pos: pos}, nil
	case '}':
		l.i += w
		return token{kind: tokRBrace, text: "}", line: startLine}, nil
	case '(':
		l.i += w
		return token{kind: tokLParen, text: "(", line: startLine}, nil
	case ')':
		l.i += w
		return token{kind: tokRParen, text: ")", line: startLine}, nil
	case ';':
		l.i += w
		return token{kind: tokSemi, text: ";", line: startLine}, nil
	case ',':
		l.i += w
		return token{kind: tokComma, text: ",", line: startLine}, nil
	case '*':
		l.i += w
		return token{kind: tokStar, text: "*", line: startLine}, nil
	case '&':
		if strings.HasPrefix(l.src[l.i:], "&&") {
			l.i += 2
			return token{kind: tokAndAnd, text: "&&", line: startLine}, nil
		}
		l.i += w
		return token{kind: tokAmp, text: "&", line: startLine}, nil
	case '|':
		if strings.HasPrefix(l.src[l.i:], "||") {
			l.i += 2
			return token{kind: tokOrOr, text: "||", line: startLine}, nil
		}
		return token{}, fmt.Errorf("line %d: '|' is not an operator. Use ||", startLine)
	case '+':
		l.i += w
		return token{kind: tokPlus, text: "+", line: startLine}, nil
	case '-':
		l.i += w
		return token{kind: tokMinus, text: "-", line: startLine}, nil
	case '/':
		l.i += w
		return token{kind: tokSlash, text: "/", line: startLine}, nil
	case '%':
		l.i += w
		return token{kind: tokPercent, text: "%", line: startLine}, nil
	case '!':
		if strings.HasPrefix(l.src[l.i:], "!=") {
			l.i += 2
			return token{kind: tokNotEq, text: "!=", line: startLine}, nil
		}
		l.i += w
		return token{kind: tokBang, text: "!", line: startLine}, nil
	case '=':
		if strings.HasPrefix(l.src[l.i:], "==") {
			l.i += 2
			return token{kind: tokEq, text: "==", line: startLine}, nil
		}
		l.i += w
		return token{kind: tokAssign, text: "=", line: startLine}, nil
	case '<':
		if strings.HasPrefix(l.src[l.i:], "<=") {
			l.i += 2
			return token{kind: tokLtEq, text: "<=", line: startLine}, nil
		}
		l.i += w
		return token{kind: tokLt, text: "<", line: startLine}, nil
	case '>':
		if strings.HasPrefix(l.src[l.i:], ">=") {
			l.i += 2
			return token{kind: tokGtEq, text: ">=", line: startLine}, nil
		}
		l.i += w
		return token{kind: tokGt, text: ">", line: startLine}, nil
	}
	if unicode.IsLetter(r) || r == '_' {
		j := l.i + w
		for j < len(l.src) {
			r2, w2 := utf8.DecodeRuneInString(l.src[j:])
			if !unicode.IsLetter(r2) && !unicode.IsDigit(r2) && r2 != '_' {
				break
			}
			j += w2
		}
		text := l.src[l.i:j]
		l.i = j
		return token{kind: tokIdent, text: text, line: startLine}, nil
	}
	if unicode.IsDigit(r) {
		j := l.i
		if strings.HasPrefix(l.src[l.i:], "0x") || strings.HasPrefix(l.src[l.i:], "0X") {
			j += 2
		}
		for j < len(l.src) {
			c := l.src[j]
			if (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F') || c == 'x' || c == 'X' {
				j++
				continue
			}
			break
		}
		text := l.src[l.i:j]
		l.i = j
		return token{kind: tokNumber, text: text, line: startLine}, nil
	}
	return token{}, fmt.Errorf("line %d: unexpected character %q", startLine, string(r))
}

func (l *lexer) skipSpace() {
	for l.i < len(l.src) {
		if strings.HasPrefix(l.src[l.i:], "//") {
			for l.i < len(l.src) && l.src[l.i] != '\n' {
				l.i++
			}
			continue
		}
		if strings.HasPrefix(l.src[l.i:], "/*") {
			l.i += 2
			for l.i+1 < len(l.src) && !(l.src[l.i] == '*' && l.src[l.i+1] == '/') {
				if l.src[l.i] == '\n' {
					l.line++
				}
				l.i++
			}
			if l.i+1 < len(l.src) {
				l.i += 2
			}
			continue
		}
		r, w := utf8.DecodeRuneInString(l.src[l.i:])
		if r == '\n' {
			l.line++
			l.i += w
			continue
		}
		if unicode.IsSpace(r) {
			l.i += w
			continue
		}
		return
	}
}

// rawBrace reads the text inside a brace pair. The opening brace is still upcoming.
func (l *lexer) rawBrace() (string, int, error) {
	l.skipSpace()
	line := l.line
	if l.i >= len(l.src) || l.src[l.i] != '{' {
		return "", line, fmt.Errorf("line %d: expected {", line)
	}
	l.i++
	if l.i < len(l.src) && l.src[l.i] == '\n' {
		l.line++
		l.i++
	}
	start := l.i
	depth := 1
	for l.i < len(l.src) && depth > 0 {
		if l.src[l.i] == '\n' {
			l.line++
		}
		if l.src[l.i] == '{' {
			depth++
		} else if l.src[l.i] == '}' {
			depth--
			if depth == 0 {
				body := l.src[start:l.i]
				l.i++
				return body, line, nil
			}
		}
		l.i++
	}
	return "", line, fmt.Errorf("line %d: asm block is missing }", line)
}
