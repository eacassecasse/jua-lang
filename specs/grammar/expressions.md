# Expressions

Version: 0.1 Draft
Status: Proposed

---

# Purpose

This document defines expressions in Jua.

Expressions are constructs that produce values and form the basis of:

* Arithmetic computation
* Logical evaluation
* Function calls
* Object creation
* Property access
* Method invocation

Expressions are the core input to the parser’s AST generation.

---

# Design Philosophy

Jua expressions follow the principle:

> Everything that produces a value is an expression.

However, for simplicity in 0.1, some constructs (like assignment) are intentionally statement-level.

---

# Expression Classification

Jua defines the following expression types:

```text id="c1"
Literal Expression
Identifier Expression
Binary Expression
Unary Expression
Grouping Expression
Function Call Expression
Object Creation Expression
Property Access Expression
Method Call Expression
```

---

# Literal Expressions

Literal values are expressions that evaluate to themselves.

## Supported Literals

```text id="c2"
integer
float
string
boolean
null
```

---

## Examples

```jua id="e1"
10
3.14
"hello"
true
null
```

---

# Identifier Expressions

Identifiers evaluate to variable values.

Example:

```jua id="e2"
age
```

---

# Grouping Expressions

Parentheses control evaluation order.

```jua id="e3"
(2 + 3) * 4
```

---

# Unary Expressions

Unary operators operate on a single operand.

## Supported Unary Operators

```text id="u1"
-
not
```

---

## Examples

```jua id="e4"
-not true
-10
```

---

# Binary Expressions

Binary expressions combine two operands.

## Supported Operators

Defined in:

```text id="ref1"
specs/grammar/operators.md
```

---

## Example

```jua id="e5"
2 + 3
age == 18
```

---

## Structure

```text id="ast1"
left OP right
```

---

# Function Call Expressions

Functions are first-class callable expressions.

## Syntax

```jua id="f1"
functionName(arg1, arg2)
```

---

## Example

```jua id="e6"
add(2, 3)
```

---

## Rules

* Arguments are evaluated left to right
* Functions must be defined or imported
* Parentheses are mandatory

---

# Object Creation Expressions

Objects are instantiated using constructor syntax.

## Syntax

```jua id="o1"
ObjectName(...)
```

---

## Example

```jua id="e7"
Student("Ana", 20)
```

---

## Behavior

This is equivalent to:

```jua id="e8"
create student = Student("Ana", 20)
```

but used inline.

---

# Property Access Expressions

Access object fields using dot notation.

## Syntax

```jua id="p1"
object.property
```

---

## Example

```jua id="e9"
student.name
```

---

# Method Call Expressions

Methods are invoked on objects.

## Syntax

```jua id="m1"
object.method(args)
```

---

## Example

```jua id="e10"
student.printName()
```

---

# Chained Expressions

Expressions can be chained.

## Example

```jua id="e11"
student.getProfile().name
```

---

# Precedence Integration

Expression evaluation follows:

1. Unary
2. Multiplicative
3. Additive
4. Comparison
5. Equality
6. Logical AND
7. Logical OR

Defined in:

```text id="ref2"
specs/grammar/operators.md
```

---

# Expression Grammar (Informal)

```text id="g1"
expression
    = literal
    | identifier
    | unary
    | binary
    | grouping
    | functionCall
    | objectCreation
    | propertyAccess
    | methodCall
```

---

# Evaluation Rules

## Left-to-right evaluation

Function arguments are evaluated in order.

---

## Short-circuiting

Logical expressions:

```jua id="e12"
a and b
a or b
```

follow short-circuit rules.

---

# Invalid Expressions

## Invalid function call

```jua id="e13"
add 2, 3
```

Error:

```text id="err1"
Missing parentheses in function call
```

---

## Invalid property access

```jua id="e14"
student name
```

Error:

```text id="err2"
Expected '.' for property access
```

---

## Invalid binary usage

```jua id="e15"
true + 5
```

Error:

```text id="err3"
Type mismatch in binary expression
```

---

# Expression vs Statement Boundary

Expressions can appear inside:

```text id="s1"
function bodies
object methods
return statements
assignments
```

But not as standalone constructs unless valid as statements.

---

# Example Program Using Expressions

```jua id="prog1"
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
```

---

# AST Construction Requirement

A conforming compiler MUST:

* Convert each expression into a node
* Respect operator precedence
* Preserve evaluation order
* Represent calls, access, and creation distinctly

---

# Compiler Boundary

```text id="pipe1"
Tokens
  ↓
Expressions (this spec)
  ↓
AST
  ↓
Semantic Analysis
```

---

# Non-Goals

This document does NOT define:

* Statement syntax (control flow covered elsewhere)
* Variable declaration rules
* Module structure
* Type system rules (only referenced)

---

# Compliance

A conforming implementation MUST:

* Support all expression forms listed
* Enforce operator precedence
* Reject invalid expressions
* Support chaining
* Preserve evaluation order
