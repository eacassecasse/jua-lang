---

status: accepted
date: 2026-06-10
decision-makers:

* Edmilson Cassecasse

---

# ADR-0020: Entry Point Resolution

## Context and Problem Statement

Every programming language must define how program execution begins.

Different languages adopt different strategies. Some require a dedicated entry-point function, while others begin execution from top-level statements.

Examples include:

```text
C
Java
C#
```

which require a designated entry point such as:

```text
main()
```

and:

```text
Python
JavaScript
Ruby
```

which execute top-level statements directly.

During the design of Jua 0.1, two competing objectives emerged.

The first objective was to make the language approachable for beginners by allowing simple programs to execute without requiring boilerplate code.

The second objective was to provide a structured entry-point mechanism suitable for larger applications and future tooling.

The question to be resolved was:

> How should Jua determine where program execution begins?

## Decision Drivers

* Minimize friction for new programmers.
* Support both scripting and application development.
* Maintain a predictable execution model.
* Reduce unnecessary boilerplate.
* Provide a clear path toward larger program organization.
* Keep runtime startup behavior simple.
* Preserve future extensibility.

## Considered Options

* Require a `main` function.
* Execute top-level statements only.
* Use a hybrid entry-point model.
* Require explicit entry-point declarations.

## Decision Outcome

Chosen option:

**"Use a hybrid entry-point model"**, because it balances beginner accessibility with structured application development while keeping the execution model simple and predictable.

### Consequences

* Good, because simple programs can execute without boilerplate.
* Good, because larger applications can define an explicit entry point.
* Good, because the language supports both scripting and application-oriented workflows.
* Good, because the runtime startup model remains straightforward.
* Good, because future tooling can easily identify application entry points.
* Bad, because semantic analysis must determine whether a valid `main` function exists.
* Bad, because two execution paths must be documented and tested.

### Confirmation

The decision is confirmed when:

* Programs containing a valid `main` function begin execution at `main`.
* Programs without a `main` function execute top-level statements.
* The semantic analyzer correctly identifies entry-point behavior.
* Compiler integration tests verify both execution modes.
* The language specification documents both scenarios.

## Pros and Cons of the Options

### Require a `main` Function

Example:

```jua
function main()

    print("Hello")

end
```

* Good, because execution behavior is always explicit.
* Good, because tooling can easily locate the entry point.
* Good, because it aligns with many established languages.
* Neutral, because experienced developers are familiar with the model.
* Bad, because beginners must learn additional structure before writing simple programs.
* Bad, because small scripts require unnecessary boilerplate.
* Bad, because experimentation becomes less convenient.

### Execute Top-Level Statements Only

Example:

```jua
print("Hello")
```

* Good, because programs are extremely easy to write.
* Good, because no entry-point boilerplate is required.
* Good, because the language feels approachable.
* Neutral, because many scripting languages use this approach successfully.
* Bad, because large applications may become less structured.
* Bad, because tooling has no explicit application entry point.
* Bad, because application startup behavior may become harder to reason about.

### Use a Hybrid Entry-Point Model

Rules:

```text
If a valid main function exists,
execution begins at main.

Otherwise,
top-level statements execute.
```

* Good, because it supports both educational and professional use cases.
* Good, because beginners can start immediately.
* Good, because larger applications can adopt a structured organization.
* Good, because migration from scripts to applications is natural.
* Good, because future tooling can leverage explicit entry points.
* Neutral, because semantic analysis requires a small amount of additional logic.
* Bad, because two execution modes must be supported.

### Require Explicit Entry-Point Declarations

Example:

```text
@entry
function start()
```

* Good, because entry points become fully configurable.
* Good, because the intent is explicit.
* Neutral, because some languages and frameworks adopt similar approaches.
* Bad, because additional syntax is required.
* Bad, because the language currently has no annotation system.
* Bad, because the added flexibility provides little benefit for Jua 0.1.

## More Information

Under this decision, Jua 0.1 follows the following startup rules.

### Programs with a Main Function

Example:

```jua
function main()

    print("Hello")

end
```

Execution begins at:

```text
main()
```

Top-level executable statements are ignored.

### Programs without a Main Function

Example:

```jua
print("Hello")
```

Execution begins at the first top-level statement.

### Main Function Requirements

When present, `main` must:

* Be a function.
* Exist only once within the program.
* Be visible to the runtime startup process.

The following is invalid:

```jua
create main = 10
```

because `main` is reserved for entry-point resolution when used in that role.

This decision supports the educational goals of Jua while providing a clear path toward larger and more structured applications.

Future versions may revisit entry-point behavior if:

* Package-based applications become common.
* Multi-module startup scenarios are introduced.
* Application manifests are added.
* Build tooling requires alternative startup mechanisms.

Any future changes should preserve compatibility with existing Jua programs whenever possible.

Related ADRs:

* ADR-0008: Layered Compiler Architecture
* ADR-0011: Education as First-Class Concern
* ADR-0015: Repeat Loop Deferral
* ADR-0019: Exception Handling Deferral

Related Specifications:

* specs/modules/modules.md
* specs/semantics/scope-resolution.md
* specs/grammar/functions.md
* specs/versioning/jua-0.1-language-spec.md

