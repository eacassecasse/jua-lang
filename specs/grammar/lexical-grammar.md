Good. We’ll start where implementation actually becomes real: the lexer boundary.

This document is the contract between **Jua source code** and your **JFlex lexer**. If this is ambiguous, everything downstream (parser, AST, semantic analysis) becomes unstable.

---

# `specs/grammar/lexical-structure.md`

This document defines how raw Jua source code is converted into a sequence of tokens.

It specifies:

* Character set rules
* Token categories
* Keywords
* Identifiers
* Literals
* Operators
* Delimiters
* Whitespace rules
* Comment rules
* Newline handling

This specification is the foundation of the Jua lexer.

---

# Design Philosophy

Jua lexical structure follows the principle:

> The lexer should be simple, deterministic, and unambiguous.

The lexical layer must:

* Avoid context-sensitive behavior where possible
* Produce consistent tokens across platforms
* Be easy to implement in JFlex or equivalent tools
* Support UTF-8 source input

---

# Source Encoding

Jua source files MUST be encoded in:

```text id="a8m0xq"
UTF-8
```

---

# Character Set

Jua supports the full Unicode character set as defined by UTF-8.

Identifiers are limited to a subset for predictability.

---

# Whitespace

Whitespace characters include:

```text id="v0xq2n"
Space (U+0020)
Tab (U+0009)
Carriage Return (U+000D)
```

Whitespace is ignored except where it separates tokens.

---

# Newlines

Newlines are significant in Jua.

Each newline is tokenized as:

```text id="l9q3dv"
NEWLINE
```

---

## Newline Rules

A NEWLINE token is emitted when:

* A line terminator is encountered
* Not inside a string literal
* Not inside a comment

---

## Purpose of NEWLINE

NEWLINE acts as a **statement separator**.

Example:

```jua id="k3p8mx"
create a = 10
create b = 20
```

Equivalent to:

```text id="r7n2kq"
create a = 10 ; create b = 20
```

(but semicolons are not part of the language)

---

# Comments

Jua supports two forms of comments.

---

## Single-line comment

```text id="c9q1zl"
# comment text
```

Everything from `#` to end of line is ignored.

---

## Multi-line comment

```text id="m4t8bv"
#*
multi-line
comment
*#
```

Everything between `#*` and `*#` is ignored.

---

# Identifiers

Identifiers are used for:

* Variables
* Functions
* Objects
* Traits
* Interfaces
* Modules

---

## Identifier Syntax

```text id="i7p2qx"
[A-Za-z_][A-Za-z0-9_]*
```

---

## Valid Examples

```jua id="v3k9zn"
name
student_name
Student
_create
value1
```

---

## Invalid Examples

```jua id="x8m2ld"
1name
student-name
class
```

---

## Reserved Keywords Rule

Identifiers MUST NOT match reserved keywords.

Example:

```text id="t5nq9a"
if
while
create
object
```

are invalid identifiers.

---

# Keywords

The following are reserved keywords:

```text id="w1k9zm"
if
else
while
for
repeat

function
return

create
mutable
constant

object
self

interface
implements

trait
uses

extends

import
export

test

true
false
null

end
```

---

# Literals

## Integer Literals

```text id="p4v8lm"
10
0
999
```

Underscores allowed for readability:

```text id="u2q9mx"
1_000_000
```

---

## Float Literals

```text id="f8n3qp"
10.5
0.99
```

---

## String Literals

Strings are UTF-8 encoded sequences enclosed in:

```text id="s7k1nv"
"double quotes"
'single quotes'
```

---

## Escape Sequences

Supported escape sequences:

```text id="e2m9qt"
\n  newline
\t  tab
\"  double quote
\'  single quote
\\  backslash
```

---

## Boolean Literals

```text id="b6x1qw"
true
false
```

---

## Null Literal

```text id="n9p3rt"
null
```

---

# Operators

## Arithmetic

```text id="o1k8mz"
+
-
*
/
```

---

## Comparison

```text id="c7m2qv"
==
!=
<
>
<=
>=
```

---

## Logical

```text id="l5p9nx"
and
or
not
```

---

## Assignment

```text id="a3v8tk"
=
```

---

# Delimiters

```text id="d9q1xm"
(
)
[
]
{
}
,
.
:
```

---

# Statement Separators

Statements are separated by:

```text id="s4n7qz"
NEWLINE
```

No semicolons are used.

---

# Token Categories

The lexer MUST produce the following token types:

```text id="t8m2kx"
IDENTIFIER
KEYWORD
INTEGER_LITERAL
FLOAT_LITERAL
STRING_LITERAL
BOOLEAN_LITERAL
NULL_LITERAL

OPERATOR
DELIMITER
NEWLINE

COMMENT (ignored or skipped)
```

---

# Lexical Rules Summary

1. UTF-8 input
2. Whitespace ignored except separation
3. Newlines are significant
4. Comments ignored
5. Identifiers follow strict regex
6. Keywords override identifiers
7. Literals are strongly typed at lexing stage

---

# Ambiguity Rules

If ambiguity exists:

1. Longest match wins
2. Keyword precedence over identifier
3. String literals consume until closing delimiter
4. Comments override all tokenization inside them

---

# Example Tokenization

Input:

```jua id="ex1"
create age = 10
```

Tokens:

```text id="ex2"
KEYWORD(create)
IDENTIFIER(age)
OPERATOR(=)
INTEGER_LITERAL(10)
NEWLINE
```

---

# Compiler Boundary

This specification defines the boundary:

```text id="bnd1"
Source Code
    ↓
Lexer (this spec)
    ↓
Token Stream
    ↓
Parser (next spec)
```

---

# Non-Goals

This document does NOT define:

* Grammar rules
* AST structure
* Type checking
* Execution semantics

---

# Compliance

A conforming lexer MUST:

* Follow all token rules
* Respect keyword precedence
* Emit NEWLINE tokens correctly
* Support UTF-8 input
* Handle comments properly
