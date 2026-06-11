# Jua Language Specification 0.1

Version: 0.1
Status: Frozen Implementation Target

---

# Purpose

This document defines the complete scope of Jua 0.1.

It serves as the authoritative reference for:

* Compiler implementation
* Language behavior
* Feature inclusion
* Feature exclusion

Any feature not defined in this specification is considered outside the scope of Jua 0.1.

---

# Design Goals

Jua 0.1 is designed to be:

* Simple to learn
* Predictable
* Statically analyzable
* Immutable by default
* Object-oriented
* Readable
* Suitable for beginners while remaining useful for professional software development

---

# Language Principles

Jua follows these principles:

```text
Explicit over implicit
Immutable by default
Strong static typing
Lexical scoping
Nominal interfaces
Traits for reuse
Simple syntax
```

---

# Source File Structure

A Jua source file may contain:

```text
imports
functions
objects
interfaces
traits
tests
top-level executable statements
```

---

# Comments

## Single-line Comments

Syntax:

```jua
# This is a comment
```

Everything after `#` until the end of the line is ignored.

---

## Multi-line Comments

Syntax:

```jua
#*
This is a
multi-line comment
*#
```

Rules:

* May span multiple lines
* Are ignored by the lexer
* Do not nest in Jua 0.1

---

# Reserved Keywords

Jua 0.1 reserves:

```text
if
else
while
for
function
create
mutable
interface
implements
trait
uses
object
test
return
import
export
end
and
or
not
true
false
null
```

---

# Primitive Types

Jua 0.1 supports:

```text
integer
float
double
string
boolean
null
```

---

# Collections

Jua 0.1 supports:

```text
list
object
```

---

# String Model

Strings:

```text
UTF-8 encoded
immutable
```

Example:

```jua
create name = "Jua"
```

---

# Variables

## Immutable by Default

```jua
create age = 18
```

---

## Mutable Variables

```jua
create mutable counter = 0
```

---

# Assignment

Assignment uses:

```jua
=
```

Example:

```jua
counter = counter + 1
```

Assignment is a statement.

It is not an expression.

---

# Equality

Equality uses:

```jua
==
```

Example:

```jua
if age == 18
    print("Adult")
end
```

---

# Arithmetic Operators

```text
+
-
*
/
```

---

# Comparison Operators

```text
==
!=
<
>
<=
>=
```

---

# Logical Operators

```text
and
or
not
```

---

# Functions

Functions use:

```jua
function name(parameters)
    statements
end
```

Example:

```jua
function add(a, b)
    return a + b
end
```

---

# Objects

Objects are concrete types.

Example:

```jua
object Student

    create name

end
```

---

# Interfaces

Interfaces define contracts.

Example:

```jua
interface Printable

    function print()

end
```

---

# Traits

Traits provide reusable state and behavior.

Example:

```jua
trait Loggable

    create mutable logCount

end
```

---

# Trait Usage

Traits are composed using:

```jua
uses
```

Example:

```jua
object Student

    uses Loggable

end
```

---

# Interface Implementation

Interfaces are implemented using:

```jua
implements
```

Example:

```jua
object Student

    implements Printable

end
```

---

# Object Reference

Methods reference the current object through:

```jua
self
```

Example:

```jua
function greet()
    print(self.name)
end
```

---

# Control Flow

---

## If

```jua
if condition
    statements
end
```

---

## If Else

```jua
if condition
    statements
else
    statements
end
```

---

## While

```jua
while condition
    statements
end
```

---

## For

Syntax:

```jua
for i from start to end
    statements
end
```

---

### Current Semantics

```text
inclusive start
exclusive end
implicit step = 1
iterator immutable
```

Example:

```jua
for i from 0 to 5
    print(i)
end
```

Produces:

```text
0
1
2
3
4
```

---

# Repeat Statement

Jua 0.1 reserves the concept of repeat loops.

However:

```text
Deferred to future version
```

No repeat syntax exists in 0.1.

---

# Scope Model

Jua uses:

```text
Lexical Scoping
```

Scopes:

```text
Global
Function
Block
Object
Trait
Interface
```

---

# Type System

Jua is:

```text
Statically typed
Strongly typed
```

No implicit type conversion exists.

Invalid:

```jua
create x = 10
x = "hello"
```

---

# Object Typing

Objects use nominal typing.

Example:

```text
Student ≠ Teacher
```

Even if they have identical fields.

---

# Built-in Functions

Available globally:

```text
print()
assert()
typeOf()
length()
```

---

# Testing

Tests use:

```jua
test Name

    assert(expression)

end
```

---

# Imports

```jua
import moduleName
```

---

# Exports

```jua
export function add()
```

or

```jua
export object Student
```

---

# Diagnostics

Compiler diagnostics use:

```text
ERROR
WARNING
INFO
```

with structured reporting.

---

# Semantic Enforcement

The compiler MUST enforce:

```text
Scope Resolution
Type Checking
Mutability Validation
Interface Validation
Trait Validation
```

---

# Intermediate Representation

The compiler pipeline is:

```text
Source
→ Lexer
→ Parser
→ AST
→ Semantic Analysis
→ IR
→ Backend
```

---

# Explicitly Deferred Features

The following are NOT part of Jua 0.1:

```text
Generics
Closures
Pattern Matching
Exceptions
Ownership Model
Borrow Checking
Async/Await
Concurrency Model
Operator Overloading
Custom Operators
Repeat Loops
Mutable Parameters
Reflection
Macros
```

---

# Compliance

A compiler is Jua 0.1 compliant if it implements:

```text
Grammar
Expressions
Operators
Type System
Objects
Traits
Interfaces
Testing
Diagnostics
Built-ins
IR Model
```

according to the referenced specifications.

---

# Freeze Declaration

This document freezes the implementation target for Jua 0.1.

New language features MUST NOT be introduced into 0.1 without a new ADR and a subsequent language version update.

---

# Jua 0.1 Status

```text
Language Design: Complete
Frontend Specification: Complete
Semantic Specification: Complete
Runtime Contract: Complete
IR Definition: Complete
```
