# ADR-0014 - Immutable By Default Variables
---

status: accepted
date: 2026-06-08
decision-makers:

* Edmilson Cassecasse

Consulted:
* ChatGPT

Informed:
* Future contributors
* Compiler implementers
* Language designers
* Toolchain maintainers

---

# Immutable by Default Variables

## Context and Problem Statement

One of the most fundamental decisions in the design of a programming language is how it handles state changes. Variable mutability directly influences readability, maintainability, correctness, compiler optimization opportunities, and the overall developer experience.

Historically, many popular programming languages adopted mutable variables as the default behavior. Languages such as Python, JavaScript, Lua, Ruby, and PHP allow values to be reassigned freely after declaration. While this approach can initially appear intuitive, experience across large software systems has shown that uncontrolled mutation is a common source of defects, unexpected behavior, and maintenance challenges.

As Jua is being designed as both an educational language and a professional development platform, the language must provide a model that remains accessible to beginners while encouraging practices that scale to larger and more complex applications.

The problem addressed by this ADR is:

> Should variables in Jua be mutable by default, immutable by default, or follow a different mutability model?

This decision affects nearly every aspect of the language, including variable declarations, collections, function parameters, concurrency, compiler optimizations, and future type system evolution.

---

## Decision Drivers

* Educational clarity and predictability
* Reduction of accidental state changes
* Long-term code maintainability
* Readability of variable declarations
* Support for static analysis and tooling
* Compatibility with gradual typing
* Alignment with modern language design practices
* Future support for concurrency and parallelism
* Compiler optimization opportunities
* Ease of reasoning about program behavior

---

## Considered Options

* Mutable by Default
* Immutable by Default with Explicit Mutability
* Fully Immutable Language

---

## Decision Outcome

Chosen option:

**Immutable by Default with Explicit Mutability**

Variables declared using the `create` keyword are immutable and cannot be reassigned after initialization.

Variables that require reassignment must be explicitly declared using the `mutable` modifier.

Example:

```jua
create name = "Ana"

create mutable counter = 0
```

The selected approach provides a balance between simplicity and safety. It preserves the accessibility expected from an educational language while introducing developers to modern software engineering practices from the beginning of their learning journey.

By making mutation explicit, the language encourages developers to think about state changes intentionally rather than allowing them to occur implicitly throughout the codebase.

---

### Consequences

#### Positive Consequences

* Variable declarations clearly communicate whether mutation is expected.
* Programs become easier to reason about because state changes are visible.
* Accidental reassignment errors are reduced.
* Immutable values simplify debugging and testing.
* Future concurrency models become safer and easier to implement.
* Static analysis tools can provide stronger guarantees.
* Compiler optimizations become easier because immutable values cannot change unexpectedly.
* The language aligns with successful modern language design trends.

#### Neutral Consequences

* Developers must learn an additional keyword (`mutable`).
* Some code examples from mutable-first languages require adaptation when translated to Jua.
* Educational material must explain the distinction between immutable and mutable variables.

#### Negative Consequences

* Beginners coming from languages such as JavaScript or Python may initially find reassignment restrictions unfamiliar.
* Some short scripts may require additional declarations where mutation is necessary.
* Existing programming tutorials from other ecosystems cannot always be copied directly into Jua.

---

### Confirmation

Compliance with this ADR can be verified through several mechanisms:

* The language specification explicitly defines variables as immutable by default.
* The compiler rejects reassignment attempts on immutable variables.
* Static analysis tools validate mutability rules.
* Conformance tests verify expected compiler behavior.
* Documentation and educational materials consistently reflect the mutability model.

Example validation:

```jua
create age = 18

age = 21
```

Expected result:

```text
Cannot assign to immutable variable 'age'.

Declare the variable as mutable if reassignment is required.
```

---

## Pros and Cons of the Options

### Mutable by Default

Variables can be reassigned unless explicitly protected.

#### Pros

* Familiar to developers coming from many existing languages.
* Requires fewer keywords in simple scripts.
* Easy to explain at the earliest stages of learning.

#### Cons

* State changes can occur unexpectedly.
* Program behavior becomes harder to reason about.
* Static analysis opportunities are reduced.
* Larger codebases become more difficult to maintain.
* Future concurrency models become more complex.

---

### Immutable by Default with Explicit Mutability

Variables are immutable unless declared as mutable.

#### Pros

* Mutation becomes intentional and visible.
* Program behavior becomes easier to understand.
* Compiler optimizations become more effective.
* Static analysis tools become more powerful.
* Concurrency support becomes safer.
* Aligns with modern language design trends.
* Encourages good software engineering habits early.

#### Cons

* Introduces an additional language keyword.
* May initially surprise developers from mutable-first languages.
* Requires developers to explicitly opt into mutation.

---

### Fully Immutable Language

All values are immutable and mutation is never permitted.

#### Pros

* Eliminates many classes of state-related bugs.
* Enables powerful compiler optimizations.
* Simplifies reasoning about program execution.

#### Cons

* Creates a steeper learning curve.
* Common programming tasks become more complex.
* Educational accessibility decreases.
* Adoption barriers increase for developers familiar with imperative programming.

---

## More Information

This decision is consistent with the broader philosophy of Jua:

* Readability First
* Explicit Over Magical
* Progressive Complexity
* Low Resource Consumption
* Excellent Diagnostics

The decision also establishes a foundation for several future language capabilities, including:

* Immutable collections
* Ownership analysis
* Borrowing semantics
* Concurrency primitives
* Advanced optimization passes
* Safer asynchronous programming

Related specifications:

* `specs/type-system/mutability.md`
* `specs/type-system/primitive-types.md`
* `specs/type-system/collections.md`

Related ADRs:

* ADR-0004 — Local-by-Default Variables
* ADR-0005 — Gradual Typing
* ADR-0006 — Traits over Inheritance

This decision should be revisited only if future language evolution introduces a fundamentally different memory management or ownership model.

