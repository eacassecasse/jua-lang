# Parser Architecture

---

Status: Accepted

Related Specifications

* specs/grammar/grammar.md
* specs/grammar/syntax-grammar.md
* specs/frontend/parser-ast-contract.md
* specs/diagnostics/compiler-diagnostics.md

Related Architectural Decisions

* ADR-0007 — Language Specification as Source of Truth
* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture

Related Design Documents

* Frontend Architecture Overview
* Source Model
* Abstract Syntax Tree
* Visitor Framework

---

# Purpose

The parser is responsible for recognising syntactically valid Jua programs and constructing the corresponding Abstract Syntax Tree.

It forms the architectural boundary between lexical analysis and structural program representation.

The parser validates syntax exclusively.

Semantic interpretation, symbol resolution, type checking, optimisation, and execution are explicitly outside its responsibilities.

---

# Scope

This document specifies:

* parser responsibilities;
* parser boundaries;
* parser interactions;
* syntax tree construction;
* diagnostic responsibilities;
* architectural invariants.

This document does not specify:

* grammar productions;
* parser generator configuration;
* parsing algorithms;
* semantic analysis;
* runtime behaviour.

---

# Design Goals

The parser architecture is designed to satisfy the following objectives.

## Structural Correctness

The parser shall construct syntax trees that accurately represent the grammar defined by the language specification.

---

## Determinism

Given an identical token sequence, the parser shall always produce identical syntax trees and diagnostics.

---

## Grammar Fidelity

The parser shall implement the language grammar without introducing additional language semantics.

Observable language behaviour is defined exclusively by the language specification.

---

## Phase Isolation

The parser shall remain independent from every compiler phase that follows it.

It shall not perform:

* symbol resolution;
* type inference;
* constant evaluation;
* optimisation.

---

## Error Resilience

Whenever practical, the parser should recover from syntax errors sufficiently to continue analysing the remaining source.

Recovery shall maximise diagnostic quality while preserving architectural correctness.

---

# Architectural Role

The parser transforms a token stream into a structural representation suitable for later compilation phases.

```text
Source File
      │
      ▼
Lexer
      │
      ▼
Token Stream
      │
      ▼
Parser
      │
      ▼
Abstract Syntax Tree
```

The parser consumes tokens.

The parser produces syntax trees.

The parser owns neither source files nor semantic information.

---

# Architectural Responsibilities

The parser is responsible for:

* recognising grammar productions;
* validating syntactic structure;
* constructing AST nodes;
* propagating source spans;
* reporting syntax diagnostics;
* preserving structural invariants.

The parser shall not interpret program meaning.

---

# Input Contract

The parser accepts a canonical token stream produced by lexical analysis.

Every token supplied to the parser shall:

* represent exactly one lexical element;
* own a valid source span;
* conform to the token model defined by the frontend.

The parser assumes lexical correctness.

---

# Output Contract

Successful parsing produces exactly one Program node representing the compilation unit.

Failed parsing produces syntax diagnostics.

Partial syntax trees may be constructed when recovery succeeds.

The parser shall never produce semantically enriched trees.

---

# Tree Construction

The parser is the exclusive producer of Abstract Syntax Trees.

Every syntax node originates during parsing.

The parser establishes:

* structural hierarchy;
* node ownership;
* source span ownership.

Subsequent compiler phases consume these structures without altering their architectural meaning.

---

# Source Propagation

Source information originates during lexical analysis.

The parser combines token spans into syntax node spans.

The parser shall preserve complete source ownership throughout tree construction.

Every AST node produced by the parser owns a valid source span.

---

# Diagnostics

The parser reports violations of the language grammar.

Examples include:

* unexpected tokens;
* missing delimiters;
* malformed declarations;
* incomplete expressions.

Parser diagnostics describe syntactic failures only.

Semantic errors belong to later compiler phases.

---

# Error Recovery

Error recovery exists to improve diagnostic quality rather than to preserve program execution.

Recovery mechanisms shall attempt to continue parsing while maintaining a structurally valid syntax tree whenever possible.

Recovery strategies shall not compromise architectural invariants.

The detailed recovery model is specified separately.

---

# Architectural Invariants

The following invariants shall always hold.

## Grammar Compliance

Every successfully constructed syntax node corresponds to a valid grammar production.

---

## Single Root

Every successful parse produces exactly one Program node.

---

## Structural Ownership

The parser establishes the complete ownership hierarchy of the AST.

Ownership relationships shall never be ambiguous.

---

## Source Ownership

Every node produced by the parser owns a valid source span.

---

## Semantic Neutrality

The parser shall never introduce semantic information into the syntax tree.

---

## Deterministic Construction

Equivalent token streams shall produce structurally equivalent syntax trees.

---

# Extension Strategy

Language evolution extends the parser by introducing new grammar productions and corresponding syntax constructs.

Parser evolution shall preserve existing architectural contracts.

New language features should integrate through extension rather than modification of established parser responsibilities.

---

# Relationship with the Visitor Framework

The parser constructs syntax trees.

Visitors consume syntax trees.

The parser never executes compiler analyses.

Traversal architecture begins only after parsing has successfully produced an Abstract Syntax Tree.

---

# Relationship with Semantic Analysis

Semantic analysis operates exclusively on the parser's output.

The parser establishes program structure.

Semantic analysis establishes program meaning.

These responsibilities remain strictly separated throughout the compiler architecture.

---

# Future Evolution

The parser architecture anticipates future language evolution including:

* functions;
* objects;
* traits;
* interfaces;
* modules;
* generics;
* pattern matching.

Such additions should extend the grammar while preserving the parser's architectural responsibilities and boundaries.

