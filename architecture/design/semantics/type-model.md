# Type Model

---

Status: Accepted

Related Specifications

* specs/type-system/type-system-overview.md
* specs/type-system/primitive-types.md
* specs/semantics/type-checking.md

Related Architectural Decisions

* ADR-0005 — Gradual Typing

Related Design Documents

* Semantic Architecture
* Semantic Model
* Symbol Model
* Semantic Binding Model

---

# Purpose

The Type Model defines the architectural representation of semantic classification.

Types describe the semantic properties of program entities and expressions.

Where symbols establish identity, types establish classification.

Type information enables the compiler to reason about program correctness independently of program execution.

---

# Scope

This document specifies:

* semantic types;
* type identity;
* type ownership;
* type relationships;
* architectural invariants.

This document does not specify:

* primitive types;
* object types;
* interfaces;
* traits;
* type inference algorithms;
* type checking rules.

Those concerns are defined by specialised specifications.

---

# Design Goals

The Type Model satisfies the following objectives.

## Semantic Classification

Types classify semantic entities.

They never establish identity.

---

## Independence

Type information remains independent from syntax.

A type exists independently from the declaration that introduced it.

---

## Reusability

Multiple semantic entities may share the same type.

---

## Stability

Equivalent programs shall produce equivalent semantic classifications.

---

## Extensibility

Future language features shall extend the type system without altering the architectural contracts established by this model.

---

# Architectural Role

Types classify semantic entities.

```text
Binding

↓

Symbol

↓

Type
```

The type system reasons about symbols rather than syntax.

---

# Type Identity

Every type possesses a semantic identity independent from:

* declarations;
* references;
* source locations;
* syntax nodes.

A type represents one semantic classification.

---

# Type Ownership

Types belong to the semantic subsystem.

Neither syntax nodes nor symbols own types.

Symbols reference types.

Types remain independent semantic entities.

---

# Type Categories

The architecture recognises multiple categories of types.

Examples include:

* primitive types;
* object types;
* interface types;
* trait types;
* function types;
* collection types.

Additional categories may be introduced through future language evolution.

---

# Declared Types

A declared type originates directly from source code.

Semantic analysis verifies that the declared classification is valid.

Declared types participate in semantic reasoning without altering their identity.

---

# Inferred Types

An inferred type is established through semantic analysis rather than explicit syntax.

Once established, inferred and declared types become architecturally indistinguishable.

Subsequent compiler phases operate on semantic types rather than on their origin.

---

# Type Relationships

Types participate in semantic relationships including:

* assignability;
* compatibility;
* equivalence;
* implementation;
* conformance.

The existence of these relationships does not imply inheritance or subtyping.

Their semantics are defined by the language specification.

---

# Architectural Boundaries

## Symbol Model

Symbols possess identity.

Symbols reference types.

---

## Binding Model

Bindings identify semantic entities.

Bindings do not determine type.

---

## Type Model

Defines semantic classification.

Owns no syntax.

---

## Type Checking

Consumes the Type Model to verify semantic correctness.

It does not define types.

---

# Architectural Invariants

The following invariants shall always hold.

## Stable Identity

A type possesses one semantic identity throughout compilation.

---

## Symbol Independence

Types classify symbols.

They never own symbols.

---

## Syntax Independence

Types never become embedded within syntax nodes.

---

## Origin Independence

Compiler phases shall not distinguish between declared and inferred types after semantic analysis establishes classification.

---

## Deterministic Classification

Equivalent programs shall produce equivalent semantic types.

---

# Extension Strategy

Future language evolution may introduce additional type categories including:

* generic types;
* union types;
* intersection types;
* nullable types;
* compile-time types;
* dependent types.

These extensions shall preserve the architectural principles established by this model.

---

# Relationship with Type Checking

Type checking verifies the correctness of relationships between semantic types.

It consumes the Type Model.

It does not construct the architecture of the type system.

---

# Relationship with Symbols

Symbols represent semantic entities.

Types classify those entities.

Identity and classification remain intentionally independent architectural concepts.

---

# Relationship with Future Compiler Phases

Intermediate Representation generation, optimisation, and backend compilation consume semantic classifications established by the Type Model.

Subsequent phases shall not reinterpret type identity.

---

# Future Evolution

The Type Model anticipates future support for:

* gradual typing;
* generic specialisation;
* compile-time evaluation;
* trait composition;
* interface conformance;
* advanced type inference.

These capabilities shall extend the Type Model while preserving its architectural contracts.

