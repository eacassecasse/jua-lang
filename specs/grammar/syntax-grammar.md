# Syntax Grammar

Version: 0.1 Draft

---

# Purpose

This document defines the syntactic structure of valid Jua programs.

The syntax grammar specifies how lexical tokens are combined to form valid language constructs.

This document describes syntax using a human-readable form.

Formal grammar definitions may be introduced in future versions.

---

# Program Structure

A Jua source file consists of a sequence of declarations and executable statements.

Example:

```code
create age = 25

function greet(name)
    print(name)
end

greet("Ana")
```

---

# Statements

A statement is an executable instruction.

Examples:

```code
create age = 25

print(age)

age = age + 1
```

---

# Variable Declarations

Variables are declared using the create keyword.

Example:

```code
create age = 25
```

Variables are local by default.

---

# Mutable Variables

Mutable variables must be explicitly marked.

Example:

```code
create mutable counter = 0

counter = counter + 1
```

---

# Constant Declarations

Constants are immutable.

Example:

```code
constant PI = 3.14159
```

---

# Assignment Statements

Assignments update the value of a mutable variable.

Example:

```code
counter = counter + 1
```

Assigning to a constant is invalid.

---

# Expressions

Expressions produce values.

Examples:

```code
10 + 5

age >= 18

name + " Silva"

not active
```

---

# Arithmetic Expressions

Supported arithmetic operators:

```
*

-

*

/
%
```

Example:

```code
create total = price + tax
```

---

# Comparison Expressions

Supported comparison operators:

```
==
!=
<
>
<=
> =
```

Example:

```code
if age >= 18
    print("Adult")
end
```

---

# Logical Expressions

Supported logical operators:

```
and
or
not
```

Example:

```code
if active and verified
    print("Access Granted")
end
```

---

# Function Declarations

Functions are declared using the function keyword.

Example:

```code
function greet(name)
    print("Hello " + name)
end
```

---

# Function Parameters

Functions may receive zero or more parameters.

Example:

```code
function hello()
    print("Hello")
end
```

Example:

```code
function add(a, b)
    return a + b
end
```

---

# Return Statements

Functions may return values.

Example:

```code
function add(a, b)
    return a + b
end
```

Execution immediately exits the function when return is encountered.

---

# Function Calls

Functions are invoked using parentheses.

Example:

```code
greet("Ana")
```

Example:

```code
create result = add(10, 5)
```

---

# Conditional Statements

Conditional execution uses the if keyword.

Example:

```code
if age >= 18
    print("Adult")
end
```

---

# If-Else Statements

Example:

```code
if age >= 18
    print("Adult")
else
    print("Minor")
end
```

---

# Nested Conditionals

Conditional statements may be nested.

Example:

```code
if active
    if verified
        print("Allowed")
    end
end
```

---

# While Loops

A while loop repeats while its condition evaluates to true.

Example:

```code
create mutable counter = 0

while counter < 10
    print(counter)
    counter = counter + 1
end
```

---

# Range-Based For Loops

Range iteration uses from and until.

Example:

```code
for i from 0 until 10
    print(i)
end
```

The starting value is included.

The ending value is excluded.

The example above produces:
```
0
1
2
3
4
5
6
7
8
9
```

---

# Collection Iteration

Collections may be traversed using the in keyword.

Example:

```code
for student in students
    print(student)
end
```

---

# Break Statement

break immediately terminates the current loop.

Example:

```code
while true
    if finished
        break
    end
end
```

---

# Continue Statement

continue skips the remainder of the current iteration.

Example:

```code
for student in students
    if student == null
        continue
    end
    print(student)
end
```

---

# Lists

Lists are ordered collections.

Example:

```code
create students = [
"Ana",
"Pedro",
"Carlos"
]
```

---

# List Access

Lists use zero-based indexing.

Example:

```code
print(students[0])
```

---

# Objects

Objects store named properties.

Example:

```code
create student = {
name: "Ana",
age: 20
}
```

---

# Property Access

Properties are accessed using dot notation.

Example:

```code
print(student.name)
```

---

# Import Statements

Modules are imported using the import keyword.

Example:

```code
import math
```

Example:

```code
import students
```

---

# Testing Blocks

Tests are declared using the test keyword.

Example:

```code
test "addition works"
    create result = add(2, 2)

    assert(result == 4)
end
```

---

# Block Structure

Jua uses explicit block termination.

The following constructs require end:

* function
* if
* while
* for
* test

Example:

```code
function greet(name)
    print(name)
end
```

---

# Statement Separation

Statements are separated by line breaks.

Semicolons are not required.

Example:

```code
create age = 25

print(age)
```

---

# Entry Point

Jua supports script-style execution.

Example:

```code
print("Hello World")
```

If a function named main exists, execution begins from main.

Example:

```code
function main()
    print("Hello World")
end
```

---

# Invalid Syntax Examples

Missing end:

```code
function greet(name)
    print(name)
```

Invalid.

---

Constant reassignment:

```code
constant PI = 3.14

PI = 4
```

Invalid.

---

Invalid range loop:

```code
for i until 10
    print(i)
end
```

Invalid because the starting boundary is missing.

