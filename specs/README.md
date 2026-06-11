# Jua Language Specification

Version: 0.1 Draft

Status: Active Development

---

# Purpose

The Jua Language Specification defines the behavior, syntax, semantics, and evolution rules of the Jua programming language.

This specification serves as the authoritative source of truth for the language.

All implementations of Jua, including compilers, interpreters, tooling, runtimes, and educational materials, must conform to this specification.

---

# Scope

The specification defines:

* Lexical structure
* Syntax rules
* Semantic behavior
* Type system
* Standard library contracts
* Module system behavior
* Language evolution policies

The specification does not define:

* Internal compiler architecture
* Runtime implementation details
* Toolchain implementation choices
* Build system implementation

Implementations are free to choose their internal architecture provided that externally observable behavior remains compliant with the specification.

---

# Authority Hierarchy

The Jua project follows the following authority order:

1. Language Specification
2. Accepted ADRs
3. Accepted RFCs
4. Compiler Implementations
5. Tooling Implementations

In case of conflict:

The higher authority prevails.

Example:

If the compiler behavior differs from the specification, the specification is considered correct and the implementation must be updated.

---

# Design Principles

The language is guided by the following principles.

## Readability First

Code should be easier to understand than to write.

Readability takes precedence over cleverness.

---

## Explicit Over Magical

Language behavior should be visible and predictable.

Features that hide execution behavior should be avoided.

---

## Progressive Complexity

Beginners should be productive immediately.

Advanced capabilities should become available incrementally.

---

## Educational Accessibility

The language should remain approachable to students and self-learners.

Educational value is considered a first-class design concern.

---

## Enterprise Sustainability

The language must remain maintainable for long-term professional software development.

---

# Compatibility Policy

Jua follows a compatibility-first evolution strategy.

Breaking changes should be avoided whenever possible.

When breaking changes become necessary:

* The change must be proposed through an RFC.
* The change must be reviewed.
* The change must be documented.
* Migration guidance must be provided.

---

# Specification Structure

The specification is organized into the following sections:

* Grammar
* Semantics
* Type System
* Standard Library
* Modules
* Versioning

---

# Conformance

A Jua implementation is considered conformant when it:

* Correctly parses valid Jua source code.
* Correctly rejects invalid Jua source code.
* Produces behavior consistent with the specification.
* Passes the official conformance test suite.

---

# Versioning

The language follows semantic versioning principles.

Major versions may introduce breaking changes.

Minor versions introduce new capabilities while preserving compatibility.

Patch versions clarify behavior and resolve defects.

---

# Future Evolution

Language evolution occurs through:

* ADRs (Architectural Decisions)
* RFCs (Language Change Proposals)
* Specification Updates

All significant language changes must be documented before implementation.

