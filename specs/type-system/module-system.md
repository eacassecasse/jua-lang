# Module System

Version: 0.1 Draft

---

# Purpose

This document defines the module system of the Jua programming language.

The module system provides a mechanism for organizing code into reusable and maintainable units.

Modules enable:

* Code reuse
* Encapsulation
* Dependency management
* Namespace isolation
* Team collaboration

---

# Design Goals

The Jua module system is designed to be:

* Easy to learn
* Predictable
* Tool-friendly
* Scalable for large projects
* Compatible with future package management systems

---

# Design Philosophy

Jua adopts explicit imports.

Symbols are not automatically visible across modules.

A module must explicitly import external dependencies before use.

---

# Module Identity

Every source file defines exactly one module.

Example:

```jua
function add(a: int, b: int): int

    return a + b

end
```

File:

```text
math/add.jua
```

Module identity:

```text
math.add
```

---

# Module Naming

Module names use lowercase identifiers.

Valid:

```text
math
users.auth
http.client
```

Invalid:

```text
Math
Users.Auth
HTTP.Client
```

This improves consistency across operating systems.

---

# Import Statement

Modules are imported using the `import` keyword.

Example:

```jua
import math
```

---

# Nested Imports

Nested modules are imported using dot notation.

Example:

```jua
import users.authentication
```

---

# Using Imported Symbols

Imported symbols are referenced through their module namespace.

Example:

```jua
import math

create result = math.sqrt(25)
```

---

# Namespace Qualification

Version 0.1 requires namespace qualification.

Example:

```jua
math.sqrt(25)
```

instead of:

```jua
sqrt(25)
```

This avoids name collisions.

---

# Import Resolution

Import resolution occurs during semantic analysis.

The compiler:

1. Locates the target module.
2. Parses the module.
3. Builds the module AST.
4. Resolves exported symbols.
5. Makes exports available to the importing module.

---

# Export Statement

Symbols must be exported explicitly.

Example:

```jua
export function add(a: int, b: int): int

    return a + b

end
```

---

# Exported Symbols

Version 0.1 allows exporting:

* Functions
* Interfaces
* Traits
* Constants

---

# Private Symbols

Symbols are private by default.

Example:

```jua
function helper()
end
```

This function is visible only inside its module.

---

# Public API Design

Only symbols intended for external use should be exported.

Example:

```jua
function validate()
end

export function authenticate()
end
```

Only `authenticate()` becomes part of the public API.

---

# Importing Interfaces

Example:

```jua
import models.user

create user: models.user.User
```

---

# Importing Traits

Example:

```jua
import traits.printable
```

---

# Circular Dependencies

Circular dependencies are prohibited.

Example:

```text
module A imports B
module B imports A
```

Invalid.

---

# Circular Dependency Diagnostic

Example:

```text
Circular dependency detected:

users.auth
    -> users.storage
    -> users.auth
```

---

# Module Initialization

Modules are initialized exactly once.

Initialization occurs when first loaded.

---

# Initialization Order

Dependencies are initialized before dependents.

Example:

```text
core
    ↓
math
    ↓
application
```

Execution order:

```text
core
math
application
```

---

# Symbol Resolution

The compiler resolves symbols in the following order:

1. Local scope
2. Function scope
3. Module scope
4. Imported module symbols

---

# Name Collisions

Version 0.1 requires explicit qualification.

Example:

```jua
import statistics
import math
```

Both may define:

```jua
mean()
```

Access remains unambiguous:

```jua
statistics.mean()
math.mean()
```

---

# Module Boundaries

Modules form compilation units.

The compiler may compile modules independently provided semantic dependencies are satisfied.

---

# Future Evolution

Future versions may introduce:

* Import aliases
* Re-exporting
* Selective imports
* Package-level visibility
* Incremental compilation metadata

These features must preserve readability and predictability.

---

# Compliance

A conforming implementation must enforce all module system rules defined in this specification.
