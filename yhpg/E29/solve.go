package e29

import (
	"errors"
	"fmt"
	"strings"
)

type lexer struct {
	cur  int
	text string

	mode lexerMode
}
type lexerMode int32

const (
	normal lexerMode = iota
	singleQuote
	doubleQuote
)

const (
	slashByte  = '/'
	dQuoteByte = '"'
	sQuoteByte = '\''
)

var validChars = []byte("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\"'/")

const noAnswer = "-"

type result struct {
	output string
	err    error
}

func solve(input string) result {
	l := lexer{text: input}
	var tokens []string
	for l.Next() {
		token, err := l.NextToken()
		if err != nil {
			return result{output: noAnswer, err: err}
		}
		tokens = append(tokens, token)
	}
	if l.mode != normal {
		return result{output: noAnswer, err: errors.New("unterminated quote")}
	}
	if len(tokens) == 0 {
		return result{output: noAnswer, err: errors.New("no entries")}
	}
	output := strings.Join(tokens, ",")
	return result{output: output, err: nil}
}

func (l *lexer) Next() bool {
	if l.cur == len(l.text) {
		return false
	}
	return true
}

func isValidByte(b byte) bool {
	for _, bb := range validChars {
		if b == bb {
			return true
		}
	}
	return false
}

func (l *lexer) NextToken() (string, error) {
	var ret []byte
	beg := l.cur
loop:
	for {
		if l.cur >= len(l.text) {
			return "", errors.New("idx")
		}
		c := l.text[l.cur]
		if !isValidByte(c) {
			return "", fmt.Errorf("invalid char: %v", string(c))
		}
		switch c {
		case slashByte:
			if l.mode == normal {
				if l.cur+1 == len(l.text) { // 終わり
					return "", errors.New("should not end with /")
				}
				if l.text[l.cur+1] == slashByte {
					// スラッシュ2個のパターン
					ret = append(ret, c)
					l.cur += 2
				} else {
					l.cur++
					break loop
				}
			} else {
				// quote 中は / として扱う
				l.cur++
				ret = append(ret, c)
			}
		case dQuoteByte:
			if l.mode == normal {
				l.mode = doubleQuote
				l.cur++
			} else if l.mode == doubleQuote {
				l.mode = normal
				l.cur++
			} else if l.mode == singleQuote {
				l.cur++
				ret = append(ret, c)
			}
		case sQuoteByte:
			if l.mode == normal {
				l.mode = singleQuote
				l.cur++
			} else if l.mode == doubleQuote {
				l.cur++
				ret = append(ret, c)
			} else if l.mode == singleQuote {
				l.mode = normal
				l.cur++
			}
		default:
			l.cur++
			ret = append(ret, c)
		}

		if l.cur == len(l.text) {
			break loop
		}
	}
	entry := string(ret)
	if entry == "" {
		return "", fmt.Errorf("entry should not be blank %d-%d", beg, l.cur)
	}
	return entry, nil
}
