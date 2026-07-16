# Source Model

---

Status: Accepted

Related Specifications:

* specs/frontend/token-model.md
* specs/frontend/parser-ast-contract.md
* specs/diagnostics/compiler-diagnostics.md
* specs/diagnostics/diagnostics-philosophy.md

Related Architectural Decisions:

* ADR-0007 — Language Specification as Source of Truth
* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture

Related Design Documents:

* Frontend Architecture Overview
* Abstract Syntax Tree

---

# Purpose

The Source Model defines how source code is represented throughout the compiler frontend.

Its purpose is to establish a consistent architectural model for identifying, propagating, and referencing locations within source files.

The source model provides the foundation upon which diagnostics, syntax trees, semantic analysis, tooling, and future source transformations are built.

---

# Scope

This document specifies:

* source representation;
* source locations;
* source ownership;
* span propagation;
* architectural responsibilities;
* invariants.

This document does not specify:

* diagnostic formatting;
* parser implementation;
* lexer implementation;
* editor integration.

---

# Design Goals

The source model is designed to satisfy the following objectives.

## Precision

Every observable language construct shall be associated with an exact location in its originating source.

---

## Determinism

Identical source input shall always produce identical source locations.

Location computation shall never depend upon runtime environment or implementation-specific behaviour.

---

## Consistency

Every compiler subsystem shall interpret source locations identically.

No subsystem shall introduce alternative location models.

---

## Tool Independence

The architectural model shall remain independent of lexer generators, parser generators, editors, or development environments.

---

## Extensibility

The source model shall support future compiler capabilities including:

* semantic diagnostics;
* source transformations;
* incremental compilation;
* language server integration;
* debugging metadata.

---

# Architectural Role

The source model is shared across multiple compiler layers.

```text
Source File
      │
      ▼
Lexer
      │
      ▼
Tokens
      │
      ▼
Parser
      │
      ▼
Abstract Syntax Tree
      │
      ▼
Semantic Analysis
      │
      ▼
Diagnostics
```

Every layer consumes and propagates source information without redefining it.

---

# Source File

A source file represents the immutable textual input to the compiler.

The source file constitutes the origin of every location represented throughout compilation.

Source files are treated as immutable architectural entities.

Compiler phases shall reference source files but shall never modify them.

---

# Source Position

A source position identifies one logical location within a source file.

A position is defined independently of any compiler phase.

Positions exist to describe locations rather than language constructs.

---

# Source Span

A source span represents a contiguous region of source code.

Every span consists of:

* one beginning position;
* one ending position.

Source spans identify the complete textual extent of a language construct.

---

# Ownership

Source ownership follows the same ownership model as the Abstract Syntax Tree.

Every token owns one source span.

Every AST node owns one source span.

Ownership is exclusive.

Source spans shall never be shared through mutable state.

---

# Propagation

Source information originates exclusively during lexical analysis.

Subsequent compiler phases propagate existing information rather than constructing new source locations.

The parser combines token spans to construct node spans.

Semantic analysis preserves source ownership established by parsing.

---

# Architectural Responsibilities

## Lexer

Responsible for producing accurate source locations for every token.

---

## Parser

Responsible for constructing source spans for syntax nodes from token locations.

---

## AST

Responsible for permanently owning source spans.

---

## Semantic Analysis

Responsible for consuming source information without modifying it.

---

## Diagnostics

Responsible for presenting source information to users.

Diagnostics shall not redefine source locations.

---

# Architectural Invariants

The following invariants shall always hold.

## Immutable Origin

Source files are immutable.

---

## Complete Ownership

Every token owns exactly one source span.

Every syntax node owns exactly one source span.

---

## Valid Ranges

Every source span shall represent a valid region within its originating source file.

---

## Phase Preservation

Compiler phases shall preserve source ownership.

No compilation phase shall discard source information required by subsequent phases.

---

## Consistent Interpretation

Every subsystem shall interpret source positions identically.

---

# Future Evolution

The source model is expected to support future capabilities including:

* macro expansion;
* generated source mapping;
* incremental parsing;
* interactive tooling;
* source rewriting;
* debugging information.

These capabilities should extend the existing architectural model rather than replacing it.

