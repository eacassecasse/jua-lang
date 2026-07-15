# Contributing to Jua

## Context

Jua is a programming language, compiler ecosystem, and education platform. Contributions can affect language semantics, compiler correctness, runtime behavior, tooling, or educational material. As such, contributions must follow strict governance rules to ensure long-term consistency and correctness.

---

## How to Contribute

Contributions fall into five categories:

### 1. Language Design

Changes affecting syntax, semantics, type system, or core language behavior.

Requires:

* Language Proposal Issue
* Possible RFC
* ADR when architectural impact exists

---

### 2. Compiler Development

Changes to:

* lexer
* parser
* AST
* semantic analysis
* IR
* code generation

Requires:

* linked issue
* test coverage
* conformance validation where applicable

---

### 3. Tooling

Includes:

* formatter
* linter
* language server
* package manager
* CLI tools

Requires:

* tool-specific issue template
* backward compatibility review when relevant

---

### 4. Standard Library

Changes to:

* core APIs
* IO
* networking
* collections

Requires:

* API stability consideration
* documentation update

---

### 5. Education Content

Includes:

* curriculum
* tutorials
* exercises

Requires:

* pedagogical clarity
* review for beginner accessibility

---

## Development Workflow

### Step 1 — Create an Issue

All work must begin with an issue using the correct template.

---

### Step 2 — Branch Strategy

```text
feature/<issue-id>-short-description
fix/<issue-id>-short-description
language/<issue-id>-proposal-name
```

---

### Step 3 — Commit Standards

All commits must follow Conventional Commits:

```text
feat(parser): add trait parsing support
```

Enforced via:

* commitizen (local)
* husky (local)
* commitlint (CI)

---

### Step 4 — Pull Requests

All PRs must:

* link an issue
* follow PR template
* include tests where applicable
* declare ADR impact if relevant

---

## Language Proposals

Any change to Jua language must follow:

1. Language Proposal Issue
2. Discussion (if needed)
3. RFC (for large changes)
4. ADR (for architectural decisions)
5. Implementation PR

---

## ADR Policy

ADRs are mandatory when:

* modifying compiler architecture
* changing language semantics
* altering type system rules
* introducing new execution models

---

## Testing Expectations

Depending on the change:

* Unit tests required for logic changes
* Integration tests required for compiler stages
* Conformance tests required for language behavior changes

---

## Review Process

No PR may be merged without:

* at least one approval
* CI passing
* template compliance

---

## Code Philosophy

* Explicit over implicit
* Readability over cleverness
* Predictability over magic
* Specification over implementation assumptions

---
