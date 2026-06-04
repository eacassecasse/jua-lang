# ADR-0006 — Traits Over Classical Inheritance

---
status: accepted
date: 2026-06-02
decision-makers:
  - Edmilson Cassecasse
---

# Adopt Traits as the Primary Reuse Mechanism

## Context and Problem Statement

Many object-oriented languages rely heavily on inheritance hierarchies for code reuse and abstraction. While inheritance can be effective, deep inheritance trees often become difficult to understand, maintain, and evolve.

Jua requires an abstraction mechanism that remains accessible to beginners while avoiding common inheritance-related complexities.

The question addressed by this decision is:

> Should Jua adopt classical inheritance or traits as its primary abstraction mechanism?

## Decision Drivers

* Simplicity
* Readability
* Maintainability
* Explicit behavior composition
* Tooling friendliness
* Educational clarity

## Considered Options

* Classical Inheritance
* Traits
* Prototype-Based Inheritance

## Decision Outcome

Chosen option: "Traits", because they provide explicit behavior composition without introducing the complexity commonly associated with inheritance hierarchies.

Traits align with Jua's philosophy of explicit behavior and predictable code organization.

### Consequences

* Good, because behavior reuse remains explicit.
* Good, because deep inheritance trees are avoided.
* Good, because tooling can analyze trait composition more effectively.
* Good, because code organization becomes easier to understand.
* Bad, because developers familiar with traditional OOP may require an adaptation period.
* Bad, because some inheritance patterns must be expressed differently.

### Confirmation

Compliance is confirmed by ensuring that:

* Traits serve as the primary abstraction mechanism.
* Language documentation prioritizes trait-based design patterns.
* New language features avoid introducing implicit inheritance hierarchies.

## Pros and Cons of the Options

### Classical Inheritance

* Good, because it is widely understood.
* Good, because many existing patterns rely on it.
* Bad, because inheritance hierarchies often become difficult to maintain.
* Bad, because behavior can become implicit and difficult to trace.

### Traits

* Good, because composition remains explicit.
* Good, because reuse is more modular.
* Good, because maintenance is simplified.
* Bad, because some developers require familiarity with the model.

### Prototype-Based Inheritance

* Good, because it is highly flexible.
* Good, because behavior can be modified dynamically.
* Bad, because reasoning about behavior becomes more difficult.
* Bad, because static analysis becomes more challenging.

## More Information

Traits are intended to become one of the defining characteristics of Jua's abstraction model.
