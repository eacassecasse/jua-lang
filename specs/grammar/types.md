# Type System

## Purpose

This document defines the built-in types available in Jua 0.1 and establishes the foundation of the language's type system.

This specification complements:

* ADR-0005: Gradual Typing
* ADR-0016: Value-Based Equality
* ADR-0018: Generics Deferral

The goal is to provide a simple, teachable, and predictable type system suitable for educational use while remaining capable of supporting practical software development.

---

# Type Categories

Jua 0.1 provides two categories of types:

* Primitive Types
* Composite Types

---

# Primitive Types

The following primitive types are part of the language.

## integer

Represents whole numbers.

Examples:

```jua
10
0
-5
1000000
```

Valid operations:

```jua
+
-
*
/
%
```

Examples:

```jua
create total = 10 + 5
```

---

## float

Represents single-precision floating-point numbers.

Examples:

```jua
3.14
0.5
-12.75
```

---

## double

Represents double-precision floating-point numbers.

Examples:

```jua
3.141592653589793
```

The distinction between `float` and `double` is semantic and must be preserved by the compiler.

---

## boolean

Represents logical truth values.

Possible values:

```jua
true
false
```

Boolean expressions must evaluate to a boolean value.

Example:

```jua
if age > 18
```

Valid because:

```jua
age > 18
```

evaluates to a boolean.

Example:

```jua
if age
```

Invalid.

Jua does not perform implicit truthiness conversion.

---

## string

Represents UTF-8 encoded text.

Examples:

```jua
"Hello"
```

```jua
'World'
```

Strings support Unicode characters.

Examples:

```jua
"Olá"
```

```jua
"你好"
```

```jua
"مرحبا"
```

---

# Composite Types

Composite types combine or contain other values.

---

## list

Represents an ordered collection of values.

Examples:

```jua
[1, 2, 3]
```

```jua
["A", "B", "C"]
```

Lists use zero-based indexing according to ADR-0003.

Example:

```jua
names[0]
```

Lists are mutable containers even when referenced by immutable variables.

Example:

```jua
create names = ["Ana"]

names.add("Maria")
```

Valid.

Reassigning the variable remains prohibited:

```jua
names = []
```

Invalid.

---

## object

Represents structured user-defined data.

Example:

```jua
object Student

    create name: string
    create age: integer

end
```

Objects may contain:

* Fields
* Methods
* Trait compositions
* Interface implementations

Objects are reference types.

Equality uses value-based semantics according to ADR-0016.

---

# Type Inference

Jua supports local type inference.

Example:

```jua
create age = 20
```

Compiler inference:

```text
integer
```

Example:

```jua
create active = true
```

Compiler inference:

```text
boolean
```

---

# Explicit Type Declarations

Developers may explicitly declare types.

Example:

```jua
create age: integer = 20
```

Example:

```jua
create name: string = "Jua"
```

---

# Type Compatibility

The compiler must verify type compatibility during semantic analysis.

Valid:

```jua
create age: integer = 20
```

Invalid:

```jua
create age: integer = "Twenty"
```

---

# Equality

All types support value equality through:

```jua
==
```

Examples:

```jua
name == "Jua"
```

```jua
score == 100
```

Identity comparison is not part of Jua 0.1.

See ADR-0016.

---

# Unsupported Features

The following are intentionally excluded from Jua 0.1:

* Generics
* Union Types
* Intersection Types
* Nullable Types
* Type Constraints
* Type Parameters

See ADR-0018.

---

# Related ADRs

* ADR-0003: Zero-Based Indexing
* ADR-0005: Gradual Typing
* ADR-0014: Immutable by Default Variables
* ADR-0016: Value-Based Equality
* ADR-0018: Generics Deferral

---

# Related Specifications

* specs/type-system/type-system.md
* specs/semantics/type-checking.md
* specs/memory-model/memory-model.md

