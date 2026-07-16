# Semantic Pass Model

---

Status: Accepted

Related Specifications

* specs/semantics/compiler-phases.md
* specs/semantics/semantic-analysis.md

Related Architectural Decisions

* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture

Related Design Documents

* Semantic Architecture
* Semantic Model
* Symbol Model
* Scope Model
* Name Resolution Model
* Semantic Binding Model
* Type Model

---

# Purpose

The Semantic Pass Model defines the architectural organisation of semantic analysis.

Semantic analysis is modelled as a deterministic sequence of independent semantic passes.

Each pass owns one architectural responsibility and produces semantic information consumed by subsequent passes.

This model establishes the dependency graph of semantic analysis while preserving separation of concerns between compiler phases.

---

# Scope

This document specifies:

* semantic pass architecture;
* pass responsibilities;
* pass ordering;
* dependency rules;
* architectural invariants.

This document does not specify:

* implementation algorithms;
* optimisation;
* intermediate representation generation;
* runtime behaviour.

---

# Design Goals

The Semantic Pass Model satisfies the following objectives.

## Single Responsibility

Each semantic pass shall perform one architectural task.

---

## Progressive Enrichment

Semantic information is accumulated progressively.

Each pass extends the semantic model established by previous passes.

---

## Deterministic Execution

Equivalent programs shall execute equivalent semantic passes in identical order.

---

## Explicit Dependencies

Pass dependencies shall be architectural rather than implicit.

A pass shall consume only semantic information guaranteed to exist.

---

## Extensibility

Future compiler capabilities shall introduce additional passes without altering the responsibilities of existing passes.

---

# Architectural Role

Semantic passes transform syntactic structure into validated semantic information.

```text
Abstract Syntax Tree

↓

Semantic Passes

↓

Validated Semantic Model

↓

Intermediate Representation
```

Each pass contributes one layer of semantic understanding.

---

# Pass Pipeline

The semantic subsystem executes semantic passes in dependency order.

The conceptual pipeline is:

```text
Declaration Collection

↓

Symbol Construction

↓

Scope Construction

↓

Name Resolution

↓

Type Analysis

↓

Semantic Validation
```

Each stage assumes the successful completion of all preceding stages.

---

# Pass Responsibilities

## Declaration Collection

Discovers declarations present in the Abstract Syntax Tree.

Produces declaration metadata required for symbol construction.

---

## Symbol Construction

Constructs semantic symbols for every declaration.

Produces stable semantic identities.

---

## Scope Construction

Builds lexical visibility hierarchies.

Associates declarations with lexical ownership.

---

## Name Resolution

Associates references with symbols.

Produces semantic bindings.

---

## Type Analysis

Classifies semantic entities.

Produces semantic type information.

---

## Semantic Validation

Verifies semantic language rules that require complete semantic information.

Produces semantic diagnostics.

---

# Pass Dependencies

Semantic passes form a directed acyclic dependency graph.

Example:

```text
Declarations
        │
        ▼
Symbols
        │
        ▼
Scopes
        │
        ▼
Bindings
        │
        ▼
Types
        │
        ▼
Validation
```

Later passes shall never introduce semantic information required by earlier passes.

---

# Communication

Semantic passes communicate exclusively through semantic models.

No pass shall depend upon the internal implementation of another pass.

Shared information shall be represented by explicit semantic entities.

Examples include:

* symbols;
* scopes;
* bindings;
* types.

---

# Failure Model

A semantic pass may produce diagnostics.

Diagnostic production does not necessarily terminate semantic analysis.

Subsequent passes may continue provided that their architectural preconditions remain satisfied.

This enables comprehensive diagnostic reporting from a single compilation.

---

# Architectural Boundaries

## Frontend

Produces immutable Abstract Syntax Trees.

Performs no semantic analysis.

---

## Semantic Passes

Construct semantic meaning.

Produce validated semantic information.

---

## Intermediate Representation

Consumes validated semantic information.

Performs no semantic analysis.

---

# Architectural Invariants

The following invariants shall always hold.

## Immutable Syntax

Semantic passes shall never modify the Abstract Syntax Tree.

---

## Explicit Dependencies

Passes consume only semantic information produced by preceding passes.

---

## Independent Responsibilities

No two passes shall own the same architectural responsibility.

---

## Stable Semantic Information

Semantic information produced by a pass shall remain valid throughout subsequent passes.

---

## Deterministic Ordering

Semantic passes execute according to architectural dependencies rather than implementation convenience.

---

# Extension Strategy

Future language evolution may introduce additional semantic passes including:

* generic constraint validation;
* trait conformance analysis;
* interface implementation verification;
* compile-time evaluation;
* exhaustiveness analysis;
* data-flow analysis.

New passes shall integrate into the dependency graph without altering established responsibilities.

---

# Relationship with Visitor Framework

Each semantic pass traverses the Abstract Syntax Tree through the Visitor Framework.

Traversal remains independent from semantic responsibilities.

Different semantic passes may employ specialised visitor implementations while preserving the common traversal contract.

---

# Relationship with Future Compiler Phases

Successful completion of the semantic pass pipeline establishes the semantic guarantees required by:

* intermediate representation generation;
* optimisation;
* backend compilation.

Subsequent compiler phases shall consume semantic information rather than reconstruct it.

---

# Future Evolution

The Semantic Pass Model anticipates future support for:

* incremental semantic analysis;
* parallel semantic passes;
* cached semantic information;
* interactive compilation;
* language server integration.

These capabilities shall preserve the architectural principles established by this document.

