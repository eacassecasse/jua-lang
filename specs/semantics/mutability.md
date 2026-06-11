# Mutability Model

Version: 0.1 Draft
Status: Proposed

---

# Purpose

This document defines how mutability is represented and enforced in Jua.

It specifies rules for:

* Variable immutability
* Mutable declarations
* Reassignment behavior
* Object field mutability
* Scope interaction with mutability rules

This implements ADR-0014 at the semantic level.

---

# Design Philosophy

Jua mutability follows the principle:

> Immutability by default prevents accidental state changes; mutability must be explicit.

The system must:

* Prevent unintended reassignment
* Make state changes visible in code
* Avoid hidden mutation semantics
* Be simple for beginners to reason about

---

# Core Principle

All bindings are immutable unless explicitly declared mutable.

---

# Variable Mutability Rules

## Rule 1: Default Immutability

```jua id="e1"
create x = 10
```

x is immutable.

---

## Rule 2: Explicit Mutability

```jua id="e2"
create mutable x = 10
```

x is mutable.

---

# Reassignment Rules

## Immutable Variable Reassignment

Invalid:

```jua id="e3"
create x = 10
x = 20
```

Error:

```text id="err1"
Cannot reassign immutable variable: x
```

---

## Mutable Variable Reassignment

Valid:

```jua id="e4"
create mutable x = 10
x = 20
```

---

# Mutability in Scope Resolution

Mutability is bound to the symbol table entry.

Each identifier stores:

```text id="s1"
name
type
mutability flag
scope level
```

---

# Function Parameter Mutability

## Rule

Function parameters are immutable by default.

---

Example:

```jua id="e5"
function test(x)
    x = 10
end
```

Error:

```text id="err2"
Cannot reassign immutable parameter: x
```

---

## Mutable Parameters (Not allowed in 0.1)

```text id="r1"
Jua 0.1 does NOT support mutable parameters
```

---

# Object Field Mutability

## Rule 1: Object fields are immutable by default

```jua id="e6"
object Student
    create name
end
```

---

## Rule 2: Mutable fields

```jua id="e7"
object Student
    create mutable age
end
```

---

## Field Reassignment Rules

### Immutable field

```jua id="e8"
student.name = "Ana"
```

Error:

```text id="err3"
Cannot modify immutable field: name
```

---

### Mutable field

```jua id="e9"
student.age = 20
```

Valid.

---

# Trait Mutability Rules

Traits follow object rules.

---

## Example

```jua id="e10"
trait Timestamped
    create mutable lastUpdated
end
```

---

## Rule

Trait-defined fields retain mutability rules when injected into objects.

---

# Assignment vs Declaration Distinction

## Declaration

```jua id="e11"
create x = 10
```

Creates binding.

---

## Assignment

```jua id="e12"
x = 20
```

Modifies existing binding (only if mutable).

---

# Scope Interaction

Mutability is resolved per scope binding.

---

## Example

```jua id="e13"
create x = 10

function test()
    create mutable x = 20
    x = 30
end
```

Valid.

Outer `x` is unaffected.

---

# Shadowing and Mutability

Shadowed variables may have different mutability.

---

## Example

```jua id="e14"
create x = 10

function test()
    create mutable x = 20
    x = 30
end
```

Valid.

---

# Invalid Shadow Mutation Leakage

Mutability never crosses scope boundaries.

---

# Type + Mutability Interaction

Mutability does NOT affect type.

---

Example:

```jua id="e15"
create mutable x = 10
```

Type:

```text id="t1"
integer
```

---

# Control Flow Interaction

Mutability is enforced inside:

* if blocks
* loops
* functions

---

Example:

```jua id="e16"
if true
    create x = 10
end

x = 20
```

Error:

```text id="err4"
x is not visible in this scope
```

---

# Reassignment Rules Summary

| Case                             | Allowed |
| -------------------------------- | ------- |
| immutable variable reassignment  | ❌       |
| mutable variable reassignment    | ✅       |
| immutable parameter reassignment | ❌       |
| mutable parameter (future)       | ❌ (0.1) |
| immutable field reassignment     | ❌       |
| mutable field reassignment       | ✅       |

---

# Symbol Table Extension

Each symbol entry includes:

```text id="s2"
identifier
type
mutability (immutable | mutable)
scope
```

---

# Error Reporting Requirements

Mutability errors MUST include:

* Symbol name
* Mutability state
* Location
* Attempted operation

---

Example:

```text id="errfmt"
Error [Mutability]: Cannot reassign immutable variable 'x'
  declared at line 1
  attempted reassignment at line 3
```

---

# Semantic Pipeline Position

```text id="p1"
AST
 ↓
Scope Resolution
 ↓
Type Checking
 ↓
Mutability Validation   ← (this stage)
 ↓
Validated AST
```

---

# Non-Goals

This document does NOT define:

* Ownership model
* Borrow checking
* Concurrency safety
* Runtime immutability enforcement beyond static checks

---

# Future Extensions

Later versions may introduce:

```text id="f1"
ref mutability
immutable references
borrow semantics
```

but these are explicitly NOT part of 0.1.

---

# Compliance

A conforming compiler MUST:

* Track mutability per symbol
* Enforce immutability by default
* Reject invalid reassignment
* Preserve scope-based mutability isolation
* Apply rules to objects, traits, and functions
