# Syntax Tree Rendering

---

Status: Accepted

Related Specifications

* specs/testing/testing.md
* specs/frontend/parser-ast-contract.md
* specs/diagnostics/diagnostics-philosophy.md

Related Architectural Decisions

* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture
* ADR-0011 — Education as First-Class Concern

Related Design Documents

* Frontend Architecture Overview
* Parser Architecture
* Abstract Syntax Tree
* Visitor Framework

---

# Purpose

Syntax tree rendering defines the architectural mechanism through which Abstract Syntax Trees are transformed into deterministic textual representations.

Rendering exists to verify compiler correctness, support parser validation, facilitate architectural inspection, and provide stable artefacts for automated testing.

Syntax tree rendering is not part of the compilation pipeline.

It is a validation subsystem built upon the frontend architecture.

---

# Scope

This document specifies:

* rendering architecture;
* rendering responsibilities;
* renderer independence;
* validation strategy;
* snapshot stability;
* architectural invariants.

This document does not specify:

* parser implementation;
* compiler diagnostics;
* semantic analysis;
* optimisation;
* code generation.

---

# Design Goals

The rendering architecture satisfies the following objectives.

## Determinism

Equivalent syntax trees shall always produce identical textual representations.

Rendering shall never depend upon:

* operating system;
* execution environment;
* object identity;
* traversal implementation.

---

## Structural Fidelity

Rendered output shall accurately reflect the structure of the Abstract Syntax Tree.

Rendering shall neither omit nor invent structural information.

---

## Architectural Independence

Rendering shall remain independent of compiler phases.

The renderer shall operate solely upon tree structure.

Semantic interpretation shall not influence rendering.

---

## Snapshot Stability

Rendering output constitutes repository artefacts.

Formatting shall remain stable across compiler versions unless an intentional architectural change occurs.

Changes to rendering format should be treated as architectural changes rather than implementation details.

---

## Educational Clarity

Rendered syntax trees should communicate program structure clearly without exposing implementation-specific details.

The representation should emphasise language constructs rather than compiler internals.

---

# Architectural Role

Rendering occupies the validation layer of the frontend.

```text
Source File
      │
      ▼
Lexer
      │
      ▼
Parser
      │
      ▼
Abstract Syntax Tree
      │
      ▼
Syntax Tree Rendering
      │
      ▼
Snapshot Validation
```

Rendering consumes completed syntax trees.

It never participates in compilation.

---

# Architectural Components

The rendering subsystem is composed of two independent responsibilities.

## Syntax Tree Printer

Responsible for translating syntax nodes into an abstract rendering description.

The printer understands language constructs.

It does not understand visual formatting.

---

## Tree Renderer

Responsible for producing the textual tree representation.

The renderer understands tree structure only.

It possesses no knowledge of:

* language constructs;
* compiler phases;
* semantic information.

This separation preserves architectural independence between structural representation and presentation.

---

# Separation of Responsibilities

The architecture intentionally separates:

language structure

from

tree presentation.

The syntax tree printer determines:

* which nodes appear;
* traversal order;
* structural relationships.

The renderer determines:

* indentation;
* branch formatting;
* layout;
* presentation consistency.

Neither component assumes the responsibilities of the other.

---

# Rendering Model

Rendering proceeds as a deterministic traversal of the completed Abstract Syntax Tree.

Traversal order follows structural ownership established during parsing.

Rendering shall preserve:

* hierarchy;
* ownership;
* declaration order;
* expression order.

Presentation shall never alter structural meaning.

---

# Snapshot Validation

Rendered trees serve as canonical validation artefacts.

Parser correctness is verified by comparing rendered output against accepted snapshots.

Snapshot validation verifies:

* grammar recognition;
* syntax tree construction;
* traversal behaviour;
* rendering stability.

Snapshots intentionally validate observable frontend behaviour rather than implementation details.

---

# Snapshot Stability

Snapshot artefacts are considered part of the compiler validation contract.

Rendering grammar shall remain stable.

Changes to formatting should occur only when architectural improvements require observable structural changes.

Platform-specific formatting differences are prohibited.

Repository artefacts shall remain byte-for-byte reproducible.

---

# Architectural Invariants

The following invariants shall always hold.

## Deterministic Output

Equivalent syntax trees shall always render identically.

---

## Complete Traversal

Every reachable syntax node shall appear exactly once.

---

## Structural Preservation

Rendering shall preserve the ownership hierarchy established by the parser.

---

## Presentation Independence

Rendering decisions shall never modify syntax tree structure.

---

## Semantic Neutrality

Rendering shall never perform semantic interpretation.

---

## Renderer Independence

The rendering engine shall remain independent from:

* Abstract Syntax Tree implementation;
* parser implementation;
* semantic analysis;
* intermediate representations.

The renderer is a generic hierarchical rendering engine.

---

# Extension Strategy

Introducing new language constructs requires extending syntax tree printing.

The rendering engine itself should remain unchanged.

This architecture minimises coupling between language evolution and presentation infrastructure.

---

# Relationship with Testing

Syntax tree rendering forms the foundation of frontend snapshot testing.

Snapshot validation verifies compiler behaviour at the architectural level rather than through implementation-specific assertions.

Rendering therefore constitutes part of the compiler verification strategy rather than a debugging facility.

---

# Relationship with Diagnostics

Rendering and diagnostics are complementary validation mechanisms.

Rendering verifies structural correctness.

Diagnostics communicate user-visible failures.

Neither subsystem replaces the other.

---

# Future Evolution

The rendering architecture anticipates future support for:

* semantic trees;
* symbol tables;
* control-flow graphs;
* intermediate representations;
* optimisation trees.

These structures should reuse the rendering engine while providing specialised printers appropriate to their respective architectural domains.

