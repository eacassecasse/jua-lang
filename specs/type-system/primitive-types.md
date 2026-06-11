# Primitive Types

Version: 0.1 Draft

---

# Purpose

This document defines the primitive types available in Jua.

Primitive types are the fundamental building blocks from which all other values and structures are constructed.

Every Jua implementation must support the primitive types described in this specification.

---

# Design Philosophy

Jua adopts a small set of primitive types.

The objective is:

* Simplicity
* Readability
* Predictability
* Educational accessibility

The language avoids exposing low-level machine-oriented numeric types during its initial versions.

---

# Primitive Type Set

Version 0.1 defines the following primitive types:

```text
integer
float
double
boolean
string
```

---

# Type Categories

Primitive types are grouped into:

```text
Numeric Types
```

* integer
* float
* double

```text
Logical Types
```

* boolean

```text
Text Types
```

* string

---

# Integer

The integer type represents whole numbers.

Examples:

```jua
create age = 25

create population = 1000000
```

Valid:

```jua
-10
0
42
```

Invalid:

```jua
3.14
```

---

# Integer Operations

Supported operations:

```jua
+
-
*
/
%
```

Example:

```jua
create result = 10 + 5
```

---

# Float

The float type represents fractional numeric values.

Examples:

```jua
create temperature = 36.5

create percentage = 99.9
```

---

# Float Precision

Float values provide moderate precision and may introduce rounding behavior.

Example:

```jua
create value = 0.1 + 0.2
```

Implementations are not required to guarantee exact decimal representation.

---

# Double

The double type represents higher-precision fractional values.

Examples:

```jua
create distance = 12345.678901

create pi = 3.141592653589793
```

---

# Double Precision

Double values provide greater precision than float values.

Implementations should prefer double precision when exactness is important.

---

# Boolean

The boolean type represents logical truth values.

Valid values:

```jua
true

false
```

---

# Boolean Operations

Supported operators:

```jua
and

or

not
```

Example:

```jua
create isAdult = age >= 18
```

---

# Boolean Requirements

Conditional expressions must evaluate to boolean values.

Valid:

```jua
if age >= 18

    print("Adult")

end
```

---

Invalid:

```jua
if age

    print("Adult")

end
```

---

Invalid:

```jua
if 1

    print("Adult")

end
```

---

Invalid:

```jua
if "hello"

    print("Adult")

end
```

---

# Truthiness

Jua does not support implicit truthiness.

Only boolean values may be used in conditional contexts.

This rule improves readability and reduces ambiguity.

---

# String

The string type represents textual data.

Examples:

```jua
create name = "Edmilson"

create city = "Maputo"
```

---

# String Encoding

Strings use UTF-8 encoding.

Implementations must support Unicode text.

Examples:

```jua
create language = "Português"

create greeting = "مرحبا"

create city = "北京"
```

---

# String Concatenation

Strings may be combined using the `+` operator.

Example:

```jua
create message = "Hello " + name
```

---

# Equality

Primitive values support value equality using:

```jua
==
```

Example:

```jua
create age = 25

print(age == 25)
```

Output:

```text
true
```

---

# Inequality

Primitive values support:

```jua
!=
```

Example:

```jua
print(age != 18)
```

---

# Comparison Operators

Numeric values support:

```jua
<
>
<=
>=
```

Example:

```jua
if age >= 18

    print("Adult")

end
```

---

# Type Inference

Primitive types may be inferred.

Example:

```jua
create age = 25
```

Equivalent to:

```jua
create age: integer = 25
```

---

# Explicit Types

Developers may provide explicit annotations.

Example:

```jua
create age: integer = 25

create name: string = "Ana"
```

---

# Type Safety

Assignments must preserve type compatibility.

Valid:

```jua
create age: integer = 25
```

Invalid:

```jua
create age: integer = "twenty-five"
```

---

# Compliance

A conforming implementation must support all primitive types and behaviors defined in this specification.
