# ADR-0008 — Layered Compiler Architecture
---
status: accepted
date: 2026-06-03
decision-makers:
  - Edmilson Cassecasse
---

# Adopt a Layered Compiler Architecture

## Context and Problem Statement

Compiler systems often become difficult to maintain when lexical analysis, parsing, semantic analysis, optimization, and code generation are tightly coupled.

Jua requires an architecture that supports long-term maintainability and independent evolution of compiler subsystems.

## Decision Drivers

* Separation of concerns
* Maintainability
* Testability
* Scalability
* Future backend support

## Considered Options

* Monolithic compiler architecture
* Layered compiler architecture
* Plugin-based architecture

## Decision Outcome

Chosen option: "Layered compiler architecture."

The compiler shall be divided into:

* Frontend
* Middle-end
* Backend

### Consequences

* Good, because responsibilities remain clearly separated.
* Good, because testing becomes easier.
* Good, because future backends can be added independently.
* Bad, because interfaces between layers require careful design.

### Confirmation

Compiler modules must communicate through well-defined contracts such as tokens, ASTs, HIR, MIR, and IR structures.

## Pros and Cons of the Options

### Monolithic architecture

* Good, because initial implementation is simpler.
* Bad, because maintainability deteriorates over time.

### Layered architecture

* Good, because complexity is isolated.
* Good, because evolution becomes easier.
* Good, because subsystem replacement becomes feasible.

### Plugin-based architecture

* Good, because extensibility is maximized.
* Bad, because implementation complexity increases substantially.

## More Information

This ADR establishes the foundation for frontend, middle-end, and backend module boundaries.
