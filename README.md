# Jua

Jua is a modern programming language designed to make software development more approachable without sacrificing clarity, consistency, or engineering discipline.

The project aims to provide a language that is easy to learn, particularly for students and first-time programmers, while remaining suitable for building real-world software.

The name *Jua* reflects the project's focus on learning, accessibility, and practical problem solving.

---

## Vision

Jua seeks to bridge the gap between educational programming languages and production-oriented languages.

The language is designed around three core goals:

* Simplicity
* Consistency
* Practicality

Rather than introducing complexity early, Jua prioritizes clear semantics, predictable behavior, and progressive learning.

---

## Design Principles

The language is guided by several architectural principles:

* Education as a first-class concern
* Explicit over implicit behavior
* Immutable-by-default variables
* Zero-based indexing
* Traits over inheritance
* Gradual typing
* Value-based equality
* Specification-driven development

All significant language and architecture decisions are documented through Architectural Decision Records (ADRs).

---

## Current Status

Jua is currently in the language specification phase.

Completed areas include:

* Language architecture
* Compiler architecture
* Module system
* Type system
* Memory model
* Semantic analysis model
* AST model
* Symbol table model
* Diagnostics model
* Governance process

Compiler implementation is planned as the next major milestone.

---

## Repository Structure

```text
docs/
├── decisions/
├── specifications/

compiler/
runtime/
stdlib/
tools/
```

The exact structure may evolve as implementation progresses.

---

## Architecture

The Jua compiler follows a layered architecture:

```text
Source Code
    ↓
Lexer
    ↓
Parser
    ↓
Abstract Syntax Tree
    ↓
Semantic Analysis
    ↓
Backend Generation
```

The initial compilation target is WebAssembly.

See ADR-0002 for details.

---

## Documentation

### Architectural Decisions

All major decisions are documented under:

```text
docs/decisions/
```

### Language Specifications

The language specification is maintained under:

```text
docs/specifications/
```

These specifications are the authoritative definition of the language.

---

## Roadmap

### Phase 1 — Language Foundation

* [x] Governance
* [x] ADR process
* [x] Core language semantics
* [x] Type system
* [x] Module system
* [x] Compiler architecture

### Phase 2 — Compiler Frontend

* [ ] Lexer
* [ ] Parser
* [ ] AST implementation
* [ ] Semantic analysis
* [ ] Diagnostics

### Phase 3 — WebAssembly Backend

* [ ] Code generation
* [ ] Runtime integration
* [ ] Standard library implementation

### Phase 4 — Ecosystem

* [ ] Package management
* [ ] Tooling
* [ ] Language server
* [ ] Documentation portal

---

## Contributing

Contributions are welcome.

Before contributing, please review:

* Architectural Decision Records (ADRs)
* Language specifications
* Contribution guidelines

The language follows a specification-first development model.

---

## License

License information will be added once the project licensing model is finalized.

