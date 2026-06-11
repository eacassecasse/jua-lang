# For Loops

Version: 0.1 Draft

---

# Purpose

This document defines for loops in the Jua programming language.

For loops provide a structured mechanism for iterating over:

* Numeric ranges
* Collections

Unlike while loops, which are condition-driven, for loops are iteration-driven and communicate intent more explicitly.

---

# Design Philosophy

Jua follows the principle:

> Iteration should clearly communicate what is being traversed.

For loops are intended to express finite iteration in a manner that is easy to read, teach, and analyze.

---

# Design Goals

The for loop system should be:

* Beginner-friendly
* Readable
* Predictable
* Consistent with zero-based indexing
* Compatible with static analysis
* Compatible with future iterator systems
* Easy to lower into compiler intermediate representations

---

# Supported Forms

Version 0.1 supports two forms:

```text
Numeric iteration

Collection iteration
```

---

# Numeric Iteration

General form:

```jua
for iterator from start until end

    statements

end
```

Example:

```jua
for i from 0 until 5

    print(i)

end
```

Output:

```text
0
1
2
3
4
```

---

# Exclusive Upper Bound

The value following `until` is excluded from iteration.

Example:

```jua
for i from 0 until 3

    print(i)

end
```

Output:

```text
0
1
2
```

The value:

```text
3
```

is never visited.

---

# Rationale for Exclusive Bounds

Exclusive bounds align with:

* ADR-0003 (Zero-Based Indexing)
* Array access patterns
* Collection length semantics
* Compiler optimization strategies
* Common iteration practices

Example:

```jua
for i from 0 until students.length

    ...

end
```

No subtraction is required.

---

# Numeric Iteration Execution Model

Execution proceeds as follows:

```text
Initialize iterator

Evaluate iterator against end boundary

Execute body

Apply step

Repeat until boundary is reached
```

---

# Ascending Iteration

Example:

```jua
for i from 1 until 6

    print(i)

end
```

Output:

```text
1
2
3
4
5
```

---

# Explicit Step

An iteration step may be provided.

General form:

```jua
for iterator from start until end step value

    ...

end
```

---

Example:

```jua
for i from 0 until 20 step 5

    print(i)

end
```

Output:

```text
0
5
10
15
```

---

# Descending Iteration

Descending iteration requires an explicit negative step.

Example:

```jua
for i from 10 until 0 step -1

    print(i)

end
```

Output:

```text
10
9
8
7
6
5
4
3
2
1
```

---

# Invalid Step Direction

Example:

```jua
for i from 0 until 10 step -1

    ...

end
```

Compiler implementations may issue a diagnostic:

```text
Loop will never reach termination boundary.
```

Likewise:

```jua
for i from 10 until 0 step 1

    ...

end
```

should generate a similar diagnostic.

---

# Zero Step

A step value of zero is invalid.

Example:

```jua
for i from 0 until 10 step 0

    ...

end
```

Compiler Error:

```text
Step value cannot be zero.
```

---

# Iterator Variable

The iterator is automatically created by the loop.

Example:

```jua
for i from 0 until 10

    print(i)

end
```

The variable:

```text
i
```

exists only within the loop scope.

---

# Iterator Immutability

Loop iterators are immutable.

Example:

```jua
for i from 0 until 10

    i = 100

end
```

Compiler Error:

```text
Cannot assign to loop iterator 'i'.
```

---

# Iterator Scope

Iterators are local to the loop.

Example:

```jua
for i from 0 until 5

    ...

end
```

Invalid:

```jua
print(i)
```

Compiler Error:

```text
Variable 'i' does not exist in this scope.
```

---

# Collection Iteration

Collections may be traversed using the `in` keyword.

General form:

```jua
for item in collection

    ...

end
```

---

# List Iteration

Example:

```jua
create students = [
    "Ana",
    "Pedro",
    "Maria"
]

for student in students

    print(student)

end
```

Output:

```text
Ana
Pedro
Maria
```

---

# Object Iteration

Object iteration semantics are implementation-defined in Version 0.1.

Compiler implementations must document:

* Traversal order
* Property exposure rules

Future specifications may standardize object traversal behavior.

---

# Collection Iterator Scope

Collection iterators are local to the loop.

Example:

```jua
for student in students

    print(student)

end
```

Outside the loop:

```jua
print(student)
```

Compiler Error:

```text
Variable 'student' does not exist in this scope.
```

---

# Collection Iterator Immutability

Collection iterators are immutable.

Example:

```jua
for student in students

    student = "Changed"

end
```

Compiler Error:

```text
Cannot assign to loop iterator 'student'.
```

---

# Nested For Loops

For loops may be nested.

Example:

```jua
for row from 1 until 4

    for column from 1 until 4

        print(row + "," + column)

    end

end
```

---

# Break Statement

The `break` statement immediately terminates the nearest enclosing loop.

Example:

```jua
for student in students

    if student == "Pedro"

        break

    end

end
```

---

# Continue Statement

The `continue` statement skips the remainder of the current iteration.

Example:

```jua
for i from 0 until 10

    if i == 5

        continue

    end

    print(i)

end
```

Output:

```text
0
1
2
3
4
6
7
8
9
```

---

# Return Statements

Functions may return from inside for loops.

Example:

```jua
function findStudent(name)

    for student in students

        if student == name

            return student

        end

    end

    return null

end
```

---

# Result-Based Error Handling

For loops may participate in Result validation patterns.

Example:

```jua
for file in files

    create result = process(file)

    if result.error != null

        return result

    end

end
```

---

# Compiler Lowering

Compiler implementations may lower numeric for loops into while loops.

Example:

```jua
for i from 0 until 10

    print(i)

end
```

may become:

```jua
create mutable i = 0

while i < 10

    print(i)

    i = i + 1

end
```

This transformation is implementation-specific and invisible to users.

---

# Diagnostics

Diagnostics should identify:

* Invalid boundaries
* Invalid step values
* Iterator reassignment attempts
* Scope violations

Example:

```text
Invalid step value.

Expected:
non-zero integer

Received:
0
```

---

# Educational Guidance

Educational materials should encourage:

* Descriptive iterator names
* Explicit step values when necessary
* Collection iteration when traversing lists
* Avoidance of deeply nested loops

Preferred:

```jua
for student in students

end
```

Less preferred:

```jua
for i from 0 until students.length

end
```

when the index itself is not required.

---

# Future Evolution

Future versions may introduce:

```text
Iterator protocols
Custom iterators
Generator functions
Yield expressions
Parallel iteration
Destructuring iteration
Range expressions
```

Such features must remain compatible with the Version 0.1 iteration model.

---

# Compliance

A conforming implementation must support all for-loop behavior defined in this specification.
