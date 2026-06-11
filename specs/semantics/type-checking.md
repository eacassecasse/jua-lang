# Type Checking

Version: 0.1 Draft
Status: Proposed

---

# Purpose

This document defines the rules for type validation in Jua.

Type checking ensures that:

* Expressions produce valid types
* Operations are type-safe
* Function calls match signatures
* Objects satisfy interface contracts
* Traits are compositionally valid

It operates after scope resolution and before code generation.

---

# Design Philosophy

Jua type checking follows the principle:

> Types exist to prevent invalid reasoning, not to burden the developer.

The system must:

* Be statically enforceable
* Be predictable
* Avoid implicit coercion (in 0.1)
* Produce clear errors
* Remain simple enough for beginners

---

# Type System Overview

Jua 0.1 supports:

```text id="t1"
integer
float
double
string (UTF-8)
boolean
null
list
object
```

---

# Type Rules

## Rule 1: Strong Typing

Jua is **statically and strongly typed**.

No implicit coercion is allowed.

---

## Rule 2: Expression Types Must Be Determinable

Every expression MUST resolve to a type.

---

# Literal Types

## Integers

```jua id="e1"
10 → integer
```

---

## Floats

```jua id="e2"
3.14 → float
```

---

## Strings

```jua id="e3"
"hello" → string
```

---

## Booleans

```jua id="e4"
true → boolean
false → boolean
```

---

## Null

```jua id="e5"
null → null
```

---

# Variable Typing

## Inferred Type from Initialization

```jua id="e6"
create x = 10
```

→ `integer`

---

## Explicit Mutability Does NOT affect type

```jua id="e7"
create mutable x = 10
```

→ `integer`

---

## Type Consistency Rule

Once assigned, type is fixed.

---

Invalid:

```jua id="e8"
create x = 10
x = "hello"
```

Error:

```text id="err1"
Type mismatch: integer cannot be assigned string
```

---

# Arithmetic Type Rules

## Integer + Integer

```jua id="e9"
10 + 5 → integer
```

---

## Float + Float

```jua id="e10"
1.2 + 3.4 → float
```

---

## Mixed Arithmetic (0.1 Rule)

```text id="r1"
No implicit conversion allowed
```

Invalid:

```jua id="e11"
10 + 3.5
```

Error:

```text id="err2"
Type mismatch: integer + float
```

---

# Comparison Types

All comparisons return:

```text id="t2"
boolean
```

---

Example:

```jua id="e12"
10 == 10 → boolean
```

---

# Logical Types

Logical operators require boolean operands.

---

Valid:

```jua id="e13"
true and false → boolean
```

---

Invalid:

```jua id="e14"
10 and 20
```

Error:

```text id="err3"
Logical operator requires boolean operands
```

---

# Function Type Checking

## Signature Rule

A function has:

```text id="s1"
(parameter types) → return type
```

---

## Example

```jua id="e15"
function add(a, b)
    return a + b
end
```

---

## Call Validation

```jua id="e16"
add(2, 3)
```

Valid.

---

Invalid:

```jua id="e17"
add(2, "hello")
```

Error:

```text id="err4"
Type mismatch in function argument
```

---

# Return Type Checking

## Rule

All return statements MUST match declared or inferred return type.

---

Example:

```jua id="e18"
function test()
    return 10
end
```

Return type: `integer`

---

Invalid:

```jua id="e19"
function test()
    return "hello"
end
```

Error:

```text id="err5"
Return type mismatch: expected integer
```

---

# Object Typing

## Objects Are Nominal Types

Each object defines its own type.

---

Example:

```jua id="e20"
object Student
end
```

→ Type: `Student`

---

## Object Construction

```jua id="e21"
Student("Ana")
```

→ `Student`

---

# Interface Type Checking

## Rule

An object implementing an interface MUST satisfy all required functions.

---

Example:

```jua id="e22"
interface Printable
    function print()
end
```

---

Valid:

```jua id="e23"
object A
    implements Printable

    function print()
    end
end
```

---

Invalid:

```jua id="e24"
object A
    implements Printable
end
```

Error:

```text id="err6"
Missing implementation: print()
```

---

# Trait Type Behavior

Traits contribute types structurally but do not define standalone types.

---

## Rule

Traits:

* Inject members
* Do NOT define independent types

---

Example:

```jua id="e25"
trait Loggable
    function log()
end
```

---

# List Types

Lists are homogeneous.

---

Example:

```jua id="e26"
[1, 2, 3]
```

Type:

```text id="t3"
list<integer>
```

---

Invalid:

```jua id="e27"
[1, "hello"]
```

Error:

```text id="err7"
List must be homogeneous
```

---

# Null Type Rules

Null can only be assigned where explicitly allowed.

---

Example:

```jua id="e28"
create x = null
```

Type:

```text id="t4"
null
```

---

# Type Compatibility Rules

## Assignment Compatibility

```text id="r2"
target type MUST match source type exactly
```

---

## No Implicit Casting

Invalid:

```jua id="e29"
create x = 10
x = 10.5
```

---

# Expression Type Inference

Every expression must resolve to a type:

| Expression     | Type    |
| -------------- | ------- |
| 10 + 5         | integer |
| "a" + "b"      | string  |
| true and false | boolean |

---

# Error Reporting Requirements

Type errors MUST include:

* Expected type
* Actual type
* Location
* Expression context

---

Example:

```text id="errfmt"
Error [Type]: Type mismatch
  Expected: integer
  Found: string
  at line 5, column 12
```

---

# Semantic Pipeline Position

```text id="p1"
AST
 ↓
Scope Resolution
 ↓
Type Checking   ← (this stage)
 ↓
Validated AST
 ↓
Code Generation
```

---

# Non-Goals

This document does NOT define:

* Runtime polymorphism
* Generics
* Type inference beyond basic literals
* Casting system (future feature)
* Memory layout

---

# Compliance

A conforming compiler MUST:

* Enforce strict type equality
* Reject invalid operations
* Validate function signatures
* Validate return types
* Validate interface implementations
* Ensure list homogeneity
