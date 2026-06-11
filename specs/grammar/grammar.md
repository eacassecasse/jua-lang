# Grammar

Version: 0.1 Draft
Status: Proposed

---

# Purpose

This document defines the syntactic structure of Jua programs.

It specifies how:

* Expressions
* Statements
* Functions
* Objects
* Traits
* Interfaces
* Tests
* Modules

are combined into valid programs.

---

# Design Philosophy

Jua grammar follows the principle:

> The structure of a program should be predictable and indentation-independent.

Jua uses explicit keywords rather than whitespace-based block structure.

---

# Program Structure

A Jua program consists of a sequence of top-level declarations.

## Top-level constructs:

```text id="p1"
Function Declaration
Object Declaration
Interface Declaration
Trait Declaration
Test Declaration
Import/Export Statements
```

---

# Program Rule (Abstract)

```text id="g1"
program
    = (topLevelDeclaration NEWLINE*)*
```

---

# Statements

A statement is an executable unit inside a block.

---

## Statement Types

```text id="s1"
Variable Declaration
Assignment (restricted rules)
Expression Statement
Return Statement
Control Flow Statement
Block Statement
```

---

# Block Structure

All blocks use:

```text id="b1"
end
```

to terminate.

---

## Example

```jua id="b2"
function add(a, b)
    return a + b
end
```

---

# Function Declarations

## Syntax

```text id="f1"
function name(params)
    body
end
```

---

## Example

```jua id="f2"
function add(a, b)
    return a + b
end
```

---

## Rules

* Parameters are comma-separated identifiers
* Functions may return values using `return`
* Function body is a block

---

# Return Statement

## Syntax

```text id="r1"
return expression
```

---

## Example

```jua id="r2"
return a + b
```

---

# Object Declarations

## Syntax

```jua id="o1"
object Name
    body
end
```

---

## Example

```jua id="o2"
object Student

    create name

    function greet()
        return "Hello"
    end

end
```

---

# Interface Declarations

## Syntax

```jua id="i1"
interface Name
    body
end
```

---

## Example

```jua id="i2"
interface Printable
    function print()
end
```

---

# Trait Declarations

## Syntax

```jua id="t1"
trait Name
    body
end
```

---

## Example

```jua id="t2"
trait Loggable
    function log(message)
end
```

---

# Test Declarations

## Syntax

```jua id="te1"
test Name
    body
end
```

---

## Example

```jua id="te2"
test Addition
    assert(1 + 1 == 2)
end
```

---

# Variable Declarations

## Syntax

```jua id="v1"
create name = expression
```

or

```jua id="v2"
create name
```

---

## Example

```jua id="v3"
create age = 10
```

---

# Mutability

```jua id="m1"
create mutable age = 10
```

---

# Assignment Statement

## Syntax

```jua id="a1"
identifier = expression
```

---

## Example

```jua id="a2"
age = 20
```

---

## Rule

Assignment is a statement, not an expression.

---

# Expression Statement

Expressions may be used as statements.

## Example

```jua id="e1"
print("Hello")
```

---

# Control Flow Statements

---

## If Statement

```jua id="c1"
if condition
    body
end
```

---

### Example

```jua id="c2"
if age > 18
    print("Adult")
end
```

---

## If-Else

```jua id="c3"
if condition
    body
else
    body
end
```

---

## While Loop

```jua id="w1"
while condition
    body
end
```

---

## For Loop (Current Spec)

```jua id="for1"
for iterator from start to end
    body
end
```

---

### Example

```jua id="for2"
for i from 1 to 10
    print(i)
end
```

---

### Rules

* Inclusive range
* Iterator is immutable
* Step is implicit (+1)

---

# NEWLINE Handling

NEWLINE acts as a statement separator.

However:

* Inside blocks → NEWLINE is optional
* Multiple NEWLINEs are collapsed

---

# Block Nesting

Blocks may be nested arbitrarily.

---

## Example

```jua id="n1"
function outer()
    if true
        while false
            return 1
        end
    end
end
```

---

# Imports and Exports

## Import

```jua id="imp1"
import moduleName
```

---

## Export

```jua id="exp1"
export function name()
```

or

```jua id="exp2"
export object Name
```

---

# Visibility Scope

All declarations are:

* Module-scoped by default
* Exported explicitly

---

# Syntax Ambiguity Rules

## Rule 1: Keyword precedence

Keywords override identifiers.

---

## Rule 2: Block closure

`end` always closes nearest open block.

---

## Rule 3: Expression resolution

Expressions inside statements follow expression grammar spec.

---

# Example Full Program

```jua id="prog1"
import math

function add(a, b)
    return a + b
end

object Student
    create name

    function greet()
        return "Hello " + self.name
    end
end

test Greeting
    create s = Student("Ana")
    assert(s.greet() == "Hello Ana")
end

for i from 1 to 3
    print(i)
end
```

---

# Parser Hierarchy

```text id="ph1"
program
  → declarations
      → statements
          → expressions
```

---

# Non-Goals

This document does NOT define:

* Tokenization (lexer spec)
* Operator precedence (operators spec)
* Expression internals (expressions spec)
* Runtime behavior
* Memory model
* Type checking rules

---

# Compliance

A conforming implementation MUST:

* Parse all declared constructs
* Respect block structure using `end`
* Support nesting
* Enforce grammar rules
* Reject invalid syntax
