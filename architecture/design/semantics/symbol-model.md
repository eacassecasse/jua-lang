# Symbol Model

---

Status: Accepted

Related Specifications

* specs/semantics/symbol-table-model.md
* specs/semantics/scope-resolution.md
* specs/type-system/type-system-overview.md

Related Architectural Decisions

* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture

Related Design Documents

* Semantic Architecture
* Semantic Model
* Abstract Syntax Tree

---

# Purpose

The Symbol Model defines the architectural representation of named program entities.

Symbols establish semantic identity independently of syntax and provide the canonical representation through which compiler phases reason about declarations and references.

Symbols are the primary semantic entities produced during semantic analysis.

---

# Scope

This document specifies:

* symbol identity;
* symbol ownership;
* symbol lifetime;
* symbol relationships;
* architectural invariants.

This document does not specify:

* scope implementation;
* symbol tables;
* lookup algorithms;
* name resolution.

These concerns are defined by specialised semantic design documents.

---

# Design Goals

The Symbol Model satisfies the following objectives.

## Stable Identity

Every declared program entity shall correspond to exactly one symbol.

The identity of a symbol remains stable throughout compilation.

---

## Syntax Independence

Symbols represent semantic entities rather than syntax nodes.

Syntax introduces declarations.

Symbols represent them.

---

## Explicit Ownership

Every symbol shall belong to exactly one lexical owner.

Ownership relationships shall be explicit.

---

## Unambiguous Resolution

References shall resolve to symbols rather than syntax nodes.

Subsequent compiler phases operate exclusively on symbols.

---

## Extensibility

Future language constructs shall introduce specialised symbol categories without altering the architectural contract established by this model.

---

# Architectural Role

Symbols bridge declarations and semantic reasoning.

```text
Declaration
      │
      ▼
   Symbol
      │
      ▼
Compiler Phases
```

Symbols become the canonical representation of program entities.

---

# Symbol Identity

A symbol represents one declared program entity.

Its identity is independent from:

* source position;
* syntax node identity;
* traversal order;
* implementation details.

Multiple references may designate the same symbol.

---

# Symbol Ownership

Symbols exist within lexical ownership hierarchies.

Typical ownership relationships include:

* module owns declarations;
* function owns parameters;
* object owns members;
* block owns local variables.

Ownership establishes semantic containment.

It does not define visibility.

---

# Symbol Categories

The semantic architecture recognises multiple categories of symbols.

Examples include:

* variable symbols;
* parameter symbols;
* function symbols;
* object symbols;
* interface symbols;
* trait symbols;
* module symbols;
* type symbols.

Each category extends the common symbol abstraction while introducing category-specific semantic information.

---

# Declaration Relationship

Every declaration introduces exactly one symbol.

One declaration shall never introduce multiple unrelated symbols.

Multiple declarations shall never produce the same symbol.

This establishes a one-to-one correspondence between declarations and semantic identity.

---

# Reference Relationship

References do not own symbols.

Instead, references establish relationships with previously declared symbols through name resolution.

Semantic analysis therefore transforms:

```text
Identifier

↓

Resolved Symbol
```

Subsequent compiler phases operate on symbols rather than identifiers.

---

# Symbol Lifetime

Symbols exist for the duration of compilation.

Their lifetime begins when introduced by semantic analysis.

Their lifetime ends when compilation terminates.

Symbols are immutable after construction except where explicitly extended by later semantic phases.

---

# Architectural Boundaries

## Abstract Syntax Tree

Represents declarations.

Owns no symbols.

---

## Symbol Model

Represents semantic identity.

Owns no syntax.

---

## Scope Model

Organises symbol visibility.

Does not define symbol identity.

---

## Type Model

Associates type information with symbols.

Does not establish identity.

---

# Architectural Invariants

The following invariants shall always hold.

## Unique Identity

Every symbol possesses exactly one semantic identity.

---

## Explicit Ownership

Every symbol has one lexical owner.

---

## Immutable Identity

Symbol identity never changes during compilation.

---

## Declaration Correspondence

Every declaration introduces one symbol.

---

## Reference Independence

References never own semantic identity.

References designate symbols.

---

## Syntax Independence

Symbols shall never become embedded within syntax nodes.

---

# Extension Strategy

Future language evolution extends the Symbol Model through additional symbol categories.

Examples include:

* generic parameter symbols;
* namespace symbols;
* package symbols;
* enumeration symbols;
* compile-time constant symbols.

Extensions preserve the common architectural contract while introducing category-specific semantic information.

---

# Relationship with Scope Model

The Scope Model determines where symbols may be observed.

The Symbol Model determines what those entities are.

Ownership and visibility remain independent architectural concerns.

---

# Relationship with Name Resolution

Name resolution establishes the relationship between references and symbols.

The Symbol Model defines the semantic entities that resolution discovers.

---

# Relationship with Type Model

Type information enriches symbols after identity has been established.

Types classify symbols.

They do not define them.

---

# Future Evolution

The Symbol Model anticipates future support for:

* overload sets;
* generic instantiations;
* trait implementations;
* interface conformance;
* imported symbols;
* exported symbols;
* compiler-generated symbols.

These capabilities should extend the Symbol Model while preserving the architectural principles established by this document.

