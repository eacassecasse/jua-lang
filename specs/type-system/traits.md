# Traits

Version: 0.1 Draft

Status: Proposed

---

# Purpose

This document defines traits in the Jua programming language.

Traits provide a mechanism for reusing state and behavior across multiple objects without relying on inheritance.

Traits are intended to be the primary composition and code-reuse mechanism in Jua.

---

# Design Philosophy

Jua follows the principle:

> Prefer composition over inheritance.

Traits allow reusable functionality to be composed into objects while avoiding the complexity and fragility often associated with inheritance hierarchies.

---

# Design Goals

Traits should:

* Promote composition
* Encourage reuse
* Reduce duplication
* Remain easy to understand
* Support static analysis
* Support future language evolution
* Avoid inheritance complexity

---

# Core Concept

A trait is a reusable unit of:

```text
State
and/or
Behavior
```

Traits are not concrete types.

Traits cannot be instantiated directly.

---

# Trait Declaration

General form:

```jua
trait TraitName

    members

end
```

---

Example:

```jua
trait Timestamped

    create createdAt
    create updatedAt

end
```

---

# Trait Naming

Trait names should use PascalCase.

Preferred:

```jua
trait Serializable
```

Discouraged:

```jua
trait serializable
```

---

# Trait Members

Version 0.1 permits:

```text
Variables
Functions
```

inside traits.

---

# State-Only Traits

Example:

```jua
trait Timestamped

    create createdAt
    create updatedAt

end
```

Valid.

---

# Behavior-Only Traits

Example:

```jua
trait Loggable

    function log(message)

        print(message)

    end

end
```

Valid.

---

# State and Behavior Traits

Example:

```jua
trait AuditTrail

    create mutable lastLogin

    function updateLastLogin()

        lastLogin = currentTime()

    end

end
```

Valid.

---

# Trait Usage

Objects include traits using:

```jua
uses
```

---

Example:

```jua
object Student

    uses Timestamped

end
```

---

# Multiple Trait Usage

Objects may use multiple traits.

Example:

```jua
object Student

    uses Timestamped
    uses Loggable
    uses AuditTrail

end
```

Valid.

---

# Trait Composition Model

Conceptually:

```text
Trait Members

        ↓

Object Composition

        ↓

Object Members
```

The composed members become part of the object's available functionality.

---

# Trait Instantiation

Traits cannot be instantiated.

---

Invalid:

```jua
create audit = AuditTrail()
```

Compiler Error:

```text
Traits cannot be instantiated.
```

---

# Trait Visibility

Traits may be exported.

---

Example:

```jua
export trait Loggable

    function log(message)

    end

end
```

Valid.

---

Non-exported traits remain private to their module.

---

# Traits and Interfaces

Traits may implement interfaces.

---

Example:

```jua
interface Printable

    function print()

end
```

---

```jua
trait PrintableTrait

    implements Printable

    function print()

        print("Default")

    end

end
```

Valid.

---

# Interface Satisfaction Through Traits

Objects may satisfy interfaces through trait composition.

---

Example:

```jua
object Student

    uses PrintableTrait

end
```

Provided:

```jua
PrintableTrait implements Printable
```

the object satisfies:

```text
Printable
```

---

# Explicit Interface Implementation

Objects may still implement interfaces directly.

---

Example:

```jua
object Student

    implements Printable

    function print()

        print("Student")

    end

end
```

Valid.

---

# Trait Methods

Trait methods provide reusable implementations.

---

Example:

```jua
trait Loggable

    function log(message)

        print(message)

    end

end
```

---

Objects gain access to the method through composition.

---

Example:

```jua
object Student

    uses Loggable

end
```

---

Valid:

```jua
student.log("Hello")
```

---

# Trait State

Trait variables become part of the object.

---

Example:

```jua
trait Timestamped

    create createdAt

end
```

---

```jua
object Student

    uses Timestamped

end
```

---

Valid:

```jua
student.createdAt
```

---

# Mutability Rules

Trait variables follow normal mutability rules.

---

Example:

```jua
trait AuditTrail

    create mutable lastLogin

end
```

Valid.

---

Example:

```jua
trait Constants

    create version

end
```

Immutable by default.

---

# Trait Conflict Detection

Conflicting members are prohibited.

---

Example:

```jua
trait A

    function save()

    end

end
```

---

```jua
trait B

    function save()

    end

end
```

---

```jua
object Student

    uses A
    uses B

end
```

Compiler Error:

```text
Trait conflict detected:

save()
```

---

# Explicit Conflict Resolution

Objects must explicitly resolve conflicts.

---

Example:

```jua
object Student

    uses A
    uses B

    function save()

        ...

    end

end
```

Valid.

---

# State Conflicts

Variable conflicts are prohibited.

---

Example:

```jua
trait A

    create id

end
```

---

```jua
trait B

    create id

end
```

---

```jua
object Student

    uses A
    uses B

end
```

Compiler Error:

```text
Trait conflict detected:

id
```

---

# Trait Hierarchies

Version 0.1 does not support trait inheritance.

---

Invalid:

```jua
trait Auditable

    extends Timestamped

end
```

Compiler Error:

```text
Trait inheritance is not supported.
```

---

# Rationale

Trait hierarchies can introduce:

* Complexity
* Ambiguity
* Deep dependency chains

Composition remains the preferred mechanism.

---

# Trait-to-Trait Usage

Version 0.1 does not support:

```jua
trait A

    uses B

end
```

This feature may be considered in future versions.

---

# Trait Equality

Traits do not participate directly in equality evaluation.

Equality remains defined by:

```text
specs/type-system/equality.md
```

---

# Compiler Representation

Traits exist as reusable composition units.

Conceptually:

```text
Trait Definition

        ↓

Semantic Composition

        ↓

Object Construction

        ↓

Code Generation
```

---

# Diagnostics

Diagnostics should identify:

* Unknown traits
* Missing traits
* Trait conflicts
* Invalid trait instantiation
* Invalid trait inheritance
* Duplicate members

---

Example:

```text
Trait conflict detected:

save()
```

---

# Educational Guidance

Educational materials should emphasize:

```text
Interfaces define requirements.

Traits provide reusable functionality.

Objects create concrete behavior.
```

---

Preferred:

```jua
interface Printable

end
```

```jua
trait PrintableTrait

end
```

```jua
object Student

end
```

Each construct has a clear responsibility.

---

# Future Evolution

Future versions may introduce:

```text
Trait aliases
Trait parameters
Generic traits
Trait constraints
Selective composition
Trait composition operators
```

Such features must remain compatible with Version 0.1 trait semantics.

---

# Compliance

A conforming implementation must implement the trait behavior defined in this specification.
