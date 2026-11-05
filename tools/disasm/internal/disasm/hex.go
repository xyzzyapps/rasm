package disasm

import (
	"fmt"
	"strconv"
	"strings"
)

// ParseHex reads machine-code bytes from text.
// Spaces, commas, colons, and 0x prefixes are ignored.
// A leading address before a colon is ignored.
// A tab and the text after it are ignored, so an objdump line can be pasted.
func ParseHex(s string) ([]byte, error) {
	var digits []byte
	for _, line := range strings.Split(s, "\n") {
		line = cutComment(line)
		if i := strings.IndexByte(line, ':'); i >= 0 {
			left := strings.TrimSpace(line[:i])
			if left != "" && isHexToken(left) {
				line = line[i+1:]
			}
		}
		line = strings.TrimSpace(line)
		if i := strings.IndexByte(line, '\t'); i >= 0 {
			line = line[:i]
		}
		line = strings.ReplaceAll(line, "\\x", " ")
		line = strings.ReplaceAll(line, "0X", " ")
		line = strings.ReplaceAll(line, "0x", " ")
		for i := 0; i < len(line); i++ {
			c := line[i]
			switch {
			case isHexDigit(c):
				digits = append(digits, c)
			case c == ' ' || c == '\t' || c == '\r' || c == ',' || c == ':' || c == '-' || c == '_':
				continue
			default:
				return nil, fmt.Errorf("invalid hex character %q", string(c))
			}
		}
	}
	if len(digits) == 0 {
		return nil, fmt.Errorf("no hex bytes")
	}
	if len(digits)%2 != 0 {
		return nil, fmt.Errorf("hex string has an odd number of digits")
	}
	out := make([]byte, len(digits)/2)
	for i := 0; i < len(out); i++ {
		v, err := strconv.ParseUint(string(digits[i*2:i*2+2]), 16, 8)
		if err != nil {
			return nil, err
		}
		out[i] = byte(v)
	}
	return out, nil
}

func cutComment(line string) string {
	if i := strings.Index(line, "//"); i >= 0 {
		line = line[:i]
	}
	if i := strings.IndexAny(line, ";#"); i >= 0 {
		line = line[:i]
	}
	return line
}

func isHexDigit(c byte) bool {
	return c >= '0' && c <= '9' || c >= 'a' && c <= 'f' || c >= 'A' && c <= 'F'
}

func isHexToken(s string) bool {
	s = strings.TrimPrefix(strings.TrimPrefix(s, "0x"), "0X")
	if s == "" {
		return false
	}
	for i := 0; i < len(s); i++ {
		if !isHexDigit(s[i]) {
			return false
		}
	}
	return true
}

// HexBytes formats machine bytes as lowercase hex pairs.
func HexBytes(b []byte) string {
	if len(b) == 0 {
		return ""
	}
	var sb strings.Builder
	for i, c := range b {
		if i > 0 {
			sb.WriteByte(' ')
		}
		fmt.Fprintf(&sb, "%02x", c)
	}
	return sb.String()
}

// HexWindow formats a few rows of a hex dump around offset.
// The row that contains offset starts with ">".
func HexWindow(data []byte, offset, length int) string {
	if len(data) == 0 || offset < 0 || offset >= len(data) {
		return ""
	}
	if length < 1 {
		length = 1
	}
	start := (offset &^ 15) - 16
	if start < 0 {
		start = 0
	}
	end := start + 16*6
	if end > len(data) {
		end = len(data)
	}
	var sb strings.Builder
	for line := start; line < end; line += 16 {
		mark := " "
		if offset >= line && offset < line+16 {
			mark = ">"
		}
		fmt.Fprintf(&sb, "%s %04x  ", mark, line)
		for i := 0; i < 16; i++ {
			if line+i >= len(data) {
				break
			}
			fmt.Fprintf(&sb, "%02x ", data[line+i])
		}
		if line+16 < end {
			sb.WriteByte('\n')
		}
	}
	return sb.String()
}
