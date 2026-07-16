# Semantic Architecture

---

Status: Accepted

Related Specifications

* specs/semantics/semantic-analysis.md
* specs/semantics/compiler-phases.md
* specs/semantics/type-checking.md
* specs/semantics/scope-resolution.md

Related Architectural Decisions

* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture

Related Design Documents

* Frontend Architecture Overview
* Parser Architecture
* Abstract Syntax Tree
* Visitor Framework

---

# Purpose

The Semantic Architecture defines the subsystem responsible for assigning meaning to syntactically correct programs.

Where the frontend establishes program structure, semantic analysis establishes program correctness according to the language rules.

Semantic analysis consumes immutable syntax trees and produces validated semantic information for subsequent compiler phases.

---

# Scope

This document specifies:

* semantic subsystem responsibilities;
* subsystem boundaries;
* subsystem interactions;
* architectural invariants;
* extension strategy.

This document does not specify:

* symbol tables;
* type systems;
* scope rules;
* individual semantic passes.

These concerns are defined by specialised semantic design documents.

---

# Design Goals

The semantic subsystem satisfies the following objectives.

## Language Correctness

Semantic analysis verifies that programs conform to the static semantics of the language.

---

## Structural Independence

Semantic analysis shall never modify the Abstract Syntax Tree.

Program structure is established during parsing.

Semantic analysis interprets that structure.

---

## Phase Isolation

Semantic analysis remains independent from:

* parsing;
* optimisation;
* code generation.

Each subsystem owns distinct responsibilities.

---

## Determinism

Equivalent syntax trees shall always produce equivalent semantic information and diagnostics.

---

## Extensibility

Language evolution should introduce additional semantic rules without requiring architectural redesign.

---

# Architectural Role

The semantic subsystem occupies the second major stage of compilation.

```text
Source File
      │
      ▼
Frontend
      │
      ▼
Abstract Syntax Tree
      │
      ▼
Semantic Analysis
      │
      ▼
Validated Program Model
      │
      ▼
Intermediate Representation
```

Semantic analysis neither parses nor executes programs.

It establishes their static meaning.

---

# Responsibilities

The semantic subsystem is responsible for:

* symbol resolution;
* scope management;
* visibility checking;
* type checking;
* declaration validation;
* semantic diagnostics;
* semantic invariants.

The subsystem shall not perform optimisation or code generation.

---

# Inputs

Semantic analysis consumes:

* immutable Abstract Syntax Trees;
* source ownership information;
* language specification rules.

---

# Outputs

Semantic analysis produces:

* validated semantic information;
* semantic diagnostics;
* compiler metadata required by later phases.

The subsystem does not alter syntax trees.

---

# Internal Architecture

The semantic subsystem consists of cooperating semantic passes.

Each pass owns one well-defined responsibility.

Semantic information is accumulated progressively.

Compiler phases communicate through explicit semantic models rather than shared mutable state.

---

# Architectural Boundaries

## Frontend

The frontend constructs program structure.

Semantic analysis interprets that structure.

---

## Optimisation

Optimisation assumes semantically valid programs.

Semantic analysis establishes that validity.

---

## Backend

Backend compilation consumes validated semantic information.

It performs no semantic verification.

---

# Architectural Invariants

The following invariants shall always hold.

## Immutable Syntax

Semantic analysis shall never modify the Abstract Syntax Tree.

---

## Progressive Enrichment

Semantic information is added externally rather than embedded into syntax nodes.

---

## Explicit Models

Semantic knowledge shall be represented by dedicated semantic models.

Compiler phases shall not infer semantic meaning from syntax alone.

---

## Deterministic Behaviour

Equivalent syntax trees shall always produce equivalent semantic information.

---

## Independent Passes

Each semantic pass owns one architectural responsibility.

Passes cooperate through explicit contracts rather than implicit dependencies.

---

# Extension Strategy

Language evolution extends semantic analysis by introducing additional semantic models and semantic passes.

Existing architectural contracts should remain stable.

---

# Relationship with the Visitor Framework

Semantic analysis traverses the Abstract Syntax Tree exclusively through the Visitor Framework.

Traversal behaviour remains independent from semantic behaviour.

---

# Relationship with Future Compiler Phases

Semantic analysis establishes the correctness guarantees required by:

* intermediate representation generation;
* optimisation;
* backend compilation.

Subsequent compiler phases rely upon semantic correctness rather than re-establishing it.

---

# Future Evolution

The semantic architecture anticipates future support for:

* generics;
* traits;
* interfaces;
* modules;
* pattern matching;
* compile-time evaluation.

These capabilities should extend the semantic subsystem while preserving the architectural contracts established by this document.

