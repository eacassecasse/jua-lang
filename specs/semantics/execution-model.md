# Execution Model

Version: 0.1 Draft

---

# Purpose

This document defines how valid Jua programs are executed.

The execution model specifies:

* Program startup behavior
* Statement execution order
* Expression evaluation rules
* Function invocation behavior
* Loop execution behavior
* Conditional execution behavior
* Runtime error handling

This specification is implementation-independent.

All conforming Jua runtimes and compilers must preserve the observable behavior described herein.

---

# Execution Philosophy

Jua follows a predictable, sequential execution model.

Programs execute from top to bottom unless control flow explicitly changes execution order.

Example:

```jua
create name = "Ana"

print(name)

print("Finished")
```

Execution order:

1. Create variable `name`
2. Execute first `print`
3. Execute second `print`

---

# Program Startup

Jua supports two execution modes:

* Script Mode
* Explicit Entry Point Mode

---

# Script Mode

When no entry point is defined, execution begins at the first executable statement in the source file.

Example:

```jua
print("Hello")

print("World")
```

Execution begins at the first statement.

Output:

```
Hello
World
```

---

# Explicit Entry Point Mode

If a function named `main` exists, execution begins at `main`.

Example:

```jua
function main()
    print("Hello")
end
```

The runtime invokes `main` automatically.

---

# Entry Point Rules

Version 0.1 defines:

* At most one `main` function per executable module.
* `main` receives no parameters.
* `main` may return a value.
* Returned values are ignored unless otherwise defined by tooling.

---

# Statement Execution

Statements execute sequentially.

Example:

```jua
create a = 10

create b = 20

print(a)

print(b)
```

Execution order:

1. a declaration
2. b declaration
3. print(a)
4. print(b)

---

# Expression Evaluation

Expressions are evaluated before their containing statement completes.

Example:

```jua
create result = 5 + 3
```

The expression:

5 + 3

is evaluated first.

The result is then assigned.

---

# Evaluation Order

Jua evaluates expressions from left to right.

Example:

```jua
function first()
    print("first")
    return 1
end

function second()
    print("second")
    return 2
end

create result = first() + second()
```

Output:

first
second

---

# Arithmetic Evaluation

Arithmetic follows standard precedence rules.

Highest precedence:

```
()
```

Unary operators

Then:

```
*
/
%
```

Then:

```
*
-
```

Example:

```jua
create result = 2 + 3 * 4
```

Result:

```
14
```

---

# Parenthesized Expressions

Parentheses override precedence.

Example:

```jua
create result = (2 + 3) * 4
```

Result:

```
20
```

---

# Conditional Evaluation

The condition of an if statement is evaluated before branch selection.

Example:

```jua
if age >= 18
    print("Adult")
else
    print("Minor")
end
```

Only one branch executes.

---

# Truth Values

Version 0.1 uses strict boolean evaluation.

Valid conditions must evaluate to:

* true
* false

Example:

```jua
if true
    print("Valid")
end
```

---

# Invalid Conditions

Example:

```jua
if 1
    print("Invalid")
end
```

Invalid.

Numeric values are not automatically converted to booleans.

---

# Boolean Evaluation

Logical operators evaluate left to right.

Supported operators:

* and
* or
* not

Example:

```jua
if verified and active
    print("Allowed")
end
```

---

# Short-Circuit Evaluation

Logical operators use short-circuit evaluation.

For `and`:

If the left side is false, the right side is not evaluated.

Example:

```jua
false and dangerousFunction()
```

The function is never called.

---

For `or`:

If the left side is true, the right side is not evaluated.

Example:

```jua
true or dangerousFunction()
```

The function is never called.

---

# Function Invocation

Functions execute when called.

Example:

```jua
function greet(name)
    print(name)
end

greet("Ana")
```

---

# Function Execution

Function execution proceeds:

1. Parameters are bound.
2. Local scope is created.
3. Statements execute sequentially.
4. Return value is produced.
5. Scope is destroyed.

---

# Return Statements

A return statement immediately terminates function execution.

Example:

```jua
function example()
    print("A")
    return
    print("B")
end
```

Output:

A

The second print is never executed.

---

# Recursive Calls

Functions may invoke themselves.

Example:

```jua
function countdown(n)
    if n == 0
        return
    end

    countdown(n - 1)
end
```

---

# Loop Execution

Loops repeatedly execute their body until termination conditions are met.

---

# While Loop Execution

The condition is evaluated before each iteration.

Example:

```jua
while counter < 10
    print(counter)
end
```

---

# Range Loop Execution

Example:

```jua
for i from 0 until 5
    print(i)
end
```

Produces:

```
0
1
2
3
4
```

The ending value is excluded.

---

# Collection Iteration

Example:

```jua
for student in students
    print(student)
end
```

Each element is visited once.

Elements are visited in collection order.

---

# Break Behavior

break immediately exits the nearest enclosing loop.

Example:

```jua
while true
    break
end
```

Execution continues after the loop.

---

# Continue Behavior

continue skips the remaining statements of the current iteration.

Execution proceeds with the next iteration.

---

# Variable Initialization

Variables become available immediately after successful initialization.

Example:

```jua
create age = 25

print(age)
```

Valid.

---

# Uninitialized Variables

Version 0.1 does not permit uninitialized variables.

Valid:

```jua
create age = 25
```

Invalid:

```jua
create age
```

---

# Runtime Errors

Runtime errors terminate the current execution flow.

Examples:

* Division by zero
* Invalid memory access
* Failed runtime assertions

---

# Runtime Error Reporting

Error messages should:

* Explain the failure
* Identify the source location
* Suggest corrective action when possible

Example:

Line 10

Division by zero.

Did you mean to check whether the divisor is zero before performing division?

---

# Deterministic Execution

Jua Version 0.1 aims for deterministic execution.

Given identical:

* Source code
* Inputs
* Environment

Execution should produce identical observable results.

---

# Concurrency

Version 0.1 does not define concurrency semantics.

Future specifications may introduce:

* async execution
* task scheduling
* channels
* actor models

Such additions must preserve compatibility whenever possible.

---

# Observable Behavior

Observable behavior includes:

* Console output
* Returned values
* File operations
* Network operations
* Runtime errors

Compiler optimizations must not alter observable behavior.

---

# Compliance

A conforming implementation must preserve all execution semantics defined in this document.

Alternative implementation strategies are permitted provided externally observable behavior remains equivalent.

