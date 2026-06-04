# ADR-0012 — Conventional Commits and Repository Governance

---
status: accepted
date: 2026-06-03
decision-makers:
  - Edmilson Cassecasse
---

# Adopt Conventional Commits and Repository Governance Standards

## Context and Problem Statement

As software projects grow, inconsistent commit messages, undocumented changes, and weak repository governance reduce maintainability and complicate collaboration.

Jua requires a predictable and scalable governance model from its earliest stages.

The question addressed by this decision is:

> How should repository changes be managed and documented?

## Decision Drivers

* Traceability
* Maintainability
* Automation support
* Collaboration readiness
* Release management
* Project governance

## Considered Options

* Unstructured Commit Messages
* Conventional Commits with Governance Controls
* Fully Automated Commit Generation

## Decision Outcome

Chosen option: "Conventional Commits with Governance Controls", because it provides a balance between human readability, automation support, and contributor discipline.

Repository governance shall include commit standards, branch protection, review processes, issue templates, labels, and CI validation.

### Consequences

* Good, because repository history becomes easier to understand.
* Good, because release automation becomes possible.
* Good, because contributor expectations become clear.
* Good, because governance scales with project growth.
* Bad, because contributors must learn the commit convention.
* Bad, because validation tooling adds setup complexity.

### Confirmation

Compliance is confirmed by ensuring that:

* Commit messages follow the Conventional Commits specification.
* Commitlint validation is enforced.
* GitHub workflows validate commit formats.
* Governance documentation remains current.

## Pros and Cons of the Options

### Unstructured Commit Messages

* Good, because no training is required.
* Good, because developers have maximum flexibility.
* Bad, because history becomes inconsistent.
* Bad, because automation opportunities are reduced.

### Conventional Commits with Governance Controls

* Good, because consistency improves.
* Good, because tooling integration becomes possible.
* Good, because release processes become easier.
* Bad, because additional contributor discipline is required.

### Fully Automated Commit Generation

* Good, because consistency is maximized.
* Good, because manual effort decreases.
* Bad, because human intent may become less clear.
* Bad, because workflow flexibility decreases.

## More Information

This decision establishes the governance foundation of the Jua repository and supports future open-source collaboration.
