# Governance Overview

## Purpose

This document explains how decisions are proposed, discussed, approved, implemented, and maintained within the Jua project.

The objective is to ensure transparency, consistency, and long-term maintainability.

---

# Governance Model

Jua follows a documentation-driven governance model.

Major decisions are recorded and preserved through structured artifacts.

The primary governance mechanisms are:

- Issues
- Discussions
- RFCs
- ADRs
- Pull Requests

---

# Issues

Issues represent work that needs to be performed.

Examples include:

- bugs
- feature requests
- documentation updates
- tooling improvements

Issues should be created before implementation begins.

---

# Discussions

Discussions provide a space for:

- brainstorming
- community feedback
- early proposals
- design exploration

Discussions are not considered authoritative decisions.

---

# RFCs

Request for Comments (RFCs) are used for significant proposed changes.

Examples:

- new language features
- module system modifications
- runtime architecture changes

RFCs allow structured evaluation before implementation begins.

---

# ADRs

Architecture Decision Records (ADRs) document accepted architectural decisions.

Examples:

- WebAssembly-first strategy
- gradual typing
- traits over inheritance

ADRs represent historical decisions and their rationale.

ADRs are considered authoritative after acceptance.

---

# Pull Requests

Pull Requests implement approved work.

A Pull Request should:

- reference an issue
- follow repository standards
- pass all required validations

Pull Requests are implementation mechanisms, not decision mechanisms.

---

# Branching Strategy

Jua maintains two protected long-lived branches:

```text
main
dev
````

---

## main

The main branch contains stable, releasable code.

Direct commits are prohibited.

Changes reach main only through Pull Requests.

---

## dev

The development branch serves as the primary integration branch.

Most Pull Requests target dev.

---

## Feature Branches

Examples:

```text
feature/123-traits
fix/456-parser-error
docs/789-contributing-guide
```

Feature branches should be created from dev.

---

# Decision Flow

Most significant changes follow:

```text
Discussion
    ↓
Issue
    ↓
RFC (if required)
    ↓
ADR (if required)
    ↓
Implementation
    ↓
Pull Request
```

Not every change requires every step.

The appropriate level of governance should be proportional to the impact of the change.

---

# Source of Truth

The authoritative sources for project decisions are:

```text
specs/
architecture/adr/
```

Implementation code should conform to documented decisions and specifications.

---

# Governance Principles

The governance process is guided by:

* transparency
* documentation
* reproducibility
* maintainability
* long-term thinking

The objective is not to increase bureaucracy, but to preserve project quality as the ecosystem grows.

