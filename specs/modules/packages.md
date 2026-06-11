# Modules and Packages

Version: 0.1 Draft

Status: Proposed

---

# Purpose

This document defines how source code is organized in the Jua programming language.

It specifies:

* Modules
* Packages
* Imports
* Exports
* Visibility rules
* Compilation units

The goal is to provide a simple organizational model suitable for beginners while remaining scalable for large applications.

---

# Design Philosophy

Jua follows the principle:

> Code should be easy to find, easy to understand, and easy to reuse.

The module system should:

* Remain beginner-friendly
* Avoid unnecessary boilerplate
* Scale from small scripts to large applications
* Support future package management systems
* Support WASM-first compilation

---

# Design Goals

The module system should:

* Minimize ceremony
* Encourage code organization
* Support encapsulation
* Support reuse
* Support independent compilation
* Support future ecosystem growth

---

# Core Concepts

Jua distinguishes between:

```text
Package
    Collection of modules

Module
    Single source file
```

---

# Package

A package is a directory containing related source files.

Example:

```text
school/
│
├── student.jua
├── teacher.jua
├── course.jua
└── enrollment.jua
```

The directory:

```text
school
```

is a package.

---

# Module

A module corresponds to a single source file.

Example:

```text
student.jua
```

represents one module.

---

# Rationale

The file-to-module relationship is simple:

```text
1 file = 1 module
```

This reduces ambiguity and simplifies tooling.

---

# Default Module Name

A module's name is derived from its filename.

Example:

```text
student.jua
```

becomes:

```text
student
```

---

# Package Declaration

Version 0.1 does not require package declarations.

Example:

```jua
function calculateGrade()

end
```

Valid.

The compiler determines package membership from the directory structure.

---

# Rationale

This approach:

* Reduces boilerplate
* Simplifies learning
* Mirrors filesystem organization
* Keeps source files concise

---

# Importing Modules

Modules are imported using the `import` keyword.

General form:

```jua
import package.module
```

Example:

```jua
import school.student
```

---

# Import Resolution

The compiler resolves imports using package hierarchy.

Example:

```text
school/
└── student.jua
```

Imported as:

```jua
import school.student
```

---

# Nested Packages

Packages may contain subpackages.

Example:

```text
school/
│
├── models/
│   └── student.jua
│
└── services/
    └── grading.jua
```

Imports:

```jua
import school.models.student
import school.services.grading
```

---

# Exporting Symbols

Modules explicitly export symbols.

Example:

```jua
export function calculateGrade()

end
```

---

Example:

```jua
export interface Student

end
```

---

Example:

```jua
export trait Serializable

end
```

---

# Export Purpose

Exports define the module's public API.

Non-exported declarations remain internal.

---

# Visibility Rules

Version 0.1 supports two visibility levels:

```text
Public
Private
```

---

# Public Symbols

Exported declarations are public.

Example:

```jua
export function enroll()

end
```

Accessible from other modules.

---

# Private Symbols

Declarations without export are private.

Example:

```jua
function validateEnrollment()

end
```

Accessible only inside the module.

---

# Importing Exported Symbols

Example:

Module:

```jua
export function greet()

    print("Hello")

end
```

Consumer:

```jua
import greetings

greet()
```

---

# Namespace Access

Version 0.1 supports qualified access.

Example:

```jua
import school.student

student.create()
```

---

# Direct Imports

Future versions may support:

```jua
import school.student.create
```

This feature is not part of Version 0.1.

---

# Wildcard Imports

Example:

```jua
import school.*
```

Not supported in Version 0.1.

---

# Rationale

Wildcard imports:

* Reduce clarity
* Increase ambiguity
* Complicate static analysis

---

# Circular Dependencies

Circular dependencies are prohibited.

Example:

```text
student.jua
imports teacher

teacher.jua
imports student
```

Compiler Error:

```text
Circular dependency detected.
```

---

# Compilation Units

Each module represents an independent compilation unit.

Example:

```text
student.jua
```

may be compiled separately from:

```text
teacher.jua
```

subject to dependency resolution.

---

# Main Entry Point

A program may define:

```jua
function main()

end
```

---

# Entry Point Behavior

If a `main()` function exists:

```text
Execution begins at main()
```

---

Example:

```jua
function main()

    print("Hello")

end
```

---

# Top-Level Execution

If no `main()` function exists:

```text
Top-level statements execute in file order.
```

Example:

```jua
print("Hello")
```

Valid.

---

# Rationale

This hybrid model supports:

* Scripts
* Learning exercises
* Enterprise applications

without forcing a single programming style.

---

# Package Root

Version 0.1 assumes a project root.

Example:

```text
project/
│
├── src/
│   ├── app.jua
│   └── school/
│       └── student.jua
│
└── jua.toml
```

The exact project manifest specification will be defined separately.

---

# Compiler Behavior

Imports do not duplicate code.

Instead:

```text
Parser
    ↓

AST

    ↓

Semantic Resolution

    ↓

Dependency Graph

    ↓

Compilation
```

Imported modules become referenced compilation units.

---

# Rationale

This avoids:

* Code duplication
* Larger binaries
* Redundant parsing

and follows established compiler architecture.

---

# Imported Symbol Resolution

Example:

```jua
import school.student
```

The compiler:

1. Locates module.
2. Parses module.
3. Resolves exports.
4. Makes exported symbols available.
5. Preserves module boundaries.

---

# Diagnostics

Diagnostics should identify:

* Missing modules
* Missing exports
* Circular dependencies
* Duplicate symbols

Example:

```text
Cannot resolve import:

school.student
```

---

# Educational Guidance

Educational materials should encourage:

* Small modules
* Clear exports
* Explicit imports
* Logical package structure

Preferred:

```text
school/
├── student.jua
├── teacher.jua
└── course.jua
```

Over:

```text
everything.jua
```

---

# Future Evolution

Future versions may introduce:

```text
Module aliases
Selective imports
Package registries
Dependency manifests
Remote packages
Workspace support
Incremental compilation
```

Such features must remain compatible with Version 0.1 module semantics.

---

# Compliance

A conforming implementation must implement the module and package behavior defined in this specification.
