# Equality and Comparison Semantics

Version: 0.1 Draft

Status: Proposed

---

# Purpose

This document defines equality and comparison semantics in the Jua programming language.

It specifies:

* Value equality
* Inequality
* Ordering comparisons
* Primitive value comparison
* Object comparison
* Collection comparison
* Null comparison

The goal is to provide a predictable and consistent model that remains easy to understand for beginners while supporting future language evolution.

---

# Design Philosophy

Jua follows the principle:

> Equal values should behave as developers naturally expect.

Equality should be:

* Explicit
* Predictable
* Consistent
* Independent of implementation details

Version 0.1 prioritizes value equality over reference identity.

---

# Design Goals

The equality system should:

* Be easy to learn
* Avoid surprising behavior
* Support static analysis
* Remain compatible with gradual typing
* Support future identity comparisons
* Provide deterministic results

---

# Supported Operators

Version 0.1 supports:

```text
==
!=
<
>
<=
>=
```

---

# Equality Operator

The operator:

```jua
==
```

performs value comparison.

Example:

```jua
1 == 1
```

Result:

```text
true
```

---

Example:

```jua
1 == 2
```

Result:

```text
false
```

---

# Inequality Operator

The operator:

```jua
!=
```

returns the inverse of equality.

Example:

```jua
1 != 2
```

Result:

```text
true
```

---

Example:

```jua
1 != 1
```

Result:

```text
false
```

---

# Boolean Result Requirement

All comparison operations return:

```text
boolean
```

Example:

```jua
create valid = age >= 18
```

Valid.

---

# Primitive Type Equality

Version 0.1 defines equality for:

```text
integer
float
double
string
boolean
null
```

---

# Integer Equality

Example:

```jua
10 == 10
```

Result:

```text
true
```

---

Example:

```jua
10 == 20
```

Result:

```text
false
```

---

# Float Equality

Example:

```jua
10.5 == 10.5
```

Result:

```text
true
```

---

Implementations should compare numeric values rather than textual representations.

Example:

```jua
10.50 == 10.5
```

Result:

```text
true
```

---

# Boolean Equality

Example:

```jua
true == true
```

Result:

```text
true
```

---

Example:

```jua
true == false
```

Result:

```text
false
```

---

# String Equality

Strings are compared by value.

Example:

```jua
"Ana" == "Ana"
```

Result:

```text
true
```

---

Example:

```jua
"Ana" == "ana"
```

Result:

```text
false
```

---

# String Comparison Rules

Version 0.1 uses:

```text
Case-sensitive comparison
```

Example:

```jua
"Jua" == "jua"
```

Result:

```text
false
```

---

# UTF-8 Equality

String equality compares Unicode code points.

Example:

```jua
"Olá" == "Olá"
```

Result:

```text
true
```

---

# Null Equality

Example:

```jua
null == null
```

Result:

```text
true
```

---

Example:

```jua
null != null
```

Result:

```text
false
```

---

# Cross-Type Equality

Different types are never equal.

Example:

```jua
10 == "10"
```

Result:

```text
false
```

---

Example:

```jua
true == 1
```

Result:

```text
false
```

---

# No Implicit Coercion

Jua does not perform implicit type coercion during equality evaluation.

Example:

```jua
10 == "10"
```

Result:

```text
false
```

Not:

```text
true
```

---

# Rationale

This avoids confusion commonly seen in some languages.

Examples intentionally avoided:

```javascript
0 == false

"1" == 1
```

Such comparisons should not evaluate to true in Jua.

---

# Numeric Comparison

Supported operators:

```text
<
>
<=
>=
```

---

Example:

```jua
10 > 5
```

Result:

```text
true
```

---

Example:

```jua
5 < 2
```

Result:

```text
false
```

---

# Comparison Type Requirements

Ordering comparisons require compatible types.

Valid:

```jua
10 < 20
```

---

Invalid:

```jua
10 < "20"
```

Compiler Error:

```text
Cannot compare:

integer

with:

string
```

---

# Collection Equality

Version 0.1 supports structural equality for collections.

---

# List Equality

Lists are equal when:

* They contain the same number of elements.
* Elements appear in the same order.
* Corresponding elements are equal.

Example:

```jua
[1, 2, 3] == [1, 2, 3]
```

Result:

```text
true
```

---

Example:

```jua
[1, 2, 3] == [3, 2, 1]
```

Result:

```text
false
```

---

# Nested List Equality

Example:

```jua
[
    [1, 2],
    [3, 4]
]
==
[
    [1, 2],
    [3, 4]
]
```

Result:

```text
true
```

---

# Object Equality

Version 0.1 supports structural object equality.

Objects are equal when:

* They contain identical properties.
* Corresponding values are equal.
* Property names match exactly.

Example:

```jua
{
    name: "Ana",
    age: 20
}
==
{
    name: "Ana",
    age: 20
}
```

Result:

```text
true
```

---

Example:

```jua
{
    name: "Ana"
}
==
{
    name: "Pedro"
}
```

Result:

```text
false
```

---

# Property Order

Property declaration order must not affect equality.

Example:

```jua
{
    name: "Ana",
    age: 20
}
==
{
    age: 20,
    name: "Ana"
}
```

Result:

```text
true
```

---

# Deep Equality

Collection and object equality are recursive.

Example:

```jua
{
    user: {
        name: "Ana"
    }
}
==
{
    user: {
        name: "Ana"
    }
}
```

Result:

```text
true
```

---

# Identity Comparison

Version 0.1 does not define identity comparison.

The language intentionally distinguishes:

```text
Value equality
```

from:

```text
Reference identity
```

Identity comparison may be introduced in future versions.

Possible future syntax:

```jua
a is b
```

This syntax is not currently part of the language.

---

# Equality in Control Flow

Equality operators may be used in:

```jua
if age == 18

end
```

---

```jua
while user != null

end
```

---

```jua
for item in items

end
```

---

# Equality in Functions

Example:

```jua
function isAdult(age)

    return age >= 18

end
```

Valid.

---

# Equality in Result Handling

Example:

```jua
if result.error != null

    return result

end
```

Valid.

---

# Compiler Optimization

Compilers may optimize equality operations when results can be determined statically.

Example:

```jua
if 10 == 10
```

may be reduced to:

```jua
if true
```

during optimization.

---

# Diagnostics

Diagnostics should identify:

* Incompatible comparison types
* Unsupported operations
* Invalid equality expressions

Example:

```text
Invalid comparison.

Left operand:
integer

Right operand:
string
```

---

# Educational Guidance

Educational materials should emphasize:

* Equality compares values.
* Equality does not perform implicit conversion.
* Different types are not equal.
* Structural equality applies to collections and objects.

---

# Future Evolution

Future versions may introduce:

```text
Identity comparison (is)
Custom equality implementations
Trait-based equality
Pattern matching
Comparable interfaces
Generic equality constraints
```

Such features must remain compatible with Version 0.1 equality semantics.

---

# Compliance

A conforming implementation must implement all equality behavior defined in this specification.
