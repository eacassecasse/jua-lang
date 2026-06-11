# Objects

Version: 0.1 Draft

Status: Proposed

---

# Purpose

This document defines objects in the Jua programming language.

Objects represent concrete types that encapsulate:

* State
* Behavior
* Composition
* Contracts

Objects serve as the primary mechanism for modeling entities and business concepts.

---

# Design Philosophy

Jua follows the principle:

> Objects represent concrete things.

Objects should be:

* Easy to understand
* Easy to construct
* Easy to compose
* Easy to test

Objects should favor composition through traits rather than inheritance.

---

# Design Goals

Objects should:

* Encapsulate state
* Encapsulate behavior
* Support interfaces
* Support traits
* Support future language evolution
* Remain beginner-friendly

---

# Object Declaration

General form:

```jua
object ObjectName

    members

end
```

---

Example

```jua
object Student

end
```

Valid.

---

# Naming Convention

Object names should use PascalCase.

Preferred:

```jua
object Student
```

---

Discouraged:

```jua
object student
```

---

# Object Members

Version 0.1 supports:

```text
Variables
Functions
```

inside objects.

---

Example

```jua
object Student

    create name
    create age

end
```

Valid.

---

# Object Variables

Variables define object state.

Example:

```jua
object Student

    create name
    create age

end
```

---

Objects created from this definition contain:

```text
name
age
```

---

# Mutable Variables

Objects may contain mutable state.

Example:

```jua
object Student

    create mutable age

end
```

Valid.

---

# Immutable Variables

Variables are immutable unless explicitly declared mutable.

Example:

```jua
object Student

    create name

end
```

Valid.

---

# Object Functions

Objects may define functions.

Example:

```jua
object Student

    function printName()

        print(name)

    end

end
```

Valid.

---

# Self Reference

Version 0.1 introduces:

```text
self
```

as the current object reference.

---

Example

```jua
object Student

    create name

    function printName()

        print(self.name)

    end

end
```

Valid.

---

# Reserved Keyword Update

The introduction of object semantics requires reserving:

```text
object
self
```

These should be added to the language keyword list.

---

# Object Creation

Objects are instantiated using:

```jua
create
```

with constructor invocation syntax.

---

Example

```jua
create student = Student()
```

Valid.

---

# Default Constructor

Every object receives a default constructor when none is defined.

---

Example

```jua
object Student

end
```

Allows:

```jua
create student = Student()
```

---

# Custom Constructors

Version 0.1 introduces:

```jua
function init(...)
```

as the object initialization function.

---

Example

```jua
object Student

    create name

    function init(name)

        self.name = name

    end

end
```

---

Usage

```jua
create student = Student("Ana")
```

---

# Constructor Rules

An object may define:

```text
Zero or one init()
```

function.

---

Invalid

```jua
object Student

    function init()

    end

    function init(name)

    end

end
```

Compiler Error:

```text
Multiple init() definitions are not allowed.
```

---

# Object Visibility

Objects may be exported.

---

Example

```jua
export object Student

end
```

Valid.

---

Non-exported objects remain module-private.

---

# Interface Implementation

Objects implement interfaces using:

```jua
implements
```

---

Example

```jua
object Student

    implements Printable

end
```

---

Objects must satisfy all interface requirements.

---

# Multiple Interface Implementation

Valid:

```jua
object Student

    implements Printable, Serializable

end
```

---

# Trait Composition

Objects compose reusable functionality through:

```jua
uses
```

---

Example

```jua
object Student

    uses Timestamped
    uses Auditable

end
```

Valid.

---

# Multiple Traits

Objects may use multiple traits.

---

Example

```jua
object Student

    uses Timestamped
    uses Loggable
    uses Auditable

end
```

---

# Inheritance

Version 0.1 does not support object inheritance.

---

Invalid

```jua
object Student

    extends Person

end
```

Compiler Error:

```text
Object inheritance is not supported.
```

---

# Rationale

Jua adopts:

```text
Composition over inheritance
```

as defined by ADR-0006.

---

# Object Equality

Objects use structural equality.

---

Example

```jua
Student(
    name: "Ana",
    age: 20
)
==
Student(
    name: "Ana",
    age: 20
)
```

Result:

```text
true
```

---

Object equality follows:

```text
specs/type-system/equality.md
```

---

# Object Identity

Version 0.1 does not define identity comparison.

Future versions may introduce:

```jua
a is b
```

---

# Method Invocation

Methods are called using dot notation.

---

Example

```jua
student.printName()
```

Valid.

---

# Property Access

Properties are accessed using dot notation.

---

Example

```jua
student.name
```

Valid.

---

# Compiler Representation

Conceptually:

```text
Object Definition

        ↓

Type Definition

        ↓

Semantic Analysis

        ↓

Instantiation

        ↓

Runtime Object
```

---

# Diagnostics

Diagnostics should identify:

* Duplicate members
* Unknown traits
* Unknown interfaces
* Invalid constructors
* Invalid inheritance attempts

---

Example

```text
Object inheritance is not supported.
```

---

# Educational Guidance

Beginners should think of objects as:

```text
Blueprints for creating things.
```

Example:

```jua
object Student

    create name

end
```

creates a blueprint.

---

```jua
create student = Student()
```

creates a concrete instance.

---

# Future Evolution

Future versions may introduce:

```text
Named constructors
Object literals
Generic objects
Object serialization
Reflection
Metadata
```

These additions must remain compatible with Version 0.1 object semantics.

---

# Compliance

A conforming implementation must implement object behavior as defined in this specification.
