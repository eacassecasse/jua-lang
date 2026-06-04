# ADR-0011 — Education as a First-Class Concern

---
status: accepted
date: 2026-06-03
decision-makers:
  - Edmilson Cassecasse
---

# Treat Education as a First-Class Architectural Concern

## Context and Problem Statement

Most programming languages are designed primarily for professional software development and later adapted for educational use. This often results in unnecessary complexity for beginners and fragmented learning experiences.

Jua is explicitly intended to serve both educational and professional audiences.

The question addressed by this decision is:

> Should educational requirements be treated as a secondary concern or as a fundamental design principle?

## Decision Drivers

* Educational accessibility
* Long-term adoption
* Developer onboarding
* Language readability
* Teaching effectiveness
* Community growth

## Considered Options

* Professional Development Focus
* Education as a First-Class Concern
* Education Through External Materials Only

## Decision Outcome

Chosen option: "Education as a First-Class Concern", because educational accessibility is one of the core objectives of the Jua language.

Educational considerations shall influence language design, diagnostics, documentation, examples, tooling, and ecosystem development.

### Consequences

* Good, because beginners can learn programming concepts more effectively.
* Good, because onboarding barriers are reduced.
* Good, because documentation and tooling remain learner-friendly.
* Good, because educational institutions become a viable adoption channel.
* Bad, because some advanced features may require additional design constraints.
* Bad, because educational clarity must be balanced against professional requirements.

### Confirmation

Compliance is confirmed by ensuring that:

* Educational impact is evaluated during language design discussions.
* Examples remain beginner-accessible.
* Diagnostics prioritize clarity and learning.
* Educational resources remain part of the official ecosystem.

## Pros and Cons of the Options

### Professional Development Focus

* Good, because optimization for enterprise use is straightforward.
* Good, because advanced features may be introduced rapidly.
* Bad, because accessibility decreases.
* Bad, because onboarding becomes more difficult.

### Education as a First-Class Concern

* Good, because learning and professional development remain aligned.
* Good, because adoption opportunities expand.
* Good, because developer experience improves.
* Bad, because additional design considerations are required.

### Education Through External Materials Only

* Good, because core language development remains focused.
* Good, because educational content can evolve independently.
* Bad, because the language itself may become less accessible.
* Bad, because educational goals become disconnected from language design.

## More Information

This ADR is one of the defining decisions that differentiates Jua from many existing programming languages.
