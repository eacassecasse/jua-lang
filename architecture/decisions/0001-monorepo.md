# ADR-0001 — Adopt a Monorepo Architecture for the Jua Ecosystem

---

status: accepted
date: 2026-06-01
decision-makers:

* Edmilson Cassecasse

consulted:

* Compiler and language engineering best practices
* Open-source language ecosystem governance patterns

informed:

* Future contributors
* Toolchain maintainers
* Runtime maintainers
* Documentation maintainers

---

# Adopt a Monorepo Architecture for the Jua Ecosystem

## Context and Problem Statement

Jua is being developed as a complete programming language ecosystem rather than a standalone compiler. The project includes language specifications, compiler implementations, runtime components, standard libraries, developer tooling, educational materials, examples, documentation, and infrastructure automation.

The project requires a repository structure that supports coordinated evolution of all ecosystem components while remaining maintainable as the number of contributors and subsystems grows over time.

The question addressed by this decision is:

> Should Jua adopt a monorepo architecture or distribute its ecosystem across multiple repositories?

## Decision Drivers

* Long-term maintainability
* Consistent governance across the ecosystem
* Simplified contributor onboarding
* Unified versioning strategy
* Visibility of cross-component changes
* Reduced operational overhead
* Support for future ecosystem expansion

## Considered Options

* Monorepo Architecture
* Multi-Repository Architecture
* Hybrid Repository Architecture

## Decision Outcome

Chosen option: "Monorepo Architecture", because it provides the best balance between maintainability, governance, discoverability, and long-term scalability for a language ecosystem expected to evolve across multiple domains.

A monorepo enables specifications, compiler implementations, tooling, runtime components, and educational resources to evolve together while maintaining clear architectural boundaries within a single repository.

### Consequences

* Good, because all ecosystem components are versioned and reviewed together.
* Good, because contributors can discover the entire project structure from a single repository.
* Good, because architectural decisions can be enforced consistently across the ecosystem.
* Good, because cross-cutting changes become easier to implement and review.
* Good, because CI/CD, security policies, and governance mechanisms are centralized.
* Bad, because repository size will increase over time.
* Bad, because build systems may require additional optimization as the project grows.
* Bad, because stricter architectural discipline is required to avoid coupling between subsystems.

### Confirmation

Compliance with this decision can be confirmed by ensuring:

* All core ecosystem components remain within the monorepo.
* New major subsystems are added as top-level modules rather than independent repositories.
* CI/CD pipelines support selective execution to avoid monorepo performance degradation.
* Architectural reviews verify that subsystem boundaries remain well-defined.

## Pros and Cons of the Options

### Monorepo Architecture

A single repository containing all ecosystem components.

* Good, because it simplifies governance.
* Good, because it enables atomic cross-component changes.
* Good, because it improves discoverability.
* Good, because it centralizes CI/CD and security controls.
* Neutral, because tooling complexity increases as the repository grows.
* Bad, because repository size may become substantial over time.

### Multi-Repository Architecture

Separate repositories for compiler, runtime, tooling, specifications, and education resources.

* Good, because repository boundaries are explicit.
* Good, because teams can operate independently.
* Neutral, because individual repositories remain smaller.
* Bad, because version synchronization becomes difficult.
* Bad, because contributor onboarding becomes fragmented.
* Bad, because architectural governance becomes harder to enforce consistently.

### Hybrid Repository Architecture

A core repository combined with satellite repositories.

* Good, because some components can evolve independently.
* Good, because repository size remains manageable.
* Neutral, because governance responsibilities can be distributed.
* Bad, because architectural boundaries become less obvious.
* Bad, because dependency management becomes more complex.
* Bad, because operational overhead increases significantly.

## More Information

This decision should be revisited only if:

* The repository becomes operationally difficult to manage.
* Independent release cycles become mandatory for major subsystems.
* Organizational requirements introduce repository ownership constraints.

Related ADRs:

* ADR-0007 Language Specification as Source of Truth
* ADR-0008 Layered Compiler Architecture
* ADR-0011 Education as First-Class Concern

