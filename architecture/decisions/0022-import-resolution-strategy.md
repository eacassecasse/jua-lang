---

status: accepted
date: 2026-06-10
decision-makers:

* Edmilson Cassecasse

---

# ADR-0021: Module Visibility Model

## Context and Problem Statement

As Jua evolves beyond single-file programs, modules become essential for organizing code, controlling dependencies, and exposing reusable functionality.

Without a visibility model, every symbol defined within a module would be accessible from every other module. Such an approach can lead to:

* Accidental coupling between modules.
* Difficulty evolving internal implementations.
* Reduced maintainability.
* Increased risk of naming conflicts.

Modern programming languages typically provide mechanisms to distinguish between public APIs and implementation details.

Examples include:

```text
public
private
protected
internal
export
```

Although these mechanisms differ in syntax and capability, they serve the same purpose: controlling visibility across module boundaries.

The design team needed to determine how symbols should be exposed from Jua modules.

The question to be resolved was:

> How should Jua control the visibility of symbols across module boundaries?

## Decision Drivers

* Promote encapsulation.
* Encourage clean module boundaries.
* Minimize language complexity.
* Reduce accidental coupling.
* Keep the visibility model easy to teach.
* Support future ecosystem growth.
* Maintain predictable import behavior.

## Considered Options

* Everything is public.
* Everything is private unless exported.
* Explicit public and private keywords.
* Multi-level visibility modifiers.

## Decision Outcome

Chosen option:

**"Everything is private unless exported"**, because it provides strong encapsulation while maintaining a simple and predictable module model.

### Consequences

* Good, because module authors explicitly define their public API.
* Good, because implementation details remain hidden by default.
* Good, because accidental coupling is reduced.
* Good, because symbol resolution remains straightforward.
* Good, because the visibility model remains easy to understand.
* Bad, because developers must explicitly export symbols intended for external use.
* Bad, because forgetting to export a symbol may initially cause confusion.

### Confirmation

The decision is confirmed when:

* Symbols are inaccessible from other modules unless exported.
* The semantic analyzer enforces export visibility rules.
* Import resolution only exposes exported symbols.
* Compiler tests verify public and private visibility behavior.
* The language specification defines export-based visibility.

## Pros and Cons of the Options

### Everything Is Public

Example:

```jua
function validate()
end

function process()
end
```

Both functions are automatically accessible from other modules.

* Good, because the model is simple.
* Good, because no export declarations are required.
* Neutral, because small projects may not notice visibility issues.
* Bad, because internal implementation details become exposed.
* Bad, because accidental dependencies become common.
* Bad, because refactoring becomes more difficult.

### Everything Is Private Unless Exported

Example:

```jua
export function process()
end

function validate()
end
```

Only `process` is visible outside the module.

* Good, because encapsulation is preserved.
* Good, because public APIs are explicit.
* Good, because module boundaries remain clear.
* Good, because implementation details remain protected.
* Neutral, because developers must learn export semantics.
* Bad, because exporting symbols requires additional declarations.

### Explicit Public and Private Keywords

Example:

```jua
public function process()
end

private function validate()
end
```

* Good, because visibility intent is explicit.
* Good, because the syntax is familiar to many developers.
* Neutral, because it provides fine-grained visibility control.
* Bad, because additional keywords are required.
* Bad, because the language grammar becomes larger.
* Bad, because it provides little benefit over export-based visibility.

### Multi-Level Visibility Modifiers

Example:

```text
public
private
protected
internal
```

* Good, because visibility control becomes highly flexible.
* Good, because large applications can express complex access rules.
* Neutral, because many enterprise-oriented languages use similar systems.
* Bad, because the language becomes harder to learn.
* Bad, because compiler implementation becomes more complex.
* Bad, because Jua 0.1 does not require this level of sophistication.

## More Information

Under this decision, all module-level symbols are private by default.

The following declarations may be exported:

* Functions.
* Objects.
* Interfaces.
* Traits.
* Constants.

Example:

```jua
export function calculate()

end

function validate()

end
```

In this example:

```text
calculate → public
validate → private
```

Imports only expose exported symbols.

Example:

Module A:

```jua
export function add(a, b)

    return a + b

end

function validate()

end
```

Module B:

```jua
import math

math.add(1, 2)
```

Valid.

```jua
math.validate()
```

Invalid.

The compiler must report an appropriate diagnostic indicating that the symbol is not visible outside its defining module.

This decision establishes a simple visibility model suitable for Jua 0.1 while preserving the possibility of introducing additional visibility controls in future versions if justified by real-world usage.

Future visibility enhancements may be considered if:

* Large-scale applications require additional access controls.
* Package-level visibility becomes necessary.
* Ecosystem growth reveals limitations in the export-only model.

Any future enhancement should preserve backward compatibility whenever possible.

Related ADRs:

* ADR-0008: Layered Compiler Architecture
* ADR-0010: Tool-Agnostic Frontend Architecture
* ADR-0011: Education as First-Class Concern
* ADR-0020: Entry Point Resolution

Related Specifications:

* specs/modules/modules.md
* specs/modules/imports.md
* specs/semantics/scope-resolution.md
* specs/versioning/jua-0.1-language-spec.md

