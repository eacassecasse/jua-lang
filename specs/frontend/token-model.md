# Token Model

## Purpose

This document defines the token model used by the Jua compiler frontend.

Tokens are the output of lexical analysis and the input of syntactic analysis. They form the contract between the lexer and parser.

This specification defines:

* Token structure
* Token categories
* Token metadata
* Source location tracking
* Lexer responsibilities
* Parser expectations

This document does not define the lexical grammar itself. Lexical grammar is specified separately.

---

# Overview

The lexical analysis phase transforms source text into a stream of tokens.

Example:

Source:

```jua
function add(a, b)

    return a + b

end
```

Token stream:

```text
FUNCTION
IDENTIFIER(add)
LEFT_PAREN
IDENTIFIER(a)
COMMA
IDENTIFIER(b)
RIGHT_PAREN
NEWLINE

RETURN
IDENTIFIER(a)
PLUS
IDENTIFIER(b)

NEWLINE
END
EOF
```

The parser consumes tokens and constructs the Abstract Syntax Tree (AST).

---

# Design Principles

The token model follows the following principles:

* Simplicity
* Deterministic representation
* Source location preservation
* Frontend tool independence
* Parser-friendly structure
* Future extensibility

---

# Token Structure

Every token must contain the following information.

```text
Token
├── kind
├── lexeme
├── span
└── value (optional)
```

---

## kind

Identifies the token category.

Examples:

```text
IDENTIFIER
INTEGER_LITERAL
FUNCTION
PLUS
EOF
```

The parser primarily operates on token kinds.

---

## lexeme

The exact text matched from the source file.

Examples:

```text
function
student
123
+
```

Lexemes preserve original source representation.

---

## span

Represents the source location occupied by the token.

See Source Location Model.

---

## value

Optional normalized value.

Examples:

Source:

```jua
123
```

Token:

```text
kind: INTEGER_LITERAL
lexeme: "123"
value: 123
```

Source:

```jua
"hello"
```

Token:

```text
kind: STRING_LITERAL
lexeme: "\"hello\""
value: "hello"
```

The parser should not depend on value normalization.

---

# Source Location Model

Every token must contain precise source information.

---

## Source Position

```text
SourcePosition
├── line
└── column
```

Example:

```text
line: 10
column: 5
```

---

## Source Span

```text
SourceSpan
├── start
└── end
```

Example:

```text
start: line 10 column 5
end:   line 10 column 12
```

Spans are used by diagnostics and error reporting.

---

# Token Categories

Jua tokens are grouped into categories.

---

## Keywords

Keywords represent reserved language constructs.

Examples:

```text
FUNCTION
RETURN
IF
ELSE
WHILE
FOR
IN
BREAK
CONTINUE
OBJECT
TRAIT
INTERFACE
USES
IMPORT
EXPORT
CREATE
MUTABLE
TRUE
FALSE
NULL
END
```

Keywords cannot be used as identifiers.

---

## Identifiers

Identifiers represent user-defined names.

Examples:

```jua
student
calculate
totalScore
```

Token kind:

```text
IDENTIFIER
```

---

## Literals

Literal tokens represent constant values.

---

### Integer Literals

Examples:

```jua
0
1
100
```

Token kind:

```text
INTEGER_LITERAL
```

---

### Floating Point Literals

Examples:

```jua
1.0
3.14
0.5
```

Token kind:

```text
FLOAT_LITERAL
```

---

### String Literals

Examples:

```jua
"hello"
'world'
```

Token kind:

```text
STRING_LITERAL
```

Both single-quoted and double-quoted strings are supported.

---

### Boolean Literals

Examples:

```jua
true
false
```

Token kinds:

```text
TRUE
FALSE
```

---

### Null Literal

Example:

```jua
null
```

Token kind:

```text
NULL
```

---

# Operators

Operators represent computational actions.

Examples:

```text
PLUS
MINUS
STAR
SLASH
PERCENT

EQUAL
NOT_EQUAL

LESS
LESS_EQUAL

GREATER
GREATER_EQUAL

AND
OR
NOT

ASSIGN
```

Exact operator syntax is defined by the grammar specification.

---

# Delimiters

Delimiters structure source code.

Examples:

```text
LEFT_PAREN
RIGHT_PAREN

LEFT_BRACKET
RIGHT_BRACKET

COMMA
COLON
DOT
```

---

# Statement Delimiters

Jua uses NEWLINE as the primary statement separator.

Example:

```jua
create age = 20
print(age)
```

Produces:

```text
CREATE
IDENTIFIER
ASSIGN
INTEGER_LITERAL
NEWLINE

IDENTIFIER
LEFT_PAREN
IDENTIFIER
RIGHT_PAREN
NEWLINE
```

The lexer must emit NEWLINE tokens where appropriate.

---

# Comments

Comments are ignored by the parser.

---

## Single-Line Comments

Syntax:

```jua
# comment
```

Comments do not produce parser-visible tokens.

---

## Multi-Line Comments

Syntax:

```jua
#*
multi-line comment
*#
```

Comments do not produce parser-visible tokens.

Multi-line comments may span multiple lines.

---

# Whitespace

Whitespace other than NEWLINE is ignored.

Examples:

```text
Space
Tab
Carriage Return
```

The lexer must preserve location tracking while discarding ignored whitespace.

---

# End of File

The lexer must emit a single EOF token at the end of every source file.

Example:

```text
EOF
```

The parser relies on EOF to detect completion of input.

---

# Error Tokens

The lexer may internally generate error diagnostics.

Examples:

```text
Unterminated string literal
Invalid character
Malformed numeric literal
```

Lexical errors should be reported through the diagnostics subsystem.

The parser must not receive invalid tokens.

---

# Frontend Independence

The token model is independent of lexer implementation technology.

Whether tokens are produced by:

* JFlex
* Handwritten lexer
* Future lexer implementations

the observable token stream must remain identical.

This requirement supports ADR-0010 (Tool-Agnostic Frontend Architecture).

---

# Stability Requirements

Changes to token kinds are language-level changes.

Adding, removing, or renaming token kinds requires corresponding updates to:

* Lexical grammar
* Parser grammar
* Syntax model
* Language specifications

---

# Related Specifications

* specs/grammar/lexical-grammar.md
* specs/grammar/expressions.md
* specs/grammar/statements.md
* specs/diagnostics/error-codes.md
* specs/semantics/compiler-phases.md

---

# Related ADRs

* ADR-0008 Layered Compiler Architecture
* ADR-0010 Tool-Agnostic Frontend Architecture

