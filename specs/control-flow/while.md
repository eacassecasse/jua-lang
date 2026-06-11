# While Loops

Version: 0.1 Draft

---

# Purpose

This document defines while loops in the Jua programming language.

While loops repeatedly execute a block of statements while a condition evaluates to `true`.

They provide the primary mechanism for condition-controlled iteration.

---

# Design Philosophy

Jua follows the principle:

> Repetition should remain explicit and predictable.

A while loop continues execution only while its condition remains true.

Loop termination conditions should be visible and understandable from the source code.

---

# Design Goals

The while loop system should be:

* Easy to learn
* Easy to read
* Predictable
* Suitable for static analysis
* Compatible with gradual typing
* Compatible with future optimization passes

---

# Syntax Overview

General form:

```jua
while condition

    statements

end
```

---

# Basic Loop

Example:

```jua
create mutable count = 1

while count <= 5

    print(count)

    count = count + 1

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

# Loop Execution Model

Execution proceeds as follows:

1. Evaluate condition.
2. If condition is `false`, exit loop.
3. Execute loop body.
4. Return to step 1.

---

# Condition Evaluation

The condition is evaluated before every iteration.

Example:

```jua
while userConnected()

    processMessages()

end
```

`userConnected()` is evaluated before each iteration.

---

# Boolean Requirement

The condition must evaluate to a boolean value.

Valid:

```jua
while active

end
```

Valid:

```jua
while count < 10

end
```

---

Invalid:

```jua
while 10

end
```

Compiler Error:

```text
Expected:

boolean

Received:

integer
```

---

Invalid:

```jua
while "hello"

end
```

Compiler Error:

```text
Expected:

boolean

Received:

string
```

---

# Zero Iterations

A while loop may execute zero times.

Example:

```jua
create mutable count = 10

while count < 5

    print(count)

end
```

Output:

```text
(no output)
```

---

# Variable Scope

Variables declared inside a loop body are local to that iteration scope.

Example:

```jua
while active

    create message = readMessage()

end
```

Invalid outside the loop:

```jua
print(message)
```

Compiler Error:

```text
Variable 'message' does not exist in this scope.
```

---

# Accessing Outer Variables

Loop bodies may access variables declared outside the loop.

Example:

```jua
create mutable count = 0

while count < 5

    count = count + 1

end
```

Valid.

---

# Mutability Rules

Mutability follows the rules defined in:

```text
specs/type-system/mutability.md
```

Example:

```jua
create count = 0

while count < 5

    count = count + 1

end
```

Compiler Error:

```text
Cannot assign to immutable variable 'count'.
```

---

# Nested Loops

While loops may be nested.

Example:

```jua
create mutable row = 1

while row <= 3

    create mutable column = 1

    while column <= 3

        print(row + "," + column)

        column = column + 1

    end

    row = row + 1

end
```

---

# Infinite Loops

A loop whose condition never becomes false is an infinite loop.

Example:

```jua
while true

    print("Running")

end
```

Valid.

---

# Compiler Diagnostics for Infinite Loops

Compilers may warn when an infinite loop is statically detectable.

Example:

```text
Warning:

Loop condition is always true.
```

Such warnings are optional.

---

# Break Statement

Version 0.1 introduces `break`.

Purpose:

Terminate loop execution immediately.

Example:

```jua
while true

    if userRequestedExit

        break

    end

end
```

---

# Break Semantics

When a break statement executes:

1. Current iteration stops.
2. Loop terminates.
3. Execution resumes after the loop.

---

# Break Scope

A break statement affects only the nearest enclosing loop.

Example:

```jua
while conditionA

    while conditionB

        break

    end

end
```

Only the inner loop terminates.

---

# Continue Statement

Version 0.1 introduces `continue`.

Purpose:

Skip the remainder of the current iteration.

Example:

```jua
while count < 10

    count = count + 1

    if count == 5

        continue

    end

    print(count)

end
```

Output:

```text
1
2
3
4
6
7
8
9
10
```

---

# Continue Semantics

When continue executes:

1. Remaining statements are skipped.
2. Condition is re-evaluated.
3. Next iteration begins if condition remains true.

---

# Break Outside Loops

Invalid:

```jua
break
```

outside a loop.

Compiler Error:

```text
Break statement is not inside a loop.
```

---

# Continue Outside Loops

Invalid:

```jua
continue
```

outside a loop.

Compiler Error:

```text
Continue statement is not inside a loop.
```

---

# Return Statements

Functions may return from within loops.

Example:

```jua
function findUser(id)

    while hasMoreUsers()

        create user = nextUser()

        if user.id == id

            return user

        end

    end

    return null

end
```

---

# Result-Based Error Handling

Loop bodies may perform Result validation.

Example:

```jua
while hasMoreFiles()

    create result = readNextFile()

    if result.error != null

        return result

    end

end
```

---

# Short-Circuit Evaluation

Logical operators inside loop conditions follow the rules defined in:

```text
specs/control-flow/if.md
```

Example:

```jua
while connected AND authenticated

    ...

end
```

---

# Loop Diagnostics

Diagnostics should identify:

* Condition errors
* Scope errors
* Invalid break usage
* Invalid continue usage

Example:

```text
Invalid loop condition.

Expected:
boolean

Received:
integer

Location:
Line 15, Column 7
```

---

# Educational Guidance

Educational materials should encourage:

* Clear termination conditions
* Limited nesting depth
* Proper use of break
* Avoidance of accidental infinite loops

Preferred:

```jua
while count < 10

    ...

end
```

Less preferred:

```jua
while true

    if count >= 10

        break

    end

end
```

unless the infinite-loop pattern is intentional.

---

# Future Evolution

Future versions may introduce:

```text
labeled loops
loop expressions
iterator protocols
async iteration
```

Such features must remain compatible with the Version 0.1 loop model.

---

# Compliance

A conforming implementation must support all while-loop behavior defined in this specification.
