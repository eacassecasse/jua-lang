---

status: accepted
date: 2026-06-10
decision-makers:

* Edmilson Cassecasse

---

# ADR-0023: Standard Library Injection

## Context and Problem Statement

Jua 0.1 provides a set of built-in functions that are expected to be available in every program without requiring explicit imports.

Examples include:

```jua id="b7k2qp"
print("Hello")
```

```jua id="q9m1sd"
assert(condition)
```

```jua id="x3p8tv"
length(list)
```

These functions form the minimal standard library required for basic program execution, debugging, and data manipulation.

A design decision is required to determine how these built-in symbols become available in user programs.

The options include requiring explicit imports, automatically injecting them into each module, or exposing them through a special standard library namespace.

The question to be resolved was:

> How should standard library and built-in symbols be made available to all Jua programs?

## Decision Drivers

* Ensure immediate usability of the language.
* Avoid unnecessary boilerplate for common operations.
* Maintain simplicity in user-facing code.
* Preserve a clean module system.
* Keep compiler implementation straightforward.
* Avoid coupling built-ins with user-defined modules.
* Ensure predictable availability of core functions.

## Considered Options

* Require explicit standard library imports.
* Provide a dedicated `std` module.
* Automatically inject built-in symbols into the global scope.
* Hybrid model combining explicit and implicit imports.

## Decision Outcome

Chosen option:

**"Automatically inject built-in symbols into the global scope before semantic analysis"**, because it provides the simplest and most accessible developer experience while maintaining a clean separation between built-in functionality and user-defined modules.

### Consequences

* Good, because programs can use core functions immediately.
* Good, because no boilerplate is required for standard operations.
* Good, because beginner experience is simplified.
* Good, because compiler can initialize a predefined symbol table.
* Good, because built-ins remain consistent across all programs.
* Bad, because the global namespace is partially populated implicitly.
* Bad, because built-in symbols must be carefully managed to avoid conflicts.

### Confirmation

The decision is confirmed when:

* Built-in symbols are available in every program without imports.
* The compiler initializes the global symbol table with built-ins before semantic analysis.
* Built-in symbols cannot be redefined by user code.
* Compiler tests verify availability of all standard library functions in all compilation contexts.
* The language specification documents built-in injection behavior.

## Pros and Cons of the Options

### Require Explicit Standard Library Imports

Example:

```jua id="r8c1wm"
import std

std.print("Hello")
```

* Good, because all dependencies are explicit.
* Good, because the global namespace remains clean.
* Neutral, because this approach is common in modular languages.
* Bad, because it introduces unnecessary boilerplate for basic operations.
* Bad, because it reduces beginner accessibility.
* Bad, because it complicates simple scripts.

### Provide a Dedicated `std` Module

Example:

```jua id="m5t9qp"
import std

std.print("Hello")
```

* Good, because standard library usage is explicit and structured.
* Good, because it aligns with modular design principles.
* Neutral, because it is widely used in many languages.
* Bad, because it requires explicit imports even for basic functionality.
* Bad, because it reduces simplicity for small programs.
* Bad, because it adds friction for beginners.

### Automatically Inject Built-In Symbols into Global Scope

Example:

```jua id="k2n7fd"
print("Hello")
assert(x > 0)
```

* Good, because no imports are required for core functionality.
* Good, because programs are immediately executable.
* Good, because beginner experience is improved.
* Good, because reduces friction in early learning stages.
* Neutral, because similar approaches exist in scripting environments.
* Bad, because global scope is implicitly populated.
* Bad, because care must be taken to avoid naming conflicts.

### Hybrid Model (Implicit + Explicit Imports)

Example:

```jua id="v9d3xa"
print("Hello")       // implicit
import std.math      // explicit
```

* Good, because it balances usability and structure.
* Neutral, because it introduces dual behavior in module resolution.
* Bad, because it increases conceptual complexity.
* Bad, because it complicates language specification and tooling.
* Bad, because it introduces two different dependency models.

## More Information

Under this decision, the compiler initializes a predefined set of built-in symbols before semantic analysis begins.

These include:

* print
* assert
* typeOf
* length

These symbols are treated as if they are declared in a hidden global module that is always present.

Rules:

* Built-in symbols are available in all programs.
* Built-in symbols cannot be overridden or redefined.
* Built-ins are injected before user-defined symbols are processed.
* Built-in resolution occurs before semantic validation of user code.

Example of valid usage:

```jua id="h3w8qp"
print("Hello World")
```

Example of invalid usage:

```jua id="z7m1xd"
function print()

end
```

This results in a compiler error indicating that built-in symbols cannot be redefined.

This decision ensures a consistent and predictable environment for all Jua programs while maintaining simplicity in both compiler design and user experience.

Future enhancements may introduce:

* A formal standard library module namespace.
* Optional explicit imports for built-ins.
* Separation between runtime built-ins and standard library modules.
* Namespacing of core utilities.

Any future modification should ensure backward compatibility with existing programs that rely on implicit availability of built-in symbols.

Related ADRs:

* ADR-0009: Runtime and Stdlib Separation
* ADR-0010: Tool-Agnostic Frontend Architecture
* ADR-0021: Module Visibility Model
* ADR-0022: Import Resolution Strategy

Related Specifications:

* specs/standard-library-spec/builtins.md
* specs/semantics/scope-resolution.md
* specs/semantics/compiler-phases.md
* specs/versioning/jua-0.1-language-spec.md

