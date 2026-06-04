# Repository Guide

## Purpose

This document explains the architecture and responsibility boundaries of the Jua repository.

---

## Top-Level Structure

### specs/

Defines the official Jua language specification.

This is the source of truth for:

* syntax
* semantics
* type system
* module system

---

### compiler/

Implements the Jua compiler pipeline:

* frontend
* middleend
* backend

---

### runtime/

Defines execution environment behavior.

---

### stdlib/

Standard library exposed to users.

---

### toolchain/

Developer tools:

* formatter
* linter
* CLI
* language server

---

### tests/

Validation layer:

* unit tests
* integration tests
* conformance tests

---

### education/

Educational resources:

* curriculum
* examples
* exercises

---

### architecture/

Contains:

* ADRs (Architecture Decision Records)
* RFCs
* design documents

---

## Key Principle

The repository is organized by responsibility boundaries, not by implementation convenience.

---

## Contribution Principle

Before modifying any subsystem:

1. Check specs/
2. Check ADRs
3. Ensure consistency with architecture/

