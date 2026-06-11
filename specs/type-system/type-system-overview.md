# Type System Overview

Version: 0.1 Draft

---

# Purpose

This document defines the foundational principles of the Jua type system.

The Jua type system aims to balance:

* Educational accessibility
* Readability
* Safety
* Tooling support
* Enterprise maintainability

Jua adopts a gradual typing model that allows developers to begin with dynamic code and progressively introduce stronger type guarantees.

---

# Design Principles

The Jua type system is guided by the following principles.

## Progressive Complexity

Type annotations should not be required for beginners.

Developers should be able to write useful programs without understanding advanced type theory.

---

## Explicit Safety

When developers choose to introduce types, the compiler should provide stronger guarantees and diagnostics.

---

## Type Inference First

The compiler should infer types whenever sufficient information is available.

Unnecessary type annotations should be avoided.

---

## Predictable Behavior

Type behavior should be understandable from reading the source code.

Implicit conversions should be minimized.

---

## Tooling Friendly

The type system should support:

* Diagnostics
* Refactoring
* IDE completion
* Static analysis

---

# Gradual Typing

Jua supports both inferred and explicitly declared types.

Example:

```jua
create age = 25
```

The compiler infers:

age : int

Equivalent to:

```jua
create age: int = 25
```

---

# Dynamic Development

Developers may omit type annotations during early development.

Example:

```jua
create student = {
    name: "Ana",
    age: 20
}
```

The compiler infers the structure from the assigned value.

---

# Static Development

Developers may define explicit contracts.

Example:

```jua
interface Student
    name: string
    age: int
end

create student: Student = {
    name: "Ana",
    age: 20
}
```

---

# Type Categories

Version 0.1 defines:

* Primitive Types
* Collection Types
* Object Types
* Interface Types
* Trait Types
* Function Types

---

# Primitive Types

Primitive types represent fundamental values.

Version 0.1 defines:

* int
* float
* bool
* string
* null

---

# Integer Type

Represents whole numbers.

Examples:

```
0
1
25
-10
```
---

# Float Type

Represents decimal numbers.

Examples:

```
3.14
0.5
10.75
```
---

# Boolean Type

Represents logical values.

Valid values:

```
true
false
```

---

# String Type

Represents text values.

Example:

```
"Hello World"
```

---

# Null Type

Represents the absence of a value.

Example:

```
null
```

---

# Type Inference

The compiler infers types from assignments whenever possible.

Example:

```jua
create active = true
```

The inferred type is:

```
bool
```

---

Example:

```jua
create name = "Ana"
```

The inferred type is:

```
string
```

---

# Explicit Type Annotations

Developers may declare types explicitly.

Example:

```jua
create age: int = 25
```

---

# Type Consistency

Assignments must respect declared types.

Valid:

```jua
create age: int = 25
```

Invalid:

```jua
create age: int = "twenty five"
```

---

# Type Responsibilities

Interfaces describe structure.

Traits describe behavior.

Objects store data.

These concepts serve different purposes and should not be used interchangeably.

---

# Reassignment Rules

Reassigned values must remain compatible with the declared type.

Valid:

```jua
create mutable age: int = 20

age = 25
```

Invalid:

```jua
create mutable age: int = 20

age = "twenty"
```

---

# Type Compatibility

Version 0.1 uses nominal type compatibility for interfaces.

Two types are considered compatible when explicitly declared to be compatible.

Structural compatibility is not supported in Version 0.1.

---

# Implicit Conversions

Version 0.1 minimizes implicit conversions.

Example:

```jua
create age = 25

create text = age
```

Invalid.

The conversion must be explicit.

---

Valid:

```jua
create text = string(age)
```

---

# Numeric Conversion

Numeric conversions require explicit intent.

Example:

```jua
create value: float = 10.5

create whole = int(value)
```

---

# Equality Rules

Values may only be compared when comparison semantics are defined.

Valid:

```
5 == 5

"ana" == "ana"

true == false
```

---

# Type Errors

Type errors must be reported during compilation whenever possible.

Example:

```jua
create age: int = "hello"
```

Compiler Error:

```
Expected type 'int'.

Received type 'string'.
```

---

# Runtime Type Errors

Runtime type errors should be minimized through compile-time analysis.

When runtime type errors occur, implementations should provide clear diagnostics.

---

# Type Safety Goals

The Jua type system seeks to:

* Prevent accidental misuse of values.
* Improve diagnostics.
* Enable safe refactoring.
* Support large-scale software development.

---

# Future Evolution

Future versions may introduce:

* Generics
* Union Types
* Optional Types
* Pattern Matching
* Algebraic Data Types
* Advanced Type Inference

Such features must preserve readability and educational accessibility.

---

# Compliance

A conforming implementation must enforce all type rules described in this specification and produce diagnostics for violations.

