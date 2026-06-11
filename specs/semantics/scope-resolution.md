# Scope Resolution

Version: 0.1 Draft
Status: Proposed

---

# Purpose

This document defines how identifiers are resolved to declarations in Jua.

Scope resolution determines:

* Where a variable/function/object is visible
* Which declaration a name refers to
* How nested contexts interact
* How shadowing behaves

It operates during semantic analysis on the AST.

---

# Design Philosophy

Jua scope resolution follows the principle:

> A name is always resolved to the closest valid enclosing declaration.

Scope rules must be:

* Deterministic
* Predictable
* Easy to reason about
* Independent of runtime execution order

---

# Scope Model

Jua uses **lexical scoping (static scoping)**.

Scopes are nested and form a hierarchy:

```text id="s1"
Global Scope
  ├── Module Scope
  ├── Function Scope
  │     ├── Block Scope (if/while/for)
  ├── Object Scope
  ├── Trait Scope
  └── Interface Scope
```

---

# Scope Rules

## Rule 1: Lexical Resolution

Identifiers are resolved by searching:

```text id="r1"
current scope → parent scope → ... → global scope
```

---

## Rule 2: First Match Wins

The nearest declaration is used.

Example:

```jua id="e1"
create x = 10

function test()
    create x = 20
    print(x)
end
```

Output:

```text id="o1"
20
```

---

## Rule 3: No Forward Resolution Across Functions

Variables are not visible outside their scope.

---

Example:

```jua id="e2"
function a()
    create x = 10
end

function b()
    print(x)
end
```

Error:

```text id="err1"
Undefined symbol: x
```

---

# Global Scope

## Definition

The global scope contains:

* Top-level functions
* Top-level objects
* Top-level traits
* Top-level interfaces
* Imports

---

## Example

```jua id="e3"
create globalVar = 10

function test()
    print(globalVar)
end
```

Valid.

---

# Function Scope

Each function introduces a new scope.

---

## Includes

* Parameters
* Local variables
* Nested blocks

---

## Example

```jua id="e4"
function add(a, b)
    create result = a + b
    return result
end
```

Scope contains:

```text id="s2"
a
b
result
```

---

# Block Scope

Blocks introduce nested scopes:

* if
* while
* for

---

## Example

```jua id="e5"
if true
    create x = 10
end

print(x)
```

Error:

```text id="err2"
x is not visible in this scope
```

---

# Object Scope

Objects define their own scope for:

* Fields
* Methods

---

## Example

```jua id="e6"
object Student
    create name

    function printName()
        print(name)
    end
end
```

Valid.

---

## Rule

Object members are accessible to all methods within the object.

---

# Trait Scope

Traits define reusable scope fragments.

---

## Example

```jua id="e7"
trait Loggable
    create mutable logCount

    function log()
        logCount = logCount + 1
    end
end
```

---

## Rule

When a trait is used:

```text id="r2"
its members are injected into the object scope
```

---

# Name Shadowing

Shadowing is allowed.

---

## Example

```jua id="e8"
create x = 10

function test()
    create x = 20
    print(x)
end
```

Output:

```text id="o2"
20
```

---

## Rule

Inner scopes may redefine names from outer scopes.

---

# Shadowing in Objects

```jua id="e9"
object A
    create x

    function test()
        create x
    end
end
```

Valid.

---

# Illegal Shadowing Cases (Reserved Names)

Shadowing is NOT allowed for:

* Keywords
* Built-in functions
* Language primitives

Example:

```jua id="e10"
create function = 10
```

Error:

```text id="err3"
Cannot shadow reserved keyword: function
```

---

# Closure Capture (Future Consideration)

Version 0.1:

```text id="c1"
Closures are NOT required
```

Functions do NOT capture outer variables unless explicitly defined in future versions.

---

# Symbol Resolution Algorithm

For each identifier:

```text id="a1"
1. Check local scope
2. Check enclosing block scope
3. Check function scope
4. Check object/trait scope
5. Check global scope
6. If not found → error
```

---

# Duplicate Declarations

Within the same scope:

```jua id="e11"
create x = 10
create x = 20
```

Error:

```text id="err4"
Duplicate symbol: x
```

---

# Function Parameters

Parameters are treated as local variables.

---

## Example

```jua id="e12"
function test(x)
    print(x)
end
```

Valid.

---

# Nested Scope Example

```jua id="e13"
create x = 1

function outer()
    create x = 2

    if true
        create x = 3
        print(x)
    end
end
```

Output:

```text id="o3"
3
```

---

# Import Scope

Imported modules introduce symbols into scope.

---

## Example

```jua id="e14"
import math

print(math.sqrt(4))
```

Valid.

---

# Export Visibility Interaction

Only exported symbols are visible outside modules.

---

# Scope and Semantics Interaction

Scope resolution is required before:

* Type checking
* Mutability validation
* Trait validation

---

# Error Reporting Requirements

Scope errors MUST include:

* Identifier name
* Location
* Scope context

Example:

```text id="errfmt"
Error [Scope]: Undefined symbol 'x'
  at line 5, column 10
  in function test()
```

---

# Non-Goals

This document does NOT define:

* Type inference
* Execution order
* Memory management
* Optimization
* Runtime closures

---

# Compliance

A conforming implementation MUST:

* Resolve identifiers using lexical scope rules
* Detect undefined symbols
* Detect duplicate declarations
* Respect shadowing rules
* Enforce reserved keyword restrictions
