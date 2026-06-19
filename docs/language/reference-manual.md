# Jua Language Reference Manual

Version: 0.1 Draft

Status: Working Draft

Authors:

* Edmilson Cassecasse

---

# 1. Introduction

## 1.1 Purpose

This document provides a consolidated reference for the Jua programming language.

It describes the language architecture, syntax, semantics, type system, execution model, tooling strategy, and long-term direction.

This manual is intended to serve as the primary reference for language users, compiler contributors, educators, and organizations adopting Jua.

Where conflicts exist between this document and individual specifications, the specifications and accepted Architecture Decision Records (ADRs) take precedence.

---

## 1.2 Vision

Jua is a general-purpose programming language designed to make software development accessible while preserving technical rigor.

The language prioritizes:

* readability
* maintainability
* educational value
* predictable behavior
* modern compiler architecture
* interoperability

Jua seeks to reduce accidental complexity while maintaining compatibility with established software engineering practices.

---

## 1.3 Design Principles

### Education as a First-Class Concern

Language constructs should be understandable by newcomers without sacrificing professional applicability.

### Explicitness Over Magic

Language behavior should be visible and predictable.

### Specification-Driven Development

Language behavior is defined by formal specifications and ADRs.

### Long-Term Maintainability

Features are evaluated not only by usefulness but also by implementation and maintenance cost.

### Tool Independence

Compiler components should remain independent from specific implementation technologies whenever practical.

---

# 2. Language Overview

## 2.1 Paradigm Support

Jua supports:

* Procedural programming
* Modular programming
* Object-oriented programming through composition
* Trait-based code reuse
* Interface-based contracts

Future versions may introduce additional paradigms through formally accepted proposals.

---

## 2.2 Target Audience

Jua is intended for:

* Students
* Educators
* Independent developers
* Startups
* Government and public-sector initiatives
* Organizations requiring maintainable software systems

---

## 2.3 Compilation Strategy

Current compilation architecture:

Source Code
→ Lexer
→ Parser
→ AST
→ Semantic Analysis
→ HIR
→ MIR
→ Backend
→ Executable Output

Primary backend target:

* WebAssembly (WASM)

Future targets:

* Native executables
* Bytecode
* Interpreter execution

---

# 3. Lexical Structure

## 3.1 Character Set

Jua source files are encoded using UTF-8.

Identifiers support Unicode characters subject to specification-defined constraints.

---

## 3.2 Comments

Single-line comments:

```jua
# comment
```

Multi-line comments:

```jua
#*
comment
multiple lines
*#
```

---

## 3.3 Whitespace

Whitespace is generally ignored.

Newlines are significant and serve as statement separators.

---

## 3.4 Identifiers

Identifiers represent user-defined names.

Examples:

```jua
student
calculateAverage
total_score
```

---

## 3.5 Literals

Supported literals:

* Integer literals
* Floating-point literals
* String literals
* Boolean literals
* Null literal

---

# 4. Type System

## 4.1 Type Philosophy

Jua adopts gradual typing.

Developers may begin with minimal type annotations and introduce stronger typing as systems evolve.

---

## 4.2 Primitive Types

Current planned primitive types include:

* Integer
* Float
* Boolean
* String
* Null

Future versions may introduce additional primitive types through accepted proposals.

---

## 4.3 Type Checking

Type checking occurs during semantic analysis.

The compiler validates:

* assignments
* expressions
* function calls
* return values
* interface compliance

---

# 5. Variables and Mutability

## 5.1 Immutable by Default

Variables are immutable unless explicitly declared mutable.

Example:

```jua
create age = 20
```

---

## 5.2 Mutable Variables

Example:

```jua
create mutable counter = 0
```

---

## 5.3 Scope Rules

Jua uses lexical (static) scoping.

Scope hierarchy:

Global Scope
→ Module Scope
→ Function Scope
→ Block Scope
→ Object Scope
→ Trait Scope
→ Interface Scope

---

# 6. Functions

## 6.1 Function Declaration

Functions define reusable executable units.

Example:

```jua
function add(a, b)
    return a + b
end
```

---

## 6.2 Parameters

Parameters are passed according to the memory model specification.

---

## 6.3 Return Values

Functions may return values using the return statement.

---

# 7. Control Flow

## 7.1 Conditional Execution

Supported constructs:

* if
* else

---

## 7.2 Iteration

Current supported constructs:

* while
* for

Deferred constructs:

* repeat

---

## 7.3 Flow Control

Supported statements:

* break
* continue
* return

---

# 8. Object Model

## 8.1 Design Philosophy

Jua favors composition over inheritance.

Inheritance is intentionally excluded from the language design.

---

## 8.2 Objects

Objects provide concrete implementations and state ownership.

---

## 8.3 Traits

Traits provide reusable behavior and shared implementation.

Traits may contain methods and associated behavior.

---

## 8.4 Interfaces

Interfaces define contracts without implementation.

Interfaces describe observable behavior.

---

## 8.5 Trait Usage

Traits are incorporated using the uses keyword.

---

# 9. Modules

## 9.1 Modular Organization

Code is organized through modules.

Modules provide namespace boundaries and dependency management.

---

## 9.2 Imports

Modules may import definitions from other modules.

---

## 9.3 Exports

Modules may expose selected definitions.

---

# 10. Memory Model

## 10.1 Objectives

The memory model is designed to provide:

* predictability
* efficiency
* implementation portability

---

## 10.2 Variable Lifetime

Variable lifetime follows lexical scope boundaries.

---

## 10.3 Ownership and References

Ownership and reference behavior are defined by the memory model specification.

---

# 11. Error Handling

## 11.1 Compiler Diagnostics

Diagnostics include:

* errors
* warnings
* informational messages

---

## 11.2 Source Tracking

All diagnostics include precise source locations.

---

## 11.3 Recovery

The compiler attempts recovery where practical to maximize feedback.

---

# 12. Standard Library

## 12.1 Philosophy

The standard library provides essential functionality without excessive scope.

---

## 12.2 Areas

Planned areas include:

* Collections
* Strings
* Mathematics
* Input/Output
* Testing
* Utilities

---

# 13. Tooling

## 13.1 Compiler

Reference compiler implementation.

---

## 13.2 Formatter

Future language formatter.

---

## 13.3 Package Manager

Future package management system.

---

## 13.4 Testing Framework

Integrated testing support.

---

# 14. Versioning

Language evolution follows formal versioning rules.

Breaking changes require specification updates and accepted ADRs.

---

# 15. Architecture Decision Records

Architectural decisions are maintained separately through ADRs.

Current ADRs govern:

* repository structure
* compiler architecture
* type system strategy
* object model
* mutability
* indexing model
* backend targets
* governance

---

# 16. Future Direction

The following items are recognized for future evaluation:

* Repeat loop
* Pattern matching
* Generics
* Advanced type-system capabilities
* Additional backend targets
* Package ecosystem

Inclusion requires formal proposal and acceptance.

---

# 17. Conformance

A compiler implementation is considered conformant when its behavior matches the accepted specifications and ADRs for the targeted language version.

