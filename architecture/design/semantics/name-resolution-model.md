# Name Resolution Model

---

Status: Accepted

Related Specifications

* specs/semantics/scope-resolution.md
* specs/semantics/scope.md

Related Architectural Decisions

* ADR-0008 — Layered Compiler Architecture
* ADR-0010 — Tool-Agnostic Frontend Architecture

Related Design Documents

* Semantic Architecture
* Semantic Model
* Symbol Model
* Scope Model

---

# Purpose

The Name Resolution Model defines the architectural process through which syntactic references are associated with semantic symbols.

Name resolution establishes semantic bindings between identifiers and declarations.

It transforms unresolved program structure into semantically connected program structure.

---

# Scope

This document specifies:

* semantic binding;
* reference resolution;
* visibility traversal;
* resolution responsibilities;
* architectural invariants.

This document does not specify:

* scope construction;
* symbol storage;
* type inference;
* overload resolution.

These concerns belong to specialised semantic subsystems.

---

# Design Goals

The Name Resolution Model satisfies the following objectives.

## Unique Binding

Every successfully resolved reference shall designate exactly one symbol.

---

## Deterministic Resolution

Equivalent programs shall always produce equivalent bindings.

---

## Lexical Resolution

References shall be resolved according to lexical visibility established by the Scope Model.

---

## Symbol Independence

Resolution discovers symbols.

It never creates them.

---

## Type Independence

Resolution establishes identity before type analysis.

Name resolution shall not depend upon inferred types.

---

# Architectural Role

Name resolution connects syntax with semantic identity.

```text
Identifier

↓

Visibility Analysis

↓

Resolved Symbol
```

Resolution establishes semantic relationships required by all subsequent compiler phases.

---

# Semantic Binding

A semantic binding represents the association between a reference and a symbol.

Bindings are established exactly once.

Subsequent compiler phases operate upon bindings rather than repeating resolution.

---

# Resolution Strategy

Resolution proceeds according to lexical visibility.

Beginning with the innermost visible scope, progressively enclosing scopes are examined until:

* one matching symbol is discovered;
* no enclosing scope remains.

The traversal strategy is determined by lexical structure rather than implementation.

---

# Resolution Outcomes

Every reference produces exactly one of the following outcomes.

## Successful Resolution

The reference is associated with one symbol.

---

## Unresolved Reference

No visible declaration exists.

A semantic diagnostic is produced.

---

## Ambiguous Resolution

Multiple visible declarations satisfy the reference.

A semantic diagnostic is produced.

The language specification determines whether ambiguity is permitted for specialised language constructs.

---

# Shadowing

When multiple declarations share the same identifier across nested scopes, the nearest visible declaration shall be selected.

Shadowing affects visibility only.

It does not alter symbol identity.

---

# Imports

Imported declarations participate in resolution according to the module visibility model.

Import resolution extends lexical visibility without altering the architectural resolution process.

---

# Architectural Boundaries

## Symbol Model

Provides semantic identities.

Resolution discovers symbols.

---

## Scope Model

Defines visibility.

Resolution traverses visibility.

---

## Type Model

Consumes established bindings.

Resolution does not depend upon type information.

---

# Architectural Invariants

The following invariants shall always hold.

## One Binding

Every successfully resolved reference shall designate exactly one symbol.

---

## Stable Binding

Bindings remain stable throughout semantic analysis.

Subsequent compiler phases shall observe identical semantic identities.

---

## Symbol Preservation

Resolution shall never create, modify, or destroy symbols.

---

## Visibility Compliance

Every successful binding shall satisfy the visibility rules defined by the Scope Model.

---

## Deterministic Behaviour

Equivalent programs shall always produce equivalent bindings.

---

# Extension Strategy

Future language evolution may extend the resolution process to support:

* module imports;
* generic parameters;
* trait members;
* interface members;
* extension methods;
* namespace qualification.

These capabilities should extend the resolution architecture without altering its fundamental responsibilities.

---

# Relationship with Type Model

Type checking assumes all references have already been resolved.

Type analysis operates on semantic bindings rather than textual identifiers.

---

# Relationship with Semantic Diagnostics

Resolution failures produce semantic diagnostics.

Diagnostics describe unresolved, inaccessible, or ambiguous references.

The diagnostic subsystem communicates these failures without altering the resolution process.

---

# Future Evolution

The Name Resolution Model anticipates future support for:

* qualified names;
* generic specialisation;
* alias declarations;
* compile-time imports;
* incremental semantic analysis.

These capabilities should preserve the architectural principles established by this document.

