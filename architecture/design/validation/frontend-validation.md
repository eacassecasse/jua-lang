# Frontend Validation Architecture

---

Status: Accepted

Related Specifications

* specs/testing/testing.md
* specs/frontend/parser-ast-contract.md

Related Architectural Decisions

* ADR-0008 — Layered Compiler Architecture
* ADR-0011 — Education as First-Class Concern

Related Design Documents

* Frontend Architecture Overview
* Parser Architecture
* Abstract Syntax Tree
* Syntax Tree Rendering

---

# Purpose

Frontend validation defines the architectural strategy through which the correctness of the compiler frontend is continuously verified.

Validation exists to detect regressions, verify structural correctness, and ensure that observable frontend behaviour remains stable throughout compiler evolution.

Validation is considered an architectural subsystem rather than an implementation convenience.

---

# Scope

This document specifies:

* validation philosophy;
* validation responsibilities;
* snapshot architecture;
* parser corpus organisation;
* verification pipeline;
* architectural invariants.

This document does not specify:

* individual test implementations;
* build scripts;
* continuous integration configuration.

---

# Design Goals

The frontend validation architecture satisfies the following objectives.

## Behaviour Verification

Validation shall verify observable compiler behaviour rather than implementation details.

Compiler refactoring should not invalidate validation artefacts unless observable behaviour changes.

---

## Determinism

Validation results shall be reproducible.

Equivalent compiler inputs shall always produce equivalent validation outcomes.

---

## Architectural Independence

Validation shall remain independent from parser generators, lexer generators, operating systems, and implementation technologies.

---

## Progressive Verification

Validation should detect failures as early as possible.

Frontend correctness should be established before semantic analysis, optimisation, or backend compilation are considered.

---

## Repository Stability

Validation artefacts committed to the repository constitute architectural reference outputs.

These artefacts shall evolve intentionally rather than incidentally.

---

# Architectural Role

Frontend validation operates outside the compilation pipeline.

```text
Source File
      │
      ▼
Compiler Frontend
      │
      ▼
Rendered Syntax Tree
      │
      ▼
Snapshot Comparison
      │
      ▼
Validation Result
```

Validation consumes frontend output.

It never influences compilation.

---

# Validation Layers

Frontend validation consists of multiple complementary layers.

## Parser Corpus

The parser corpus defines representative language programs.

Each program exercises one or more language constructs.

The corpus evolves together with the language specification.

---

## Snapshot Generation

Every accepted parser corpus produces one canonical rendered syntax tree.

Snapshots represent architectural reference outputs.

---

## Snapshot Comparison

Subsequent compiler executions compare generated output against accepted snapshots.

Differences indicate observable behavioural changes.

Behavioural differences require explicit architectural review.

---

## Structural Verification

Validation confirms that:

* grammar recognition remains stable;
* syntax trees remain structurally correct;
* traversal remains deterministic;
* rendering remains stable.

---

# Snapshot Architecture

Snapshots are considered repository artefacts.

Snapshots are not temporary debugging outputs.

They define observable frontend behaviour.

Every snapshot corresponds to one parser corpus input.

Snapshots shall remain deterministic across platforms.

---

# Parser Corpus

The parser corpus serves as the canonical collection of frontend validation inputs.

Each corpus entry should:

* isolate one language construct whenever practical;
* minimise unrelated syntax;
* maximise diagnostic clarity.

The corpus should evolve alongside language evolution.

---

# Validation Pipeline

Frontend validation follows a deterministic pipeline.

```text
Source Program
       │
       ▼
Lexical Analysis
       │
       ▼
Syntactic Analysis
       │
       ▼
Abstract Syntax Tree
       │
       ▼
Syntax Tree Rendering
       │
       ▼
Snapshot Comparison
```

Every stage must preserve deterministic behaviour.

---

# Architectural Responsibilities

## Parser Corpus

Defines validation inputs.

---

## Parser

Produces syntax trees.

---

## Syntax Tree Rendering

Produces canonical representations.

---

## Snapshot Repository

Stores accepted reference outputs.

---

## Validation Framework

Determines whether compiler behaviour conforms to accepted reference outputs.

---

# Architectural Invariants

The following invariants shall always hold.

## Canonical Inputs

Every snapshot originates from exactly one parser corpus program.

---

## Canonical Outputs

Equivalent syntax trees shall always produce identical snapshots.

---

## Behaviour Verification

Validation verifies compiler behaviour rather than implementation techniques.

---

## Platform Independence

Validation artefacts shall remain identical across supported execution environments.

---

## Explicit Evolution

Snapshot changes shall occur only through intentional architectural review.

---

# Extension Strategy

As the compiler evolves, validation expands by introducing additional corpus entries rather than replacing existing ones.

Each newly implemented language feature should introduce corresponding validation artefacts.

Existing validation should remain stable unless observable language behaviour changes.

---

# Relationship with Testing

Frontend validation complements traditional automated testing.

Traditional tests verify implementation behaviour.

Frontend validation verifies architectural behaviour.

Both approaches are necessary and intentionally coexist.

---

# Relationship with Future Compiler Phases

The validation strategy established for the frontend forms the foundation for subsequent compiler validation architectures.

Future validation subsystems may extend this approach to:

* semantic analysis;
* intermediate representations;
* optimisation;
* runtime execution.

Each subsystem should define validation artefacts appropriate to its architectural responsibilities while preserving the same validation philosophy.

---

# Future Evolution

The frontend validation architecture anticipates future support for:

* semantic snapshots;
* control-flow snapshots;
* intermediate representation snapshots;
* diagnostic snapshots;
* conformance suites.

These capabilities should extend the validation architecture without altering its fundamental principles.

