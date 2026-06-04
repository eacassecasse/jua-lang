# Compiler Overview

## Purpose

This document provides a high-level overview of the Jua compiler architecture.

Its goal is to help contributors understand the responsibilities of each compiler stage before working on implementation details.

This document intentionally focuses on architecture rather than specific implementation technologies.

---

# Architectural Principles

The Jua compiler follows a layered architecture.

Each layer has a single responsibility and communicates with other layers through well-defined contracts.

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
Target Output
````

The compiler is designed around the following principles:

* Separation of concerns
* Explicit transformation stages
* Tool independence
* Specification-driven correctness
* Replaceable implementations

---

# Compilation Pipeline

## Source Code

The compilation process begins with Jua source files.

Example:

```jua
fn greet(name)
    print("Hello " + name)
end
```

Source files contain raw text and have no semantic meaning until processed by the compiler.

---

## Lexer

The lexer converts source code into a sequence of tokens.

Example:

```text
fn greet(name)
```

becomes:

```text
FN
IDENTIFIER(greet)
LEFT_PAREN
IDENTIFIER(name)
RIGHT_PAREN
```

The lexer is responsible for:

* token recognition
* keyword identification
* literal parsing
* source position tracking

The lexer should not perform semantic analysis.

---

## Parser

The parser transforms tokens into an Abstract Syntax Tree (AST).

Example:

```text
FunctionDeclaration
 ├── Name: greet
 └── Parameter: name
```

The parser is responsible for:

* syntax validation
* AST construction
* syntax error recovery

The parser should not perform type checking or name resolution.

---

## Abstract Syntax Tree (AST)

The AST represents the syntactic structure of the program.

The AST acts as the primary contract between parsing and semantic analysis.

The AST should contain:

* expressions
* statements
* declarations
* type annotations

The AST should not contain semantic information.

---

## Semantic Analysis

Semantic analysis validates program correctness.

Examples include:

* type checking
* scope validation
* symbol resolution
* module resolution

This phase determines whether a program is valid according to the language specification.

---

## High-Level Intermediate Representation (HIR)

HIR is a semantically validated representation of the program.

HIR simplifies AST structures and prepares the program for later transformations.

HIR should:

* preserve program meaning
* remove syntactic noise
* simplify later compiler stages

---

## Mid-Level Intermediate Representation (MIR)

MIR introduces explicit control flow and execution semantics.

Typical transformations include:

* control flow graph construction
* lowering complex expressions
* optimization preparation

MIR acts as the primary input for code generation.

---

## Backend

Backends transform MIR into executable targets.

The initial Jua backend target is:

* WebAssembly (WASM)

Future targets may include:

* JVM
* Native executables
* Bytecode interpreters

Backends should remain independent of frontend implementation details.

---

# Compiler Boundaries

The compiler must never become the source of truth for language behavior.

The source of truth remains:

```text
specs/
```

Compiler implementation must follow the specification.

Any divergence between specification and implementation is considered a defect.

---

# Future Evolution

The compiler architecture is intentionally designed to support:

* multiple backends
* multiple compiler implementations
* advanced optimization passes
* improved diagnostics
* IDE tooling integration

Changes to architectural boundaries should be documented through ADRs.
