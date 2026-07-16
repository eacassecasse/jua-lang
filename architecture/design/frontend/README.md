# Frontend Architecture Overview

## Purpose

The frontend is responsible for transforming a Jua source file into a validated Abstract Syntax Tree (AST) suitable for semantic analysis.

It constitutes the first major subsystem of the compiler and provides the structural foundation upon which all subsequent compilation phases operate.

This document describes the architectural organisation of the frontend and the relationships between its constituent components.

Detailed subsystem designs are specified in separate design documents.

---

# Scope

The frontend includes:

* lexical analysis;
* token abstraction;
* syntactic analysis;
* abstract syntax tree construction;
* source location propagation;
* parser diagnostics;
* frontend validation infrastructure.

The frontend intentionally excludes:

* symbol resolution;
* semantic analysis;
* type checking;
* intermediate representations;
* optimisation;
* code generation.

Those responsibilities belong to subsequent compiler phases.

---

# Design Goals

The frontend architecture is designed to satisfy the following objectives.

## Deterministic

Given identical source code, the frontend shall always produce identical syntax trees and diagnostics.

---

## Phase Isolation

Each compilation phase shall operate independently.

Lexical analysis shall not depend on parsing.

Parsing shall not depend on semantic analysis.

The frontend shall never require knowledge of later compilation phases.

---

## Structural Correctness

The frontend is responsible for constructing structurally valid syntax trees.

Semantic correctness is explicitly outside its responsibilities.

---

## Tool Independence

The architectural model of the frontend shall remain independent of parser generators, lexer generators, or implementation technologies.

Parser generators are implementation details rather than architectural concepts.

---

## Extensibility

The frontend shall support incremental language evolution without requiring architectural redesign.

New language constructs should integrate by extending existing abstractions rather than replacing them.

---

# Frontend Pipeline

The frontend processes source code through a sequence of independent stages.

```text
Source File
    │
    ▼
Lexical Analysis
    │
    ▼
Token Stream
    │
    ▼
Syntactic Analysis
    │
    ▼
Abstract Syntax Tree
    │
    ▼
Frontend Validation
```

Each stage produces the input required by the following stage.

No stage depends upon later compiler phases.

---

# Architectural Components

The frontend is composed of six primary architectural components.

## Lexical Analysis

Responsible for transforming a source file into an ordered sequence of lexical tokens.

Responsibilities include:

* token recognition;
* keyword identification;
* literal parsing;
* layout token generation;
* source position tracking.

The lexer performs no syntactic or semantic validation.

---

## Token Model

The token model defines the canonical representation exchanged between lexical and syntactic analysis.

It abstracts implementation-specific lexer output into a stable compiler interface.

The token model represents the architectural boundary between the lexer and parser.

---

## Syntactic Analysis

The parser transforms the token stream into an Abstract Syntax Tree.

Responsibilities include:

* grammar recognition;
* precedence handling;
* syntax diagnostics;
* AST construction.

The parser validates syntax only.

---

## Abstract Syntax Tree

The AST provides a structural representation of the program.

It preserves language structure while intentionally omitting lexical details that are irrelevant to later compiler phases.

Every successfully parsed compilation unit produces exactly one root program node.

---

## Source Position Model

Every syntactic construct owns precise source location information.

Source positions are propagated throughout the frontend to enable:

* diagnostics;
* tooling;
* semantic analysis;
* future source transformations.

Source location ownership is considered an architectural invariant.

---

## Validation Infrastructure

The frontend includes validation mechanisms that verify parser correctness independently of later compiler phases.

Current validation includes:

* parser execution;
* AST rendering;
* deterministic snapshot comparison.

Validation infrastructure forms part of the frontend architecture rather than the testing framework.

---

# Architectural Boundaries

The frontend communicates with adjacent compiler phases through explicit contracts.

## Input

The frontend accepts:

* source files;
* compilation configuration.

No semantic information is required.

---

## Output

The frontend produces:

* Abstract Syntax Trees;
* syntax diagnostics.

The frontend never produces:

* symbol tables;
* types;
* intermediate representations.

---

# Architectural Invariants

The following invariants shall always hold.

## Compilation Units

Every successfully parsed compilation unit owns exactly one Program node.

---

## Structural Validity

Every AST produced by the frontend is structurally valid according to the language grammar.

---

## Source Ownership

Every AST node owns a valid source span.

No syntax node shall exist without source location information.

---

## Immutability

Frontend data structures shall remain immutable after construction unless explicitly documented otherwise.

---

## Layer Independence

No frontend component shall depend upon semantic analysis, optimisation, runtime services, or backend implementation.

---

# Extension Strategy

The frontend evolves through language constructs rather than implementation technologies.

Introducing a new language feature generally requires extending:

* grammar;
* AST;
* visitors;
* parser validation.

The overall frontend architecture should remain unchanged.

---

# Related Design Documents

The following documents further specify individual frontend subsystems.

* Abstract Syntax Tree
* Visitor Framework
* Source Position Model
* AST Rendering
* Parser Recovery
* Diagnostic Architecture

Each document describes one architectural concern and should be read together with this overview.

---

# Relationship with the Language Specification

This document describes how the frontend is organised.

The language specification defines what the frontend recognises.

Whenever differences arise, the language specification remains authoritative regarding observable language behaviour.

---

# Relationship with Architectural Decisions

This document realises the following architectural decisions.

* Layered Compiler Architecture
* Tool-Agnostic Frontend Architecture
* Language Specification as Source of Truth

Future revisions shall remain consistent with accepted architectural decisions unless those decisions are superseded.

