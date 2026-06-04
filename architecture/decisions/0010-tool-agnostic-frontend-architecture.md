# ADR-0010 — Tool-Agnostic Frontend Architecture

---
status: accepted
date: 2026-06-03
decision-makers:
  - Edmilson Cassecasse
---

# Adopt a Tool-Agnostic Frontend Architecture

## Context and Problem Statement

The Jua compiler frontend may initially rely on tools such as JFlex and parser generators. However, language projects often evolve over many years, and implementation technologies frequently change.

Jua requires an architecture that prevents tooling choices from becoming permanent architectural constraints.

The question addressed by this decision is:

> How should the compiler frontend be structured to support future replacement of lexer and parser technologies?

## Decision Drivers

* Maintainability
* Replaceability
* Technology independence
* Long-term scalability
* Reduced vendor lock-in
* Clean architecture

## Considered Options

* Direct Tool Integration
* Tool-Agnostic Frontend Architecture
* Fully Handwritten Frontend

## Decision Outcome

Chosen option: "Tool-Agnostic Frontend Architecture", because it allows implementation technologies to evolve without requiring changes throughout the compiler.

Frontend subsystems shall expose stable interfaces while encapsulating tool-specific implementations.

### Consequences

* Good, because JFlex can be replaced without affecting compiler consumers.
* Good, because experimentation with alternative technologies becomes easier.
* Good, because implementation dependencies remain localized.
* Good, because architectural flexibility increases.
* Bad, because additional abstraction layers are required.
* Bad, because initial implementation effort increases slightly.

### Confirmation

Compliance is confirmed by ensuring that:

* Generated code remains isolated.
* Tool-specific code is encapsulated behind adapters.
* Compiler layers depend on stable interfaces rather than tooling implementations.
* Replacement of lexer or parser generators requires minimal architectural changes.

## Pros and Cons of the Options

### Direct Tool Integration

* Good, because implementation is initially faster.
* Good, because fewer abstractions are required.
* Bad, because tooling becomes deeply coupled to the compiler.
* Bad, because replacement becomes expensive.

### Tool-Agnostic Frontend Architecture

* Good, because technology choices remain flexible.
* Good, because long-term maintenance improves.
* Good, because architectural boundaries remain clear.
* Bad, because some additional complexity is introduced.

### Fully Handwritten Frontend

* Good, because there are no external generation dependencies.
* Good, because implementation control is maximized.
* Bad, because development effort increases substantially.
* Bad, because educational contributors may face a steeper learning curve.

## More Information

This ADR directly supports the use of JFlex during early development while preserving future freedom to adopt alternative implementations.
