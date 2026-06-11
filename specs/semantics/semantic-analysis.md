# Semantic Analysis

Version: 0.1 Draft
Status: Proposed

---

# Purpose

This document defines the semantic analysis phase of the Jua compiler.

Semantic analysis is responsible for validating that a syntactically correct program is also **meaningful and valid according to language rules**.

It operates on the AST produced by the parser.

---

# Position in Compiler Pipeline

```text id="p1"
Source Code
  ↓
Lexer
  ↓
Parser
  ↓
AST
  ↓
Semantic Analysis   ← (this stage)
  ↓
IR / Code Generation
```

---

# Design Philosophy

Semantic analysis in Jua follows the principle:

> Syntax answers "is this written correctly?"
> Semantics answers "does this make sense?"

The system must:

* Be deterministic
* Be statically analyzable where possible
* Fail early with clear diagnostics
* Avoid runtime surprises when statically detectable

---

# Semantic Analysis Phases

Semantic analysis is divided into ordered phases:

```text id="ph1"
1. Symbol Resolution
2. Scope Resolution
3. Type Checking
4. Mutability Validation
5. Interface Validation
6. Trait Composition Validation
7. Control Flow Validation (minimal in 0.1)
```

Each phase depends on the previous one.

---

# 1. Symbol Resolution

## Purpose

Map identifiers to declarations.

---

## Example

```jua id="e1"
create age = 10
print(age)
```

Semantic rule:

```text id="r1"
age → variable declaration reference
```

---

## Failure Case

```jua id="e2"
print(age)
```

Error:

```text id="err1"
Undefined symbol: age
```

---

# 2. Scope Resolution

## Purpose

Ensure identifiers are resolved in the correct scope.

---

## Scope Types

```text id="s1"
Global scope
Function scope
Block scope
Object scope
Trait scope
```

---

## Example

```jua id="e3"
function test()
    create x = 10
end

print(x)
```

Error:

```text id="err2"
x is not visible in this scope
```

---

# 3. Type Checking

## Purpose

Ensure type correctness of operations.

---

## Example

```jua id="e4"
create x = 10 + "hello"
```

Error:

```text id="err3"
Type mismatch: integer + string
```

---

## Valid Example

```jua id="e5"
create x = 10 + 5
```

---

# Type Rules Integration

Types defined in:

```text id="t1"
specs/type-system/
```

are enforced here.

---

# 4. Mutability Validation (ADR-0014)

## Purpose

Enforce immutable-by-default rule.

---

## Example

```jua id="e6"
create x = 10
x = 20
```

Valid only if:

```text id="r2"
x is mutable
```

---

## Invalid Case

```jua id="e7"
create x = 10
x = 20
```

Error:

```text id="err4"
Cannot reassign immutable variable: x
```

---

## Valid Case

```jua id="e8"
create mutable x = 10
x = 20
```

---

# 5. Interface Validation

## Purpose

Ensure objects correctly implement interfaces.

---

## Example

```jua id="e9"
interface Printable
    function print()
end
```

```jua id="e10"
object Student
    implements Printable
end
```

Error:

```text id="err5"
Missing implementation: print()
```

---

# 6. Trait Composition Validation

## Purpose

Ensure trait usage is valid and conflict-free.

---

## Example

```jua id="e11"
trait A
    function save()
end

trait B
    function save()
end

object X
    uses A
    uses B
end
```

Error:

```text id="err6"
Trait conflict detected: save()
```

---

## Resolution Rule

Conflicts must be resolved explicitly in object.

---

# 7. Control Flow Validation (Minimal 0.1)

## Purpose

Validate structural correctness of control flow.

---

## Rules

* `break` / `continue` (future) must be inside loops
* `return` must be inside function
* `if`, `while`, `for` must have valid conditions

---

## Example

```jua id="e12"
return 10
```

Outside function:

```text id="err7"
return used outside function scope
```

---

# Symbol Table Model

Semantic analysis maintains symbol tables:

```text id="st1"
Global Symbols
Function Symbols
Object Symbols
Trait Symbols
Block Symbols
```

---

## Example

```jua id="e13"
function add(a, b)
    create result = a + b
    return result
end
```

Symbol table:

```text id="st2"
add → function
a → parameter
b → parameter
result → local variable
```

---

# Error Handling Model

Semantic errors MUST:

* Stop compilation (for 0.1)
* Provide location (line/column)
* Provide reason
* Avoid cascading noise where possible

---

# Example Error Format

```text id="errfmt"
Error [Semantic]: Undefined symbol 'x'
  at line 3, column 5
  in function test()
```

---

# Compiler Boundary

```text id="cb1"
Parser Output (AST)
        ↓
Semantic Analyzer
        ↓
Validated AST
        ↓
IR Generation
```

---

# Non-Goals

Semantic analysis does NOT:

* Execute code
* Perform optimization
* Handle runtime memory
* Generate machine code

---

# Compliance Requirements

A conforming compiler MUST:

* Perform all semantic phases in order
* Reject invalid programs
* Enforce type rules
* Enforce mutability rules
* Validate interfaces and traits
* Maintain correct symbol resolution
