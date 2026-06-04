# ADR-0003 — Zero-Based Indexing

---

status: accepted
date: 2026-06-02
decision-makers:

* Edmilson Cassecasse

---

# Adopt Zero-Based Indexing

## Context and Problem Statement

Jua collections require a consistent indexing model. The indexing strategy must support educational clarity while remaining compatible with modern programming language conventions.

The question addressed by this decision is:

> Should collections use zero-based or one-based indexing?

## Decision Drivers

* Industry familiarity
* Compatibility with existing ecosystems
* Alignment with computer science concepts
* Ease of interoperability

## Considered Options

* Zero-based indexing
* One-based indexing

## Decision Outcome

Chosen option: "Zero-based indexing", because it aligns with modern programming languages and underlying memory models.

### Consequences

* Good, because interoperability with other ecosystems becomes easier.
* Good, because educational material remains aligned with computer science fundamentals.
* Bad, because some beginners may initially expect counting to start at one.

### Confirmation

All collection types, standard library APIs, examples, and language specifications must consistently use zero-based indexing.

## Pros and Cons of the Options

### Zero-based indexing

* Good, because it matches modern language conventions.
* Good, because it aligns with memory offsets.
* Good, because it improves interoperability.

### One-based indexing

* Good, because it may feel more intuitive to some beginners.
* Bad, because it differs from most modern languages.
* Bad, because interoperability becomes more confusing.

## More Information

This decision applies to all collection types and future standard library implementations.

