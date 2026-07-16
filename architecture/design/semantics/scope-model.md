# Scope Model

---

Status: Accepted

Related Specifications

* specs/semantics/scope.md
* specs/semantics/scope-resolution.md

Related Architectural Decisions

* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture

Related Design Documents

* Semantic Architecture
* Semantic Model
* Symbol Model

---

# Purpose

The Scope Model defines the architectural representation of lexical visibility.

Scopes determine where semantic entities may be observed throughout a program.

Scopes establish visibility boundaries independently from symbol identity or storage mechanisms.

---

# Scope

This document specifies:

* lexical scopes;
* scope ownership;
* visibility boundaries;
* nesting;
* architectural invariants.

This document does not specify:

* symbol lookup;
* symbol tables;
* name resolution algorithms.

Those concerns are defined separately.

---

# Design Goals

The Scope Model satisfies the following objectives.

## Lexical Visibility

Visibility shall be determined exclusively by lexical program structure.

---

## Storage Independence

Scopes define visibility.

They do not define how symbols are stored.

---

## Explicit Nesting

Every scope shall participate in a well-defined ownership hierarchy.

---

## Determinism

Equivalent programs shall produce equivalent scope hierarchies.

---

## Extensibility

Future language constructs shall introduce additional scope categories without changing the architectural contract.

---

# Architectural Role

Scopes define where semantic entities are visible.

```text
Program

↓

Module Scope

↓

Function Scope

↓

Block Scope

↓

Local Scope
```

Visibility becomes progressively more specialised.

---

# Scope Identity

Every scope possesses a semantic identity independent from:

* syntax node identity;
* storage implementation;
* traversal order.

Scopes exist solely to establish visibility relationships.

---

# Scope Ownership

Scopes form a strict hierarchy.

Every scope except the root scope has exactly one enclosing scope.

A scope may own zero or more nested scopes.

Ownership therefore forms a tree.

---

# Visibility

Visibility is determined by scope containment.

Entities declared within a scope become visible according to the language visibility rules.

Visibility never depends upon storage implementation.

---

# Scope Categories

The semantic architecture recognises multiple categories of scope.

Examples include:

* module scope;
* object scope;
* interface scope;
* trait scope;
* function scope;
* block scope.

Each category introduces specialised visibility semantics while conforming to the common scope abstraction.

---

# Shadowing

Nested scopes may introduce declarations whose names coincide with declarations from enclosing scopes.

Shadowing affects visibility.

It never alters symbol identity.

Distinct declarations always produce distinct symbols.

---

# Scope Lifetime

Scopes exist only during semantic analysis.

Subsequent compiler phases consume semantic relationships established through scopes rather than the scopes themselves.

---

# Architectural Boundaries

## Symbol Model

Defines semantic identity.

Does not determine visibility.

---

## Scope Model

Defines visibility.

Does not determine identity.

---

## Name Resolution

Consumes both symbols and scopes.

Produces semantic bindings.

---

# Architectural Invariants

The following invariants shall always hold.

## Tree Structure

Scope ownership forms a tree.

Cycles are prohibited.

---

## Single Parent

Every scope except the root has exactly one enclosing scope.

---

## Immutable Ownership

Ownership relationships remain stable throughout semantic analysis.

---

## Visibility Independence

Visibility rules remain independent from storage mechanisms.

---

## Symbol Independence

Scopes never establish semantic identity.

They organise visibility only.

---

# Extension Strategy

Future language evolution extends the Scope Model by introducing additional scope categories.

Examples include:

* generic scopes;
* namespace scopes;
* pattern scopes;
* comprehension scopes.

Extensions preserve the architectural contracts established by this model.

---

# Relationship with Symbol Model

Symbols define what semantic entities exist.

Scopes define where those entities are visible.

Both concepts remain intentionally independent.

---

# Relationship with Name Resolution

Name resolution traverses scope hierarchies in order to associate references with symbols.

The Scope Model establishes the visibility structure that resolution observes.

---

# Future Evolution

The Scope Model anticipates future support for:

* module imports;
* namespace visibility;
* generic parameter scopes;
* nested type declarations;
* pattern variables.

These capabilities should extend the Scope Model without altering its architectural principles.

