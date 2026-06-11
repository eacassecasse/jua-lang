# Mutability

Version: 0.1 Draft

---

# Purpose

This document defines mutability rules in the Jua programming language.

Mutability determines whether a value may be reassigned after creation.

The objective of Jua's mutability model is to:

* Improve code safety
* Reduce accidental state changes
* Encourage predictable behavior
* Support long-term maintainability

---

# Design Philosophy

Jua follows the principle:

> Values should remain stable unless mutation is explicitly requested.

Variables are immutable by default.

Mutation must be declared explicitly.

---

# Design Goals

The mutability system should be:

* Easy to understand
* Explicit
* Predictable
* Tool-friendly
* Suitable for both beginners and professionals

---

# Variable Categories

Version 0.1 defines two categories:

```text
Immutable Variable
Mutable Variable
```

---

# Immutable Variables

Variables declared using:

```jua
create
```

are immutable.

Example:

```jua
create age = 25
```

---

# Immutable Reassignment

Attempting reassignment is invalid.

Example:

```jua
create age = 25

age = 30
```

Compiler Error:

```text
Cannot assign to immutable variable 'age'.

Declare the variable as mutable if reassignment is required.
```

---

# Mutable Variables

Variables declared using:

```jua
create mutable
```

may be reassigned.

Example:

```jua
create mutable counter = 0

counter = counter + 1
```

Valid.

---

# Mutability Visibility

Mutability is part of the variable declaration.

Developers can determine whether state changes are possible simply by reading the declaration.

Example:

```jua
create name = "Ana"

create mutable score = 10
```

---

# Mutation Intent

The mutable keyword communicates design intent.

Example:

```jua
create mutable retries = 0
```

indicates that value changes are expected.

---

# Constants

Constants are declared using:

```jua
constant
```

Example:

```jua
constant PI = 3.141592653589793
```

---

# Constant Characteristics

Constants:

* Cannot be reassigned
* Cannot become mutable
* Represent fixed values

---

# Immutable Value Example

```jua
create city = "Maputo"
```

Valid:

```jua
print(city)
```

Invalid:

```jua
city = "Beira"
```

---

# Mutable Value Example

```jua
create mutable city = "Maputo"

city = "Beira"
```

Valid.

---

# Type Preservation

Mutation must respect type compatibility.

Valid:

```jua
create mutable age: integer = 25

age = 30
```

---

Invalid:

```jua
create mutable age: integer = 25

age = "thirty"
```

Compiler Error:

```text
Expected type:

integer

Received:

string
```

---

# Lists and Mutability

List mutability follows variable mutability.

Immutable list:

```jua
create names = [
    "Ana",
    "Pedro"
]
```

---

Invalid:

```jua
names[0] = "Carlos"
```

---

Mutable list:

```jua
create mutable names = [
    "Ana",
    "Pedro"
]
```

---

Valid:

```jua
names[0] = "Carlos"
```

---

# Object Mutability

Object mutability follows variable mutability.

Immutable object:

```jua
create student = {

    name: "Ana"

}
```

---

Invalid:

```jua
student.name = "Pedro"
```

---

Mutable object:

```jua
create mutable student = {

    name: "Ana"

}
```

---

Valid:

```jua
student.name = "Pedro"
```

---

# Property Addition

Immutable object:

```jua
create student = {

    name: "Ana"

}
```

---

Invalid:

```jua
student.age = 20
```

---

Mutable object:

```jua
create mutable student = {

    name: "Ana"

}
```

---

Valid:

```jua
student.age = 20
```

---

# Nested Mutability

Version 0.1 adopts shallow mutability.

Example:

```jua
create mutable student = {

    address: {

        city: "Maputo"

    }

}
```

Behavior of nested mutation is implementation-defined in Version 0.1 and will be formally specified in a future version.

---

# Function Parameters

Function parameters are immutable by default.

Example:

```jua
function greet(name)

    print(name)

end
```

---

Invalid:

```jua
function greet(name)

    name = "Pedro"

end
```

---

Compiler Error:

```text
Function parameters are immutable.
```

---

# Loop Variables

Loop variables are immutable.

Example:

```jua
for student in students

    print(student)

end
```

---

Invalid:

```jua
student = anotherStudent
```

inside the loop body.

---

# Mutation and Equality

Mutability does not affect equality semantics.

Example:

```jua
create mutable age = 25

create age2 = 25

print(age == age2)
```

Output:

```text
true
```

---

# Compiler Diagnostics

Compilers should provide clear mutability diagnostics.

Example:

```text
Cannot modify immutable object.

Property:
name

Object:
student

Suggestion:
Declare the object as mutable if modification is intended.
```

---

# Educational Rationale

Immutability by default helps beginners:

* Understand state changes
* Identify unintended mutations
* Reason about program behavior

It also introduces good engineering practices early.

---

# Future Evolution

Future versions may introduce:

```text
Deep immutability
Readonly views
Immutable collections
Ownership analysis
Borrowing rules
```

Such features must remain compatible with the Version 0.1 model.

---

# Compliance

A conforming implementation must enforce all mutability rules described in this specification.
