# Semantic Binding Model

---

Status: Accepted

Related Specifications

* specs/semantics/scope-resolution.md
* specs/semantics/type-checking.md

Related Architectural Decisions

* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture

Related Design Documents

* Semantic Architecture
* Semantic Model
* Symbol Model
* Scope Model
* Name Resolution Model

---

# Purpose

The Semantic Binding Model defines the architectural representation of resolved program references.

A binding associates one syntactic reference with one semantic symbol.

Bindings establish the semantic relationships consumed by subsequent compiler phases.

They represent the observable result of name resolution.

---

# Scope

This document specifies:

* semantic bindings;
* binding ownership;
* binding identity;
* binding lifecycle;
* architectural invariants.

This document does not specify:

* symbol construction;
* scope traversal;
* type inference;
* intermediate representation.

---

# Design Goals

The Semantic Binding Model satisfies the following objectives.

## Explicit Resolution

Every successful reference resolution shall produce an explicit semantic binding.

---

## Stable Relationships

Bindings remain stable throughout semantic analysis.

Compiler phases shall not repeatedly resolve identical references.

---

## Syntax Preservation

Bindings enrich syntax.

They never modify syntax.

---

## Symbol Independence

Bindings reference symbols.

They never own symbols.

---

## Determinism

Equivalent programs shall produce equivalent semantic bindings.

---

# Architectural Role

Bindings connect syntax with semantic identity.

```text
Reference

↓

Binding

↓

Symbol
```

Bindings represent semantic knowledge established during name resolution.

---

# Binding Identity

A binding represents exactly one semantic relationship.

Its identity is determined by:

* one reference;
* one resolved symbol.

Bindings possess no independent semantic meaning outside that relationship.

---

# Binding Ownership

Bindings belong to semantic analysis.

The Abstract Syntax Tree owns no bindings.

Symbols own no bindings.

Bindings exist as independent semantic objects.

---

# Binding Categories

The semantic architecture recognises multiple categories of bindings.

Examples include:

* variable bindings;
* parameter bindings;
* function bindings;
* object bindings;
* interface bindings;
* module bindings.

Each category associates one reference with one specialised symbol category.

---

# Binding Construction

Bindings are established exclusively by name resolution.

No subsequent compiler phase shall create additional semantic bindings for the same reference.

Compiler phases consume established bindings.

---

# Binding Lifetime

Bindings exist from successful name resolution until compilation terminates.

Subsequent semantic passes extend semantic information without altering established bindings.

---

# Architectural Boundaries

## Name Resolution

Produces bindings.

---

## Symbol Model

Provides semantic identities.

Bindings reference symbols.

---

## Type Model

Consumes bindings.

Type analysis shall operate upon bindings rather than textual identifiers.

---

## Intermediate Representation

Consumes bindings to identify semantic entities.

---

# Architectural Invariants

The following invariants shall always hold.

## Single Symbol

Every successful binding references exactly one symbol.

---

## Stable Relationship

Bindings remain unchanged after construction.

---

## Syntax Independence

Bindings never become embedded within syntax nodes.

---

## Symbol Independence

Bindings reference symbols without owning them.

---

## Deterministic Construction

Equivalent programs produce equivalent semantic bindings.

---

# Extension Strategy

Future language evolution may introduce specialised binding categories including:

* generic bindings;
* imported bindings;
* extension bindings;
* compile-time bindings;
* pattern bindings.

These extensions preserve the architectural contracts established by this model.

---

# Relationship with Name Resolution

Name resolution establishes semantic bindings.

Bindings therefore represent the observable product of the resolution process.

---

# Relationship with Type Model

Type analysis consumes bindings to determine semantic properties of references.

Bindings eliminate repeated scope traversal.

---

# Relationship with Semantic Diagnostics

Diagnostics reference bindings when reporting semantic errors involving successfully resolved program entities.

Unresolved references produce diagnostics before bindings exist.

---

# Future Evolution

The Semantic Binding Model anticipates future support for:

* incremental semantic analysis;
* cached semantic bindings;
* interactive compilation;
* language server protocols;
* semantic indexing.

These capabilities should extend the binding architecture while preserving its fundamental responsibilities.

