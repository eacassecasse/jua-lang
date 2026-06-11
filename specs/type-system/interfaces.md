# Interfaces

Version: 0.1 Draft

Status: Proposed

---

# Purpose

This document defines interfaces in the Jua programming language.

Interfaces provide a mechanism for describing behavioral contracts that can be implemented by objects and user-defined types.

Interfaces define **what a type must provide**, not how it must provide it.

---

# Design Philosophy

Jua follows the principle:

> Contracts should be explicit.

A type should only satisfy an interface when it explicitly declares its intention to do so.

This improves:

* Readability
* Discoverability
* Refactoring safety
* Tooling support
* Diagnostic quality

---

# Design Goals

Interfaces should:

* Define behavior contracts
* Remain easy to understand
* Support static analysis
* Enable polymorphism
* Avoid accidental compatibility
* Support future generics

---

# Nominal Typing Model

Jua uses **nominal interface typing**.

A type satisfies an interface only when it explicitly declares implementation.

---

Example:

```jua
interface Drawable

    function draw()

end
```

---

Valid:

```jua
object Circle implements Drawable

    function draw()

        print("Drawing circle")

    end

end
```

---

Invalid:

```jua
object Circle

    function draw()

        print("Drawing circle")

    end

end
```

Even though `draw()` exists, the type does not implement `Drawable`.

---

# Interface Declaration

General form:

```jua
interface InterfaceName

    declarations

end
```

---

Example:

```jua
interface Printable

    function print()

end
```

---

# Naming Convention

Interface names should use PascalCase.

Example:

```jua
interface Serializable
```

Preferred.

---

Example:

```jua
interface serializable
```

Discouraged.

---

# Interface Members

Version 0.1 allows:

```text
Function declarations
```

inside interfaces.

---

Example:

```jua
interface Printable

    function print()

end
```

---

# Method Signatures

Interface methods declare signatures only.

No implementation is permitted.

---

Valid:

```jua
interface Logger

    function log(message)

end
```

---

Invalid:

```jua
interface Logger

    function log(message)

        print(message)

    end

end
```

Compiler Error:

```text
Interface methods cannot contain implementations.
```

---

# Implementing Interfaces

Types implement interfaces using:

```jua
implements
```

---

Example:

```jua
object FileLogger implements Logger

    function log(message)

        print(message)

    end

end
```

---

# Multiple Interface Implementation

A type may implement multiple interfaces.

Example:

```jua
object User

    implements Printable, Serializable

end
```

---

# Implementation Requirements

A type must implement every interface member.

---

Example:

```jua
interface Printable

    function print()

end
```

---

Invalid:

```jua
object Student implements Printable

end
```

Compiler Error:

```text
Type 'Student' does not implement:

print()
```

---

# Signature Matching

Implementations must match interface signatures.

---

Valid:

```jua
interface Logger

    function log(message)

end
```

```jua
object ConsoleLogger implements Logger

    function log(message)

    end

end
```

---

Invalid:

```jua
object ConsoleLogger implements Logger

    function log()

    end

end
```

Compiler Error:

```text
Method signature does not match interface contract.
```

---

# Interface Inheritance

Interfaces may extend other interfaces.

---

Example:

```jua
interface Printable

    function print()

end
```

```jua
interface Reportable extends Printable

    function report()

end
```

---

Result:

```text
Reportable requires:

print()
report()
```

---

# Multiple Interface Inheritance

Interfaces may extend multiple interfaces.

---

Example:

```jua
interface Printable

    function print()

end
```

```jua
interface Serializable

    function serialize()

end
```

```jua
interface Document

    extends Printable, Serializable

end
```

---

# Interface Variables

Variables may be declared using interface types.

---

Example:

```jua
create printer : Printable
```

---

Valid assignment:

```jua
create printer : Printable = ConsolePrinter()
```

provided:

```jua
ConsolePrinter implements Printable
```

---

# Polymorphism

Interfaces support polymorphic behavior.

---

Example:

```jua
interface Printable

    function print()

end
```

---

```jua
object Student implements Printable

    function print()

        print("Student")

    end

end
```

---

```jua
object Teacher implements Printable

    function print()

        print("Teacher")

    end

end
```

---

```jua
function output(item : Printable)

    item.print()

end
```

Both implementations are valid.

---

# Interface Equality

Interfaces do not affect equality semantics.

Equality remains defined by:

```text
specs/type-system/equality.md
```

---

Example:

```jua
studentA == studentB
```

continues to use value equality rules.

---

# Visibility

Interfaces may be exported.

---

Example:

```jua
export interface Printable

    function print()

end
```

---

Non-exported interfaces remain private to the module.

---

# Circular Interface Dependencies

Circular inheritance is prohibited.

---

Invalid:

```jua
interface A extends B
```

```jua
interface B extends A
```

Compiler Error:

```text
Circular interface inheritance detected.
```

---

# Compiler Representation

Interfaces define contracts within the semantic model.

They do not create executable code.

---

Conceptually:

```text
Interface Declaration

        ↓

Semantic Contract

        ↓

Type Validation

        ↓

Code Generation
```

---

# Diagnostics

Diagnostics should identify:

* Missing implementations
* Invalid signatures
* Unknown interfaces
* Circular inheritance
* Duplicate declarations

---

Example:

```text
Type 'Student' does not implement:

print()
```

---

# Educational Guidance

Educational materials should emphasize:

```text
Interfaces define what must exist.

Objects define how it works.
```

---

Preferred:

```jua
interface Printable

    function print()

end
```

```jua
object Student implements Printable

    function print()

    end

end
```

---

# Future Evolution

Future versions may introduce:

```text
Default interface methods
Generic interfaces
Variance support
Interface constraints
Marker interfaces
Associated types
```

These features must remain compatible with the nominal interface model.

---

# Compliance

A conforming implementation must implement the interface behavior defined in this specification.
