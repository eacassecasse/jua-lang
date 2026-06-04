# Architecture Overview

## System Pipeline

Jua compilation follows a layered architecture:

```text
Source Code
    ↓
Lexer
    ↓
Parser
    ↓
AST
    ↓
Semantic Analysis
    ↓
HIR
    ↓
MIR
    ↓
Backend
    ↓
WASM / Target
```

---

## Layer Responsibilities

### Lexer

Converts raw source code into tokens.

---

### Parser

Transforms tokens into AST.

---

### AST

Represents syntactic structure of the program.

---

### Semantic Analysis

Validates:

* types
* scopes
* module resolution

---

### HIR (High-Level IR)

Simplified semantic representation.

---

### MIR (Mid-Level IR)

Control-flow explicit representation for optimization.

---

### Backend

Generates target code (initially WASM).

---

## Design Principles

* separation of concerns
* explicit transformations between stages
* no cross-layer dependencies
* specification-driven correctness

---

## Important Constraint

The compiler must always be consistent with `specs/`.

Any divergence is considered a defect, not an implementation choice.

