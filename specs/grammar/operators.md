# Operators

Version: 0.1 Draft
Status: Proposed

---

# Purpose

This document defines all operators in Jua and specifies:

* Operator categories
* Precedence rules
* Associativity rules
* Evaluation behavior
* Parsing implications

Operators directly influence expression parsing and AST structure.

---

# Design Philosophy

Jua operators follow the principle:

> Operators must be unambiguous, consistent, and easy to reason about.

The design prioritizes:

* Predictable evaluation order
* Minimal surprise for beginners
* Simple parser implementation
* Compatibility with expression trees (AST)

---

# Operator Categories

Jua operators are divided into:

```text id="cat1"
Arithmetic
Comparison
Logical
Assignment
```

---

# Arithmetic Operators

```text id="op1"
+
-
*
/
```

---

## Semantics

| Operator | Meaning        |
| -------- | -------------- |
| +        | Addition       |
| -        | Subtraction    |
| *        | Multiplication |
| /        | Division       |

---

## Rules

* `/` performs floating-point division by default
* Integer division is not introduced in 0.1
* Arithmetic operators operate on `integer`, `float`, `double`

---

# Comparison Operators

```text id="op2"
==
!=
<
>
<=
>=
```

---

## Semantics

All comparison operators return:

```text id="bool1"
boolean
```

---

## Rules

* Comparisons are value-based
* No implicit type coercion in 0.1
* Type mismatch is a compile-time error (when resolvable)

---

# Logical Operators

```text id="op3"
and
or
not
```

---

## Semantics

| Operator | Meaning     |
| -------- | ----------- |
| and      | logical AND |
| or       | logical OR  |
| not      | logical NOT |

---

## Evaluation Rules

* `and` / `or` are **short-circuiting**
* `not` is unary

Example:

```jua id="ex1"
true and false
```

→ `false`

---

# Assignment Operator

```text id="op4"
=
```

---

## Semantics

Assignment binds a value to a variable.

Example:

```jua id="ex2"
create age = 10
```

---

## Rules

* Assignment is **not an expression result in 0.1**
* It does not return a value
* It is a statement-level operator

---

# Equality vs Assignment

| Operator | Meaning             |
| -------- | ------------------- |
| =        | assignment          |
| ==       | equality comparison |

---

Invalid:

```jua id="ex3"
if age = 10
```

Compiler Error:

```text id="err1"
Assignment used in expression context
```

---

# Operator Precedence

Higher number = higher precedence.

---

## Precedence Table

| Level | Operators   | Associativity                |
| ----- | ----------- | ---------------------------- |
| 1     | `not`       | Right                        |
| 2     | `* /`       | Left                         |
| 3     | `+ -`       | Left                         |
| 4     | `< > <= >=` | Left                         |
| 5     | `== !=`     | Left                         |
| 6     | `and`       | Left                         |
| 7     | `or`        | Left                         |
| 8     | `=`         | Right (statement-level only) |

---

# Evaluation Rules

## Arithmetic First

```jua id="ex4"
2 + 3 * 4
```

→

```text id="res1"
2 + (3 * 4) = 14
```

---

## Logical Short-Circuit

```jua id="ex5"
false and expensiveCall()
```

→ `expensiveCall()` is NOT executed.

---

```jua id="ex6"
true or expensiveCall()
```

→ `expensiveCall()` is NOT executed.

---

# Associativity Rules

## Left Associative

```text id="as1"
+ - * / < > <= >= == != and or
```

Example:

```jua id="ex7"
10 - 5 - 2
```

→

```text id="res2"
(10 - 5) - 2
```

---

## Right Associative

```text id="as2"
=
not
```

Example:

```jua id="ex8"
a = b = 10
```

Invalid in 0.1 unless explicitly grouped, because assignment is statement-level.

---

# Unary Operators

```text id="un1"
not
-
```

Example:

```jua id="ex9"
not true
```

```jua id="ex10"
-10
```

---

# Type Rules

Operators require type compatibility.

---

## Arithmetic

```text id="ty1"
integer + integer → integer
float + float → float
double + double → double
```

Mixed types may require explicit casting (future spec; currently restricted).

---

## Comparison

Always returns:

```text id="ty2"
boolean
```

---

## Logical

Requires:

```text id="ty3"
boolean operands only
```

---

# Invalid Cases

```jua id="bad1"
10 and 20
```

Error:

```text id="err2"
Logical operator requires boolean operands
```

---

# Expression Tree Implication

Operators define AST structure:

```text id="ast1"
2 + 3 * 4
```

becomes:

```text id="ast2"
    +
   / \
  2   *
     / \
    3   4
```

---

# Parser Requirements

A conforming parser MUST:

* Respect precedence table
* Respect associativity rules
* Enforce type constraints (when resolvable)
* Produce correct AST hierarchy

---

# Non-Goals

This document does NOT define:

* Function call semantics
* Object access semantics
* Control flow evaluation
* Runtime behavior beyond operators

---

# Compliance

A conforming implementation MUST:

* Implement all operators listed
* Respect precedence rules
* Enforce logical short-circuiting
* Reject invalid operand types
