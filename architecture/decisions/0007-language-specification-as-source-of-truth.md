# ADR-0007 — Language Specification as the Source of Truth

---
status: accepted
date: 2026-06-03
decision-makers:
  - Edmilson Cassecasse

consulted:
  - Compiler and language engineering best practices

informed:
  - Future compiler contributors
  - Toolchain maintainers
---
# Adopt the Language Specification as the Source of Truth

## Context and Problem Statement

Programming languages frequently evolve faster than their documentation. Over time, language behavior becomes defined by compiler implementation details rather than by a formal specification.

Jua requires a clear and authoritative definition of language behavior that remains independent from any particular compiler implementation.

The question addressed by this decision is:

> What should define the behavior of the Jua language?

## Decision Drivers

* Language consistency
* Multiple implementation support
* Long-term maintainability
* Architectural independence
* Conformance testing

## Considered Options

* Compiler as source of truth
* Specification as source of truth
* Community convention as source of truth

## Decision Outcome

Chosen option: "Specification as source of truth", because language behavior should be defined independently of implementation details.

### Consequences

* Good, because multiple compiler implementations become possible.
* Good, because conformance testing becomes feasible.
* Good, because language evolution becomes more disciplined.
* Bad, because specifications require continuous maintenance.

### Confirmation

All compiler behavior must be traceable to documented specifications located within the `specs/` directory.

## Pros and Cons of the Options

### Compiler as source of truth

* Good, because implementation and behavior always match.
* Bad, because implementation mistakes become language features.

### Specification as source of truth

* Good, because behavior remains formally defined.
* Good, because implementations can be validated.
* Good, because language evolution becomes controlled.

### Community convention as source of truth

* Good, because evolution may occur organically.
* Bad, because consistency becomes difficult to maintain.

## More Information

Future conformance suites will validate compiler behavior against the specification.
