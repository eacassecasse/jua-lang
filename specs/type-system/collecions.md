# Collection Types

Version: 0.1 Draft

---

# Purpose

This document defines the collection types available in Jua.

Collection types allow programs to:

* Store multiple values
* Organize related information
* Model real-world entities
* Exchange structured data

Version 0.1 defines two collection types:

```text
list
object
```

---

# Design Philosophy

Jua adopts a small collection model.

The goals are:

* Simplicity
* Readability
* Educational accessibility
* Predictable behavior

Additional collection types may be introduced in future versions.

---

# Collection Types

Version 0.1 includes:

| Type   | Purpose                                   |
| ------ | ----------------------------------------- |
| list   | Ordered sequence of values                |
| object | Structured collection of named properties |

---

# List

A list stores an ordered sequence of values.

Example:

```jua
create names = [
    "Ana",
    "Pedro",
    "Carlos"
]
```

---

# List Characteristics

Lists are:

```text
Ordered
Indexable
Dynamic
Zero-Based
```

---

# Zero-Based Indexing

The first element of a list is located at index:

```text
0
```

Example:

```jua
create names = [
    "Ana",
    "Pedro",
    "Carlos"
]

print(names[0])
```

Output:

```text
Ana
```

---

# List Length

The number of elements in a list may be obtained through:

```jua
names.length()
```

Example:

```jua
create names = [
    "Ana",
    "Pedro",
    "Carlos"
]

print(names.length())
```

Output:

```text
3
```

---

# Empty Lists

An empty list is created using:

```jua
create items = []
```

---

# Homogeneous Lists

Lists may contain values of the same type.

Example:

```jua
create scores = [
    10,
    20,
    30
]
```

---

# Heterogeneous Lists

Version 0.1 allows lists to contain mixed types.

Example:

```jua
create values = [
    10,
    "Ana",
    true
]
```

This supports rapid prototyping and educational use cases.

Future versions may introduce stronger typing constraints.

---

# List Access

Elements are accessed through indexing.

Example:

```jua
create names = [
    "Ana",
    "Pedro"
]

print(names[1])
```

Output:

```text
Pedro
```

---

# Invalid Index Access

Accessing an index outside the valid range produces a runtime error.

Example:

```jua
create names = [
    "Ana"
]

print(names[10])
```

Possible Result:

```text
Index out of bounds.

Requested index: 10

List length: 1
```

---

# List Equality

Lists use value equality.

Example:

```jua
create a = [1, 2, 3]

create b = [1, 2, 3]

print(a == b)
```

Output:

```text
true
```

---

# Nested Lists

Lists may contain other lists.

Example:

```jua
create matrix = [
    [1, 2],
    [3, 4]
]
```

---

# Object

An object stores named properties.

Example:

```jua
create student = {

    name: "Ana",

    age: 20

}
```

---

# Object Characteristics

Objects are:

```text
Structured
Named
Dynamic
Expandable
```

---

# Property Access

Properties are accessed using dot notation.

Example:

```jua
print(student.name)
```

Output:

```text
Ana
```

---

# Property Assignment

Properties may be assigned values.

Example:

```jua
student.age = 21
```

---

# Dynamic Properties

Version 0.1 allows properties to be added dynamically.

Example:

```jua
student.course = "Computer Science"
```

Result:

```jua
{
    name: "Ana",
    age: 21,
    course: "Computer Science"
}
```

---

# Property Existence

Accessing a non-existent property produces a runtime error.

Example:

```jua
print(student.salary)
```

Possible Result:

```text
Property 'salary' does not exist.
```

---

# Nested Objects

Objects may contain other objects.

Example:

```jua
create student = {

    name: "Ana",

    address: {

        city: "Maputo",

        country: "Mozambique"

    }

}
```

---

# Objects Containing Lists

Example:

```jua
create student = {

    name: "Ana",

    courses: [

        "Math",

        "Programming"

    ]

}
```

---

# Object Equality

Objects use value equality.

Example:

```jua
create a = {

    name: "Ana"

}

create b = {

    name: "Ana"

}

print(a == b)
```

Output:

```text
true
```

---

# Identity Comparison

Version 0.1 does not define reference identity comparison.

Future versions may introduce:

```jua
a is b
```

for identity checks.

---

# Type Inference

Collection types may be inferred automatically.

Example:

```jua
create names = [
    "Ana",
    "Pedro"
]
```

Inferred:

```text
list
```

---

Example:

```jua
create user = {

    name: "Ana"

}
```

Inferred:

```text
object
```

---

# Collection Nesting

Collections may be nested without restriction.

Example:

```jua
create company = {

    departments: [

        {

            name: "Engineering"

        },

        {

            name: "Education"

        }

    ]

}
```

---

# Serialization Compatibility

Lists and objects are intentionally designed to map naturally to JSON structures.

Example:

```json
{
    "name": "Ana",
    "age": 20
}
```

maps directly to:

```jua
{
    name: "Ana",
    age: 20
}
```

---

# Educational Rationale

Lists and objects are sufficient to teach:

* iteration
* structured data
* collections
* functions
* APIs
* file processing

without introducing unnecessary complexity.

---

# Future Evolution

Future versions may introduce:

```text
map
set
queue
stack
tuple
immutable collections
```

Such additions must preserve backward compatibility whenever possible.

---

# Compliance

A conforming implementation must support all collection behaviors defined in this document.
