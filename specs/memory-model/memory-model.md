# Memory Model

## Purpose

This document defines how values, variables, objects, and collections behave in memory within Jua 0.1.

The goal is to establish predictable semantics while maintaining a simple mental model suitable for education and practical software development.

This specification complements:

* ADR-0004: Local by Default Variables
* ADR-0014: Immutable by Default Variables
* ADR-0016: Value-Based Equality
* ADR-0017: Closure Deferral

---

# Design Principles

The Jua 0.1 memory model is based on the following principles:

* Simplicity over optimization.
* Predictable behavior.
* Explicit mutability.
* Immutable bindings by default.
* Mutable composite values unless otherwise specified.
* No hidden lifetime extension mechanisms.

---

# Memory Categories

Values belong to one of two categories:

* Value Types
* Reference Types

---

# Value Types

Value types store their value directly.

The following are value types:

* integer
* float
* double
* boolean

Example:

```jua
create age = 20
```

Assignment copies the value.

Example:

```jua
create a = 10
create b = a
```

After assignment:

```text
a = 10
b = 10
```

Changing one variable does not affect the other.

---

# Reference Types

Reference types refer to an underlying object stored elsewhere.

The following are reference types:

* string
* list
* object

Example:

```jua
create students = ["Ana", "Maria"]
```

The variable stores a reference to the list.

---

# Variable Bindings

Variables do not own values.

Variables bind names to values.

Example:

```jua
create age = 20
```

The identifier:

```text
age
```

is a binding to the value:

```text
20
```

---

# Immutable by Default

Variables declared with:

```jua
create
```

cannot be reassigned.

Example:

```jua
create age = 20

age = 30
```

Invalid.

Compiler error:

```text
Cannot reassign immutable variable.
```

---

# Explicit Mutability

Variables intended for reassignment must be declared using the mutable variable declaration mechanism defined by the language specification.

Example:

```jua
create mutable age = 20

age = 30
```

Valid.

---

# Mutable Composite Values

Lists and objects remain mutable even when referenced through immutable bindings.

Example:

```jua
create names = ["Ana"]

names.add("Maria")
```

Valid.

The binding remains immutable.

Example:

```jua
names = []
```

Invalid.

---

# Object Mutability

Objects may change internal state.

Example:

```jua
object Counter

    create mutable value: integer = 0

end
```

Example usage:

```jua
create counter = Counter()

counter.value = 1
```

Valid.

The object changes.

The variable binding does not.

---

# Parameter Passing

Jua uses pass-by-value semantics.

For value types:

```jua
function increment(number)

end
```

the value is copied.

For reference types:

```jua
function process(items)

end
```

the reference is copied.

The underlying object remains shared.

Example:

```jua
function addName(names)

    names.add("Maria")

end
```

The caller observes the modification.

---

# Object Identity

Object identity is not exposed in Jua 0.1.

Programs may compare values using:

```jua
==
```

but cannot compare references for identity.

See ADR-0016.

---

# Lifetimes

Variables exist within the scope where they are declared.

Scopes include:

* Function scope
* Block scope
* Module scope

When execution leaves a scope, variables declared in that scope cease to exist.

---

# Closures

Closures are not part of Jua 0.1.

Variables may not outlive their declaring scope through capture mechanisms.

See ADR-0017.

---

# Memory Safety Goals

Jua 0.1 aims to provide:

* No manual memory management.
* No exposed pointers.
* No pointer arithmetic.
* No user-controlled allocation.
* No user-controlled deallocation.

Memory management strategy is considered a runtime implementation detail.

---

# Unsupported Features

The following are intentionally excluded:

* Closures
* Pointer types
* Pointer arithmetic
* Manual memory management
* Reference identity operators
* Ownership systems
* Borrow checking

---

# Related ADRs

* ADR-0004: Local by Default Variables
* ADR-0014: Immutable by Default Variables
* ADR-0016: Value-Based Equality
* ADR-0017: Closure Deferral

---

# Related Specifications

* specs/type-system/type-system.md
* specs/functions/functions.md
* specs/semantics/scope-resolution.md

