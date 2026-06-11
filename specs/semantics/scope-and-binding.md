# Scope and Binding

Version: 0.1 Draft

---

# Purpose

This document defines variable visibility, lifetime, name resolution, and binding rules in the Jua programming language.

These rules determine how identifiers are associated with declarations and how those declarations remain accessible during program execution.

---

# Scope Model

Jua uses lexical (static) scoping.

Identifier resolution is determined by the source code structure rather than runtime execution order.

Example:

```code
create name = "Global"

function greet()
    print(name)
end
```

The identifier name resolves to the variable declared in the surrounding scope.

---

# Scope Types

Jua defines the following scopes:

* Module Scope
* Function Scope
* Block Scope

---

# Module Scope

Declarations made at the top level of a source file belong to the module scope.

Example:

```code
constant VERSION = "0.1"

function greet()
end
```

Both declarations exist in module scope.

---

# Function Scope

Function parameters and variables declared within a function belong to that function's scope.

Example:

```code
function greet(name)
    create message = "Hello"
end
```

The identifiers name and message are only visible within greet.

---

# Block Scope

Conditional and loop blocks introduce nested scopes.

Example:

```code
if active
    create age = 20
end
```

The variable age is not visible outside the block.

---

# Identifier Resolution

Identifiers are resolved using nearest-scope lookup.

The compiler searches:

1. Current scope
2. Parent scope
3. Ancestor scopes
4. Module scope

The first matching declaration is selected.

---

# Shadowing

Inner scopes may declare identifiers that hide outer declarations.

Example:

```code
create name = "Global"

function greet()
    create name = "Local"

    print(name)
end
```

Output:

```
Local
```

The inner declaration shadows the outer declaration.

---

# Shadowing Guidelines

Shadowing is permitted.

However, tooling may emit warnings when shadowing reduces readability.

---

# Declaration Before Use

Variables must be declared before they are used.

Valid:

```code
create age = 25

print(age)
```

Invalid:

```code
print(age)

create age = 25
```

---

# Function Visibility

Functions become visible immediately after declaration.

Example:

```code
function greet()
    print("Hello")
end

greet()
```

Valid.

---

# Forward References

Version 0.1 does not support forward function references.

Invalid:

```code
greet()

function greet()
    print("Hello")
end
```

Future versions may revisit this behavior.

---

# Parameter Binding

Function parameters create local bindings.

Example:

```code
function greet(name)
    print(name)
end
```

The identifier name exists only during function execution.

---

# Constant Binding

Constants create immutable bindings.

Example:

```code
constant PI = 3.14159
```

Attempting reassignment is invalid.

---

# Mutable Binding

Variables declared with mutable create mutable bindings.

Example:

```code
create mutable counter = 0

counter = counter + 1
```

Valid.

---

# Immutable Binding

Variables declared without mutable create immutable bindings.

Example:

```code
create age = 25

age = 30
```

Invalid.

---

# Lifetime

Bindings exist for the lifetime of their scope.

### Module scope:

- Exists for program execution duration.

### Function scope:

- Exists during function execution.

### Block scope:

- Exists during block execution.

---

# Import Scope

Imported declarations become visible within the importing module.

Example:

```code
import math
```

Imported identifiers participate in normal name resolution.

---

# Duplicate Declarations

Multiple declarations of the same identifier within the same scope are invalid.

Example:

```code
create age = 20

create age = 25
```

Invalid.

---

# Reserved Keywords

Reserved keywords cannot be used as identifiers.

Invalid:

```code
create function = 10

create if = 20
```

---

# Name Resolution Errors

The compiler must emit an error when:

* An identifier cannot be resolved.
* A reserved keyword is used as an identifier.
* A duplicate declaration exists in the same scope.

Example:

```code
print(age)
```

Error:

Identifier 'age' is not defined.

