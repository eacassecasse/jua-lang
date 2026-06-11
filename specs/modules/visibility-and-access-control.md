# Visibility and Access Control

Version: 0.1 Draft

---

# Purpose

This document defines visibility and access control within the Jua programming language.

Visibility determines which symbols may be accessed from outside their defining module.

Access control exists to:

* Protect internal implementation details.
* Promote encapsulation.
* Reduce coupling.
* Improve maintainability.
* Enable safer refactoring.

---

# Design Philosophy

Jua follows the principle:

> Private by default. Public by explicit declaration.

Symbols are not automatically exposed outside their defining module.

Developers must explicitly declare which symbols form part of a module's public API.

---

# Design Goals

The visibility system should be:

* Easy to learn
* Easy to reason about
* Difficult to misuse
* Compatible with tooling
* Scalable for large codebases

---

# Visibility Levels

Version 0.1 defines two visibility levels:

```text
private
public
```

Public visibility is expressed using:

```jua
export
```

All other symbols are private.

---

# Private Visibility

Private symbols are visible only within their defining module.

Example:

```jua
function validatePassword(password)

    return length(password) >= 8

end
```

The function is private.

Other modules cannot access it.

---

# Public Visibility

Symbols become public through explicit export.

Example:

```jua
export function authenticate(username, password)

    ...

end
```

This function may be imported by other modules.

---

# Public API

A module's public API consists exclusively of exported symbols.

Example:

```jua
function helper()
end

export function login()
end

export function logout()
end
```

Public API:

```text
login()
logout()
```

Private:

```text
helper()
```

---

# Exportable Symbols

Version 0.1 allows exporting:

* Functions
* Constants
* Interfaces
* Traits

---

# Exporting Functions

Example:

```jua
export function add(a: int, b: int): int

    return a + b

end
```

---

# Exporting Constants

Example:

```jua
export constant PI = 3.1415926535
```

---

# Exporting Interfaces

Example:

```jua
export interface User

    id: int

    name: string

end
```

---

# Exporting Traits

Example:

```jua
export trait Printable

    function print()

end
```

---

# Private Implementation Pattern

Modules should expose only the minimum necessary API.

Example:

```jua
function hashPassword(password)
end

function validatePassword(password)
end

export function registerUser()
end
```

Only:

```text
registerUser()
```

becomes publicly accessible.

---

# Accessing Private Symbols

Attempting to access a private symbol from another module is invalid.

Example:

```jua
import users.auth

users.auth.hashPassword()
```

Compiler Error:

```text
Symbol 'hashPassword' is private and cannot be accessed outside module 'users.auth'.
```

---

# Module Boundary Enforcement

The compiler must enforce visibility during semantic analysis.

Visibility violations are compile-time errors.

---

# Import Visibility Rules

Importing a module does not automatically expose all symbols.

Example:

```jua
import math
```

Only exported symbols are visible.

Private symbols remain inaccessible.

---

# Re-Exports

Version 0.1 does not support re-exporting.

Example:

```jua
export import math
```

Invalid.

Future language versions may introduce controlled re-export mechanisms.

---

# Package Visibility

Version 0.1 does not define package-level visibility.

Visibility applies only at the module level.

---

# Package Isolation

Packages may access only exported symbols from other packages.

Private module members remain inaccessible.

---

# Visibility and Interfaces

Exporting an interface exposes its contract.

Example:

```jua
export interface User

    id: int

    name: string

end
```

Other modules may reference:

```jua
models.User
```

---

# Visibility and Traits

Exporting a trait exposes its behavioral contract.

Example:

```jua
export trait Serializable

    function serialize()

end
```

---

# Name Resolution

Visibility checks occur after symbol resolution.

Resolution process:

```text
Locate Symbol
        ↓
Resolve Symbol
        ↓
Verify Visibility
        ↓
Allow or Reject Access
```

---

# Diagnostic Requirements

Visibility diagnostics should clearly explain:

* Which symbol is inaccessible
* Why access was denied
* Where the symbol is defined

Example:

```text
Line 15

Cannot access symbol 'hashPassword'.

Reason:
The symbol is private to module 'users.auth'.

Suggestion:
Export the symbol if it is intended to be part of the public API.
```

---

# Educational Guidance

Visibility errors should teach module boundaries rather than merely report failure.

Diagnostic messages should avoid overly technical wording when possible.

---

# Future Evolution

Future versions may introduce:

```text
internal
protected
friend modules
package visibility
```

Such additions must preserve simplicity and maintain backward compatibility whenever possible.

---

# Compliance

A conforming implementation must enforce all visibility rules defined in this document.
