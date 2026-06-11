# Conditional Execution (`if`)

Version: 0.1 Draft

---

# Purpose

This document defines conditional execution in the Jua programming language.

Conditional execution allows a program to execute different code paths based on the evaluation of a boolean expression.

The `if` construct is the primary mechanism for decision-making within a Jua program.

---

# Design Philosophy

Jua follows the principle:

> Conditions must be explicit and readable.

Conditional logic should be easy to understand for beginners while remaining predictable for professional software development.

Jua therefore requires conditions to evaluate explicitly to a boolean value.

---

# Design Goals

The conditional execution system should be:

* Readable
* Predictable
* Explicit
* Easy to teach
* Easy to analyze statically
* Consistent with gradual typing

---

# Syntax Overview

General form:

```jua
if condition

    statements

end
```

---

# Basic Conditional Execution

Example:

```jua
create age = 20

if age >= 18

    print("Adult")

end
```

Output:

```text
Adult
```

---

# False Conditions

If the condition evaluates to `false`, the body is skipped.

Example:

```jua
create age = 15

if age >= 18

    print("Adult")

end
```

Output:

```text
(no output)
```

---

# Condition Evaluation

Conditions are evaluated exactly once.

Example:

```jua
if userExists()

    print("Found")

end
```

The function `userExists()` is evaluated one time before entering the block.

---

# Boolean Requirement

Conditions must evaluate to a boolean value.

Valid:

```jua
if isLoggedIn

end
```

Valid:

```jua
if age >= 18

end
```

---

Invalid:

```jua
if 10

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
if "hello"

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

# Else Branch

An alternative execution path may be provided using `else`.

Example:

```jua
if age >= 18

    print("Adult")

else

    print("Minor")

end
```

---

# Else-If Branch

Additional conditions may be introduced using `else if`.

Example:

```jua
if score >= 90

    print("Excellent")

else if score >= 70

    print("Good")

else if score >= 50

    print("Pass")

else

    print("Fail")

end
```

---

# Else-If Evaluation Order

Conditions are evaluated from top to bottom.

Evaluation stops after the first matching branch.

Example:

```jua
if age >= 18

    print("Adult")

else if age >= 13

    print("Teen")

else

    print("Child")

end
```

Only one branch executes.

---

# Nested Conditionals

Conditionals may be nested.

Example:

```jua
if userExists

    if isAdmin

        print("Administrator")

    end

end
```

---

# Nesting Depth

Version 0.1 imposes no language-level nesting limit.

Compiler implementations may issue warnings for excessive nesting.

Example:

```text
Warning:

Conditional nesting exceeds recommended depth.
```

---

# Scope Rules

Variables declared inside an `if` block are local to that block.

Example:

```jua
if isLoggedIn

    create user = loadUser()

end
```

Invalid:

```jua
print(user)
```

Compiler Error:

```text
Variable 'user' does not exist in this scope.
```

---

# Variable Shadowing

Inner scopes may define variables with the same name.

Example:

```jua
create age = 18

if true

    create age = 20

    print(age)

end

print(age)
```

Output:

```text
20
18
```

---

# Short-Circuit Evaluation

Logical operators use short-circuit evaluation.

Example:

```jua
if isLoggedIn AND isAdmin

    ...

end
```

If:

```jua
isLoggedIn
```

evaluates to `false`, then:

```jua
isAdmin
```

is not evaluated.

---

# Logical Operators

Version 0.1 supports:

```text
AND
OR
NOT
```

Examples:

```jua
if age >= 18 AND verified

end
```

```jua
if age >= 18 OR guardianPresent

end
```

```jua
if NOT suspended

end
```

---

# Comparison Operators

Version 0.1 supports:

```text
==
!=
<
>
<=
>=
```

Example:

```jua
if age == 18

end
```

---

# Equality Semantics

Conditional expressions follow the equality rules defined in:

```text
specs/type-system/equality.md
```

Example:

```jua
if name == "Ana"

end
```

---

# Return Statements Inside Conditionals

Functions may return from inside conditional branches.

Example:

```jua
function validate(age)

    if age < 18

        return false

    end

    return true

end
```

---

# Result-Based Error Handling

Conditionals commonly participate in Result validation.

Example:

```jua
create result = loadUser()

if result.error != null

    return result

end
```

This pattern is encouraged throughout Version 0.1.

---

# Unreachable Branches

Compilers may report unreachable branches.

Example:

```jua
if true

    print("A")

else

    print("B")

end
```

Possible warning:

```text
Unreachable branch detected.
```

---

# Diagnostics

Conditional diagnostics should clearly identify:

* Condition
* Expected type
* Actual type
* Location

Example:

```text
Invalid conditional expression.

Expected:
boolean

Received:
string

Location:
Line 10, Column 5
```

---

# Educational Guidance

Educational materials should encourage:

* Simple conditions
* Limited nesting
* Descriptive boolean variables
* Early returns

Preferred:

```jua
if userAuthenticated

    ...

end
```

Less preferred:

```jua
if calculateAuthenticationStatus(user) == true

    ...

end
```

---

# Future Evolution

Future versions may introduce:

```text
match
switch
pattern matching
guard clauses
conditional expressions
```

Such features must remain compatible with the Version 0.1 conditional model.

---

# Compliance

A conforming implementation must support all conditional behavior defined in this specification.
