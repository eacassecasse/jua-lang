# Abstract Syntax Tree

---

Status: Accepted

Related Specifications:

* specs/frontend/parser-ast-contract.md
* specs/semantics/ast-model.md
* specs/grammar/grammar.md

Related Architectural Decisions:

* ADR-0007 — Language Specification as Source of Truth
* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture

Related Design Documents:

* Frontend Architecture Overview

---

# Purpose

The Abstract Syntax Tree (AST) is the canonical structural representation of a Jua program produced by syntactic analysis.

Its purpose is to preserve the semantic structure of a program while eliminating syntactic details that are not required by subsequent compilation phases.

The AST forms the architectural boundary between the frontend and semantic analysis.

Every compiler phase following parsing shall consume the AST rather than the original source code or token stream.

---

# Scope

This document specifies:

* the architectural role of the AST;
* structural organisation;
* ownership rules;
* invariants;
* extension principles.

This document does not specify:

* parser implementation;
* visitor implementations;
* semantic analysis;
* intermediate representations;
* optimisation.

---

# Design Goals

The AST architecture is designed to satisfy the following objectives.

## Structural Fidelity

The tree shall preserve every language construct required for semantic interpretation.

No semantic information shall be inferred from omitted syntax.

---

## Minimal Representation

The AST shall discard lexical information that has no architectural value after parsing.

Examples include:

* whitespace;
* comments;
* delimiter tokens;
* grouping tokens whose purpose is exclusively syntactic.

Only information required by later compiler phases shall remain.

---

## Immutability

AST nodes shall be immutable after construction.

Compiler phases shall analyse or transform syntax by producing new structures rather than mutating existing ones.

Immutability guarantees deterministic compiler behaviour and simplifies reasoning about compiler correctness.

---

## Phase Independence

The AST shall remain independent from every compilation phase that consumes it.

In particular, AST nodes shall contain no semantic information, symbol bindings, inferred types, optimisation metadata, or runtime state.

---

## Extensibility

The architecture shall permit the introduction of new language constructs without requiring modification of existing node contracts.

Language evolution should primarily introduce new node types rather than altering established ones.

---

# Architectural Role

Within the compiler pipeline, the AST occupies the boundary between parsing and semantic analysis.

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
Semantic Analysis
```

The parser is responsible for constructing the AST.

The semantic analyser becomes the first consumer of the completed tree.

---

# Tree Structure

The AST is a rooted hierarchical structure.

Every successfully parsed compilation unit owns exactly one root node.

The root represents the compilation unit rather than an individual language construct.

All subsequent nodes are reachable from this root.

The tree shall never contain disconnected subtrees.

---

# Node Categories

The architecture organises nodes according to language responsibilities rather than implementation concerns.

The principal categories include:

* declarations;
* statements;
* expressions;
* literals;
* identifiers.

Additional categories may be introduced as the language evolves.

Categories exist to express architectural intent and shall not be interpreted as implementation inheritance hierarchies.

---

# Ownership Model

Every node owns its children exclusively.

A child node shall never belong to multiple parents simultaneously.

Consequently, the AST forms a tree rather than a general graph.

Node ownership guarantees deterministic traversal order and simplifies later compiler phases.

---

# Source Information

Every node owns a valid source span.

Source ownership is mandatory.

No AST node shall exist without source location information.

Source spans enable:

* compiler diagnostics;
* semantic diagnostics;
* tooling integration;
* source mapping;
* future transformations.

Source information is considered an architectural invariant rather than optional metadata.

---

# Node Identity

Nodes represent program structure rather than object identity.

Two structurally equivalent nodes should be considered semantically equivalent regardless of their allocation identity.

Compiler phases shall not rely upon object identity to determine language semantics.

---

# Parent Relationships

Nodes own their children.

Children do not own their parents.

The architecture intentionally omits parent references.

Tree traversal is expected to proceed from the root downward.

Compiler phases requiring ancestry information should manage traversal state explicitly rather than introducing bidirectional relationships.

---

# Traversal

Traversal mechanisms are intentionally separated from the tree itself.

The AST defines structure.

Traversal strategies are delegated to dedicated architectural components.

This separation preserves the single responsibility of the AST.

---

# Architectural Invariants

The following invariants shall always hold.

## Single Root

Every compilation unit owns exactly one root node.

---

## Complete Reachability

Every node shall be reachable from the root.

Unreachable nodes are considered invalid.

---

## Exclusive Ownership

Every node has at most one parent.

---

## Structural Validity

Every node satisfies the grammar rules from which it was constructed.

The AST shall never represent syntactically invalid programs.

---

## Source Ownership

Every node owns a valid source span.

---

## Immutability

Node state shall not change after construction.

---

## Phase Neutrality

AST nodes shall contain no semantic, optimisation, runtime, or backend information.

---

# Extension Strategy

New language constructs extend the architecture by introducing new node categories or specialised node types.

Existing architectural contracts shall remain stable.

Language evolution should minimise changes to existing node responsibilities.

---

# Relationship with Semantic Analysis

Semantic analysis consumes the AST without modifying its structure.

Symbol resolution, type information, and semantic metadata are external to the AST.

The semantic model enriches interpretation while preserving the structural representation produced by parsing.

---

# Relationship with Intermediate Representations

Intermediate representations are derived from the AST.

They are not extensions of the AST.

The AST remains the authoritative structural representation of the parsed program.

Every lowering stage shall preserve observable language behaviour while producing progressively implementation-oriented representations.

---

# Future Evolution

The architecture anticipates future language evolution including:

* functions;
* modules;
* traits;
* interfaces;
* objects;
* generics;
* pattern matching.

These additions should integrate through architectural extension rather than modification of existing contracts.

