# Parser–AST Contract

## Purpose

This document defines the contract between the generated parser and the Abstract Syntax Tree (AST) construction layer in the Jua compiler frontend.

It ensures that:

* The parser generator remains independent of AST structure
* AST construction is deterministic and testable
* Grammar rules do not directly embed semantic logic
* Future replacement of the parser generator is possible without affecting semantics

This contract is a key part of ADR-0010 (Tool-Agnostic Frontend Architecture).

---

# Architecture Overview

The frontend parsing pipeline is structured as follows:

```text id="pact1"
Source Code
   ↓
Lexer (JFlex)
   ↓
Token Stream
   ↓
Generated Parser
   ↓
Parse Events / Rule Reductions
   ↓
AST Builder
   ↓
AST
```

The generated parser MUST NOT directly produce AST nodes.

Instead, it emits structured parse information consumed by the AST Builder.

---

# Design Principles

The parser–AST boundary follows these principles:

* Separation of concerns
* Grammar independence from AST representation
* No semantic evaluation during parsing
* Deterministic AST construction
* Minimal coupling to parser generator technology
* Explicit node construction rules

---

# Parser Responsibilities

The generated parser is responsible for:

## 1. Syntax validation

The parser must ensure that token sequences conform to the grammar.

---

## 2. Rule reduction events

For each grammar rule matched, the parser must emit a structured reduction event.

Example:

```text id="evt1"
Rule: function_declaration
Tokens: FUNCTION IDENTIFIER ( PARAM_LIST ) BLOCK END
```

---

## 3. Error detection

The parser must detect syntax errors and report them via the diagnostics subsystem.

---

## 4. Recovery signaling

The parser must provide recovery hints for invalid constructs but must not attempt semantic correction.

---

# AST Builder Responsibilities

The AST Builder is responsible for:

## 1. AST node creation

Transform parser reduction events into AST nodes.

---

## 2. Structural validation

Ensure AST consistency after construction.

---

## 3. Node normalization

Convert parser-level constructs into canonical AST forms.

Example:

```text id="norm1"
Expression → BinaryExpression(left, operator, right)
```

---

## 4. Integration with diagnostics

Attach source spans and diagnostic metadata to AST nodes.

---

# AST Construction Model

AST construction is event-driven.

Each parser rule emits a **ParseNodeEvent**.

---

## ParseNodeEvent Structure

```text id="event2"
ParseNodeEvent
├── ruleName
├── children
├── tokens
├── span
└── metadata (optional)
```

---

## Example Event

Function declaration:

```jua id="ex1"
function add(a, b)
    return a + b
end
```

Generated event:

```text id="evt2"
ruleName: function_declaration

children:
  - identifier: "add"
  - parameters: ["a", "b"]
  - body: Block(...)
```

---

# AST Builder Contract

The AST Builder MUST implement the following responsibilities:

## 1. Node Factory

Each grammar rule maps to a deterministic AST node constructor.

Example mapping:

```text id="map1"
function_declaration → FunctionDeclarationNode
if_statement         → IfStatementNode
expression           → ExpressionNode
```

---

## 2. Hierarchical Construction

AST nodes MUST be constructed bottom-up:

```text id="build1"
Leaf nodes → Expressions → Statements → Blocks → Program
```

---

## 3. Immutability

AST nodes MUST be immutable after construction.

This ensures:

* Thread safety
* Predictable semantic analysis
* Easier caching and optimization

---

## 4. Source Span Preservation

Each AST node MUST contain:

```text id="span1"
start position
end position
```

Derived from parser tokens.

---

# Error Handling Strategy

Parsing errors are handled in two phases:

---

## Phase 1: Parser-level errors

* Missing tokens
* Unexpected tokens
* Invalid grammar structure

These are reported immediately.

---

## Phase 2: AST-level validation errors

* Structural inconsistencies
* Invalid node composition

These are reported after AST construction.

---

# Recovery Strategy

The parser MAY attempt local recovery using:

* Synchronization tokens (e.g. NEWLINE, END)
* Rule skipping
* Panic mode recovery

However:

* Recovery MUST NOT alter AST semantics
* Recovery MUST NOT generate synthetic AST nodes without marking them

---

# Constraints

## The parser MUST NOT:

* Construct AST nodes directly
* Perform type checking
* Resolve symbols
* Infer semantics

## The AST Builder MUST NOT:

* Modify grammar rules
* Depend on parser generator internals
* Perform lexical analysis

---

# Extensibility Rules

This contract is designed to support:

* Replacement of JFlex
* Replacement of parser generator
* Migration to handwritten parser
* Introduction of IR layers (HIR/MIR)
* Future macro systems

---

# Relationship to Other Specifications

* specs/frontend/token-model.md
* specs/grammar/lexical-grammar.md
* specs/semantics/scope-resolution.md
* specs/semantics/type-checking.md
* specs/diagnostics/error-codes.md
