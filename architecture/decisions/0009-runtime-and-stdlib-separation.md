# ADR-0009 — Runtime and Standard Library Separation

---
status: accepted
date: 2026-06-03
decision-makers:
  - Edmilson Cassecasse
---

# Separate Runtime and Standard Library Responsibilities

## Context and Problem Statement

Programming language ecosystems often blur the boundaries between runtime infrastructure and user-facing libraries. Over time, this can create architectural coupling that complicates maintenance, portability, testing, and future evolution.

Jua requires a clear separation between the components responsible for language execution and the APIs exposed to application developers.

The question addressed by this decision is:

> Should the runtime and standard library be treated as a single subsystem or as independent architectural components?

## Decision Drivers

* Separation of concerns
* Maintainability
* Portability
* Testability
* Runtime flexibility
* Long-term ecosystem evolution

## Considered Options

* Combined Runtime and Standard Library
* Separate Runtime and Standard Library
* Entirely External Standard Library

## Decision Outcome

Chosen option: "Separate Runtime and Standard Library", because execution infrastructure and developer-facing APIs serve fundamentally different purposes and evolve at different rates.

The runtime shall provide low-level execution services, while the standard library shall expose stable APIs for application development.

### Consequences

* Good, because runtime internals can evolve without breaking public APIs.
* Good, because portability improves across platforms.
* Good, because runtime testing and library testing can be performed independently.
* Good, because future runtime implementations become possible.
* Bad, because subsystem boundaries require additional architectural discipline.
* Bad, because some functionality may require coordination between both layers.

### Confirmation

Compliance is confirmed by ensuring that:

* Runtime components reside exclusively within the `runtime/` directory.
* User-facing APIs reside exclusively within the `stdlib/` directory.
* Runtime internals are not exposed directly to application developers.
* Standard library modules communicate through defined runtime interfaces.

## Pros and Cons of the Options

### Combined Runtime and Standard Library

* Good, because implementation may initially be simpler.
* Good, because fewer subsystem boundaries exist.
* Bad, because coupling increases over time.
* Bad, because future evolution becomes more difficult.

### Separate Runtime and Standard Library

* Good, because responsibilities remain clearly defined.
* Good, because subsystem evolution becomes easier.
* Good, because portability improves.
* Bad, because interfaces require careful design.

### Entirely External Standard Library

* Good, because runtime remains extremely small.
* Good, because ecosystem flexibility increases.
* Bad, because developer experience may become fragmented.
* Bad, because educational accessibility decreases.

## More Information

This decision establishes one of the primary architectural boundaries of the Jua ecosystem and directly supports future backend portability initiatives.
