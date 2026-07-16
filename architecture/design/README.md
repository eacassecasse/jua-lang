# Design Documentation Framework

## Purpose

The design documentation defines how the Jua language specification is realized within the compiler, runtime, standard library, and toolchain.

Where the language specification defines observable language behaviour, and Architectural Decision Records (ADRs) capture significant architectural decisions, design documentation specifies the internal structures, responsibilities, invariants, and interactions that implement those decisions.

Design documents are implementation-oriented architectural artefacts. They are intended for contributors working on the Jua ecosystem rather than end users of the language.

---

# Relationship with Other Architectural Artefacts

The Jua architecture repository is composed of complementary documentation layers.

## Language Specification

The language specification defines the externally observable behaviour of the language.

It answers questions such as:

* Which language constructs exist?
* What is the syntax of a construct?
* What are its semantic rules?
* What behaviour is visible to users?

The language specification is the primary source of truth for language behaviour.

---

## Architectural Decision Records

Architectural Decision Records capture significant architectural choices.

They answer questions such as:

* Why was this architecture selected?
* Which alternatives were evaluated?
* Which consequences does the decision introduce?

Architectural decisions are immutable historical records and are not intended to describe implementation details.

---

## Design Documentation

Design documentation specifies how architectural decisions are realized.

Typical subjects include:

* Abstract syntax tree organisation
* Visitor architecture
* Source position propagation
* Diagnostic model
* Symbol table architecture
* Intermediate representations
* Runtime object model
* Module resolution
* Compiler pipelines

Design documents intentionally avoid redefining language semantics already specified elsewhere.

---

## Implementation Matrix

The implementation matrix records implementation progress for each language feature across compiler layers.

It does not describe design.

Instead, it references:

* Language Specification
* Design Documentation
* Compiler implementation

---

## Request for Comments

RFC documents describe proposed changes that have not yet been accepted.

Once accepted:

* language changes migrate into the specification;
* architectural decisions migrate into ADRs;
* implementation details migrate into design documentation.

---

# Documentation Principles

Every design document shall satisfy the following principles.

## Specification Driven

A design document shall never redefine language behaviour.

Observable language behaviour belongs exclusively to the language specification.

Every design document shall reference the specification sections it implements.

---

## Architecture Focused

Design documentation describes architecture rather than implementation mechanics.

Documents should explain:

* responsibilities;
* boundaries;
* interactions;
* invariants;
* extension points.

Individual algorithms, helper methods, utility classes, and implementation details belong in source code.

---

## Technology Neutral

Whenever practical, documents should describe architectural concepts rather than implementation technologies.

For example:

Instead of describing Java classes directly, documents should describe compiler components and their responsibilities.

Implementation languages may change in the future without invalidating architectural documentation.

---

## Single Responsibility

Each design document shall describe exactly one architectural concern.

Examples include:

* Abstract Syntax Tree
* Visitor Framework
* Diagnostic Model
* Source Position Model

A document should not attempt to describe multiple unrelated subsystems.

---

## Stable Vocabulary

Design documentation shall use terminology defined by the language specification whenever possible.

New terminology should only be introduced when necessary to describe internal compiler architecture.

---

# Standard Document Structure

Every design document should follow a common structure.

## Metadata

Each document begins with:

* Title
* Status
* Related Specifications
* Related ADRs
* Related Design Documents

---

## Purpose

Describes the architectural problem solved by the design.

---

## Scope

Defines what is included and explicitly excluded.

---

## Design Goals

Lists the primary objectives that influenced the design.

Examples include:

* correctness
* determinism
* extensibility
* separation of concerns
* performance
* maintainability

---

## Architecture

Describes the overall architecture of the subsystem.

This section introduces the principal components and their relationships.

---

## Responsibilities

Defines the responsibilities assigned to each architectural component.

Responsibilities should be complete and non-overlapping.

---

## Invariants

Lists conditions that must always hold.

Invariants are considered part of the architectural contract.

Examples include:

* AST nodes are immutable after construction.
* Every AST node owns a valid source span.
* Visitors never mutate the syntax tree.

---

## Extension Points

Documents the intended mechanisms for future evolution without breaking existing architecture.

---

## Future Evolution

Records anticipated improvements that are intentionally deferred.

Future evolution sections must not contradict accepted ADRs.

---

# Document Lifecycle

Design documents evolve alongside the implementation.

Unlike ADRs, they are living documents.

Updates are expected whenever:

* architecture changes;
* responsibilities change;
* invariants change;
* compiler phases evolve.

Pure implementation refactoring that preserves architectural behaviour does not require documentation changes.

---

# Relationship with Source Code

Design documentation should explain the architecture.

Source code should implement it.

Neither should duplicate the other.

Examples and diagrams should remain conceptual rather than mirroring individual classes or packages.

---

# Review Criteria

Before accepting a design document, reviewers should verify that it:

* references the appropriate specification sections;
* references relevant ADRs;
* defines a single architectural concern;
* documents responsibilities clearly;
* identifies architectural invariants;
* avoids language semantics already defined elsewhere;
* remains independent of incidental implementation details.

---

# Evolution Policy

Design documentation forms part of the architectural contract of the Jua ecosystem.

Whenever implementation diverges from accepted design documentation, one of two actions shall occur:

1. The implementation shall be updated to restore architectural consistency.

or

2. The design document shall be revised following architectural review.

Architectural documentation shall never intentionally drift from the implementation it describes.

