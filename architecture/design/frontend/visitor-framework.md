# Visitor Framework

---

Status: Accepted

Related Specifications

* specs/frontend/parser-ast-contract.md
* specs/semantics/compiler-phases.md

Related Architectural Decisions

* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture

Related Design Documents

* Frontend Architecture Overview
* Abstract Syntax Tree
* Source Model

---

# Purpose

The Visitor Framework defines the architectural mechanism through which compiler phases traverse and operate on the Abstract Syntax Tree.

Rather than embedding compiler behaviour inside syntax nodes, the architecture externalises compiler operations into independent traversal components.

The framework establishes a stable traversal contract that allows compiler phases to evolve independently while preserving the structural integrity of the Abstract Syntax Tree.

---

# Scope

This document specifies:

* traversal architecture;
* visitor responsibilities;
* traversal context;
* extension strategy;
* architectural invariants.

This document does not specify:

* semantic analysis;
* optimisation;
* intermediate representation generation;
* code generation.

These compiler phases define specialised visitors that conform to the framework established here.

---

# Design Goals

The Visitor Framework satisfies the following objectives.

## Separation of Concerns

The Abstract Syntax Tree defines program structure.

Visitors define compiler behaviour.

Neither shall assume the responsibilities of the other.

---

## Explicit State Propagation

Traversal state shall be propagated explicitly through visitor context rather than hidden inside mutable visitor state whenever practical.

Compiler behaviour should remain observable through method contracts rather than implementation details.

---

## Extensibility

New compiler phases should be introduced by implementing additional visitors rather than modifying syntax nodes.

---

## Determinism

Equivalent syntax trees shall always produce equivalent traversal behaviour.

Traversal order shall never depend upon implementation-specific behaviour.

---

## Phase Isolation

Each compiler phase shall implement its own visitor.

Visitors remain independent despite operating on the same syntax tree.

---

## Technology Independence

The Visitor Framework defines traversal architecture rather than programming-language mechanisms.

The architectural model remains independent from implementation language, parser generators, or runtime.

---

# Architectural Role

The Visitor Framework forms the interaction layer between compiler phases and the Abstract Syntax Tree.

```text
Abstract Syntax Tree
         │
         ▼
Visitor Framework
         │
         ▼
Compiler Phase
```

The Abstract Syntax Tree exposes traversal.

Compiler phases provide behaviour.

---

# Architectural Model

The framework consists of three architectural concepts.

* immutable syntax nodes;
* visitors;
* traversal context.

Syntax nodes expose structural traversal.

Visitors provide compiler behaviour.

Traversal context propagates compiler state throughout tree traversal.

---

# Traversal Context

Traversal context represents compiler state associated with one traversal.

Examples include:

* scope information;
* symbol tables;
* type environments;
* constant evaluation environments;
* control-flow state;
* rendering state.

Context belongs to the traversal rather than to the syntax tree.

The framework intentionally externalises traversal state.

---

# Visitor Contract

Every visitor defines two independent dimensions.

## Result

The result represents the value produced by visiting a syntax node.

Examples include:

* inferred types;
* generated intermediate representations;
* constant values;
* diagnostics;
* rendering output.

Visitors that produce no observable result should explicitly define an empty result rather than relying upon hidden mutable state.

---

## Context

The context represents traversal state supplied by the invoking compiler phase.

Context propagates information throughout traversal while preserving visitor independence.

Traversal context shall never become part of the Abstract Syntax Tree.

---

# Traversal

Traversal proceeds from the compilation unit toward progressively smaller language constructs.

Traversal order follows structural ownership established by parsing.

Visitors determine compiler behaviour.

Syntax nodes determine structural relationships.

---

# Responsibilities

## Abstract Syntax Tree

Responsible for exposing structural traversal.

The Abstract Syntax Tree shall never implement compiler behaviour.

---

## Visitors

Responsible for implementing compiler behaviour.

Visitors analyse, validate, transform, or render syntax trees.

---

## Traversal Context

Responsible for propagating traversal state.

Context shall remain external to both visitors and syntax nodes.

---

## Compiler Phases

Responsible for selecting appropriate visitors and supplying traversal context.

Compiler phases shall not bypass the Visitor Framework.

---

# Method Dispatch

The Visitor Framework defines a single traversal operation.

Traversal methods are overloaded according to the concrete syntax node being visited.

The operation remains conceptually identical regardless of node category.

This architectural model expresses that visiting is one operation applied to different structural elements rather than multiple unrelated operations.

The dispatch mechanism is determined by the language implementation and is outside the scope of this document.

---

# Architectural Invariants

The following invariants shall always hold.

## Structural Purity

Syntax nodes shall contain no compiler behaviour.

---

## Behaviour Externalisation

Compiler behaviour shall exist exclusively within visitors.

---

## Explicit Context

Traversal state shall be propagated explicitly through traversal context.

Visitors should minimise hidden mutable state.

---

## Visitor Independence

Visitors shall remain independent from one another.

Compiler phases coordinate visitors rather than visitors coordinating themselves.

---

## Immutable Traversal

Visitors shall not violate Abstract Syntax Tree immutability.

Compiler phases requiring transformed syntax shall construct new structures.

---

## Complete Coverage

Every concrete syntax construct shall participate in the Visitor Framework.

Language evolution requires corresponding visitor support.

---

# Visitor Hierarchy

The Visitor Framework defines the traversal contract.

Concrete compiler infrastructure may introduce specialised visitor abstractions that extend this contract.

Examples include:

* recursive visitors;
* tree-walking visitors;
* rewriting visitors;
* validation visitors.

These abstractions simplify compiler implementation while preserving the architectural contract established by the framework.

---

# Extension Strategy

Compiler evolution introduces new visitors rather than modifying existing syntax nodes.

Examples include:

* semantic analysis;
* symbol resolution;
* type checking;
* constant evaluation;
* control-flow construction;
* intermediate representation lowering;
* optimisation;
* documentation generation.

The framework therefore scales with compiler capabilities while preserving architectural stability.

---

# Relationship with Semantic Analysis

Semantic analysis represents the primary consumer of the Visitor Framework.

Resolver, symbol table construction, type checking, and constant evaluation operate as specialised visitors over the immutable Abstract Syntax Tree.

Semantic information remains external to syntax nodes.

---

# Relationship with Future Compiler Phases

Intermediate representation generation, optimisation, and backend compilation continue using the same traversal architecture.

Future compiler phases extend behaviour by implementing additional visitors rather than modifying syntax structures.

---

# Future Evolution

The Visitor Framework anticipates future capabilities including:

* incremental compilation;
* parallel analysis;
* syntax rewriting;
* optimisation pipelines;
* documentation generation;
* static analysis;
* language server integration.

Future evolution should extend visitor implementations while preserving the traversal contract established by this document.

