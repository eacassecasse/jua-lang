# ADR-0005 — Gradual Typing

---
status: accepted
date: 2026-06-02
decision-makers:
  - Edmilson Cassecasse
---

# Adopt a Gradual Typing System

## Context and Problem Statement

Jua aims to serve both beginner programmers and professional software developers. Beginners often benefit from dynamic typing because it reduces the amount of syntax required to write functional programs, while professional teams frequently require stronger compile-time guarantees to improve maintainability and reliability.

The language requires a typing model that supports both ease of learning and long-term scalability.

The question addressed by this decision is:

> Should Jua adopt dynamic typing, static typing, or a gradual typing model?

## Decision Drivers

* Educational accessibility
* Long-term maintainability
* Progressive learning experience
* Developer productivity
* Enterprise adoption potential
* Strong tooling support

## Considered Options

* Dynamic Typing
* Static Typing
* Gradual Typing

## Decision Outcome

Chosen option: "Gradual Typing", because it allows developers to begin with simple dynamic code while progressively introducing stronger type guarantees as applications become more complex.

This approach aligns with Jua's objective of supporting developers throughout their entire learning and professional journey.

### Consequences

* Good, because beginners can start writing programs without extensive type annotations.
* Good, because professional teams can introduce stronger type contracts where necessary.
* Good, because type inference reduces verbosity.
* Good, because tooling can provide richer diagnostics and autocomplete capabilities.
* Bad, because the compiler implementation becomes more complex.
* Bad, because interactions between typed and untyped code require additional design considerations.

### Confirmation

Compliance is confirmed by ensuring that:

* Type annotations remain optional in most scenarios.
* Type inference is available throughout the language.
* Explicit typing remains available for stronger guarantees.
* Compiler diagnostics correctly handle both typed and untyped code.

## Pros and Cons of the Options

### Dynamic Typing

* Good, because it minimizes syntactic overhead.
* Good, because it accelerates early experimentation.
* Bad, because many errors are discovered only at runtime.
* Bad, because tooling capabilities are reduced.

### Static Typing

* Good, because many errors are detected during compilation.
* Good, because tooling quality is generally stronger.
* Bad, because beginners face a steeper learning curve.
* Bad, because additional syntax is often required.

### Gradual Typing

* Good, because it combines accessibility with scalability.
* Good, because teams can adopt stronger typing incrementally.
* Good, because it supports both educational and professional use cases.
* Bad, because implementation complexity increases.

## More Information

This decision directly supports Jua's educational-first philosophy while preserving its suitability for professional software development.
