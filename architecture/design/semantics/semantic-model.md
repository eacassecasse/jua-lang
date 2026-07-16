# Semantic Model

---

Status: Accepted

Related Specifications

* specs/semantics/semantic-analysis.md
* specs/semantics/scope-resolution.md
* specs/semantics/type-checking.md

Related Architectural Decisions

* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture

Related Design Documents

* Semantic Architecture
* Abstract Syntax Tree
* Visitor Framework

---

# Purpose

The Semantic Model defines the architectural representation of program meaning.

While the Abstract Syntax Tree represents the syntactic structure of a program, the Semantic Model represents the information derived from analysing that structure according to the language rules.

Semantic information exists independently of syntax.

It is progressively established during semantic analysis and consumed by subsequent compiler phases.

---

# Scope

This document specifies:

* semantic information;
* semantic ownership;
* semantic identity;
* semantic relationships;
* architectural invariants.

This document does not specify:

* symbol tables;
* scope resolution;
* type systems;
* semantic algorithms.

These concerns are defined by specialised semantic models.

---

# Design Goals

The Semantic Model satisfies the following objectives.

## Separation from Syntax

Semantic information shall remain independent from syntax.

The Abstract Syntax Tree describes program structure.

The Semantic Model describes program meaning.

---

## Progressive Construction

Semantic information is established incrementally.

Each semantic pass contributes additional information while preserving previously established knowledge.

---

## Explicit Representation

Semantic knowledge shall be represented explicitly rather than inferred repeatedly from syntax.

---

## Determinism

Equivalent syntax trees shall produce equivalent semantic models.

---

## Extensibility

Future language features should extend the semantic model without altering established architectural contracts.

---

# Architectural Role

The Semantic Model forms the semantic representation shared by compiler phases.

```text
Abstract Syntax Tree
         │
         ▼
Semantic Analysis
         │
         ▼
Semantic Model
         │
         ▼
Later Compiler Phases
```

The Semantic Model bridges syntax and compilation.

---

# Semantic Information

Semantic information represents knowledge that cannot be determined through syntax alone.

Examples include:

* declaration ownership;
* symbol identity;
* lexical visibility;
* inferred types;
* constant values;
* semantic constraints.

The Semantic Model intentionally abstracts these concepts rather than prescribing specific implementations.

---

# Ownership

Semantic information belongs to the semantic subsystem.

The Abstract Syntax Tree never owns semantic state.

Semantic objects may reference syntax nodes.

Syntax nodes shall never own semantic objects.

This preserves the independence of both models.

---

# Identity

Semantic entities possess identities independent from syntax.

Multiple syntax nodes may reference the same semantic entity.

Conversely, one semantic entity may correspond to multiple syntactic references.

Identity is therefore established by semantic analysis rather than syntax.

---

# Relationships

Semantic information forms relationships that are absent from the syntax tree.

Typical relationships include:

* declaration ↔ reference;
* scope ↔ declaration;
* expression ↔ type;
* module ↔ exported declaration.

These relationships collectively define the semantic structure of a program.

---

# Semantic Evolution

Semantic information is accumulated progressively.

Each compiler pass extends the existing semantic model without redefining previously established relationships.

Example progression:

```text
Syntax Tree

↓

Declarations

↓

Symbols

↓

Scopes

↓

Types

↓

Validated Program
```

Each stage enriches the semantic model.

No stage replaces it.

---

# Architectural Boundaries

## Abstract Syntax Tree

Defines syntax.

Owns no semantic information.

---

## Semantic Model

Defines meaning.

Owns no syntax.

---

## Intermediate Representation

Consumes semantic information.

Does not establish semantic correctness.

---

# Architectural Invariants

The following invariants shall always hold.

## Syntax Independence

Semantic information shall never become embedded within syntax nodes.

---

## Explicit Ownership

Every semantic entity shall have a well-defined owner.

Ownership relationships shall never be ambiguous.

---

## Stable Identity

Semantic identity shall remain stable throughout semantic analysis.

Subsequent compiler phases shall observe consistent semantic entities.

---

## Progressive Enrichment

Semantic analysis extends semantic information.

Previously established semantic knowledge shall remain valid unless explicitly invalidated by compilation failure.

---

## Deterministic Construction

Equivalent programs shall produce equivalent semantic models.

---

# Extension Strategy

Language evolution extends the semantic model by introducing additional semantic entities rather than modifying existing semantic contracts.

Examples include:

* generic parameters;
* trait implementations;
* interface conformance;
* compile-time evaluation metadata.

The semantic architecture should remain stable as these capabilities evolve.

---

# Relationship with Symbol Model

The Symbol Model defines one category of semantic entity.

Symbols therefore represent a specialised component of the Semantic Model rather than the semantic model itself.

---

# Relationship with Scope Model

Scopes organise semantic visibility.

They define where semantic entities are accessible without defining the entities themselves.

---

# Relationship with Type Model

Types describe semantic classification.

They enrich existing semantic entities without altering their identities.

---

# Future Evolution

The Semantic Model anticipates future extensions including:

* compile-time evaluation;
* generic instantiation;
* module dependency graphs;
* trait resolution;
* interface conformance;
* optimisation metadata.

These capabilities should extend the semantic model while preserving the architectural principles established by this document.

