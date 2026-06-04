# Language Design Principles

## Purpose

This document defines the foundational principles that guide the evolution of the Jua programming language.

These principles serve as decision-making criteria when evaluating language proposals, RFCs, compiler features, tooling enhancements, and educational content.

Any future change should be evaluated against these principles.

---

# Principle 1: Readability First

Code is read significantly more often than it is written.

Jua prioritizes readability over syntactic brevity.

Example:

```jua
if age >= 18
    print("Adult")
end
````

is preferred over highly symbolic alternatives.

Language features should improve understanding rather than reduce character count.

---

# Principle 2: Explicit Over Magical

Language behavior should be visible and predictable.

Developers should understand why code behaves a certain way without requiring knowledge of hidden rules or implicit transformations.

Examples include:

* explicit imports
* explicit scope boundaries
* explicit trait implementations

Jua intentionally avoids excessive metaprogramming.

---

# Principle 3: Progressive Complexity

Beginners should be productive immediately.

Professionals should have access to stronger guarantees as projects evolve.

Example:

```jua
let name = "Edmilson"
```

may later become:

```jua
let name: string = "Edmilson"
```

without changing core language concepts.

---

# Principle 4: Educational Accessibility

Jua is designed to reduce barriers to learning programming.

Language features should be evaluated according to:

* cognitive load
* conceptual complexity
* learning progression

Educational value is considered a first-class design concern.

---

# Principle 5: Excellent Diagnostics

Error messages should teach.

Diagnostics should explain:

* what happened
* why it happened
* how to fix it

Example:

Instead of:

```text
Unexpected token.
```

Prefer:

```text
Expected ')' to close function call.

Did you mean:

print(name)
```

---

# Principle 6: Low Resource Consumption

Jua should remain usable on:

* school computers
* low-end laptops
* educational environments
* cloud functions

Language features that introduce significant runtime or tooling overhead should be carefully justified.

---

# Principle 7: Specification-Driven Evolution

Language behavior must be defined through specifications rather than implementation details.

The specification remains the source of truth.

Compiler implementations must conform to the specification.

---

# Principle 8: Long-Term Maintainability

Short-term convenience should not compromise long-term maintainability.

Features should be evaluated according to:

* implementation complexity
* maintenance cost
* ecosystem impact
* educational impact

---

# Principle 9: Stable Foundations

Breaking changes should be minimized.

Language evolution should prioritize:

* predictability
* compatibility
* ecosystem stability

Major changes should follow the RFC and ADR processes.

---

# Principle 10: Tooling as a First-Class Citizen

A programming language is more than its syntax.

Jua should provide a complete development experience including:

* formatter
* linter
* language server
* debugger
* package manager
* documentation generation

Tooling considerations should be included during language design discussions.
