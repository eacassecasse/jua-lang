# ADR-0002 — WASM First Target

---

status: accepted
date: 2026-06-01
decision-makers:

* Edmilson Cassecasse

consulted:

* WebAssembly ecosystem
* Modern language platform practices

informed:

* Future compiler contributors
* Runtime maintainers
* Toolchain maintainers

---

# Adopt WebAssembly as the Primary Compilation Target

## Context and Problem Statement

Jua aims to be accessible to students, educational institutions, and professional developers while maintaining low resource consumption and broad platform compatibility.

The project requires an initial execution target that enables browser execution, simplified deployment, platform independence, and long-term scalability.

The question addressed by this decision is:

> Which execution target should be prioritized during the initial development of Jua?

## Decision Drivers

* Browser-first execution
* Cross-platform compatibility
* Low deployment complexity
* Educational accessibility
* Security through sandboxed execution
* Future scalability

## Considered Options

* WebAssembly (WASM)
* JVM
* Native Machine Code
* Custom Bytecode VM

## Decision Outcome

Chosen option: "WebAssembly (WASM)", because it best aligns with Jua's browser-first vision and educational goals while providing a modern, portable execution environment.

### Consequences

* Good, because Jua programs can run directly in modern browsers.
* Good, because deployment becomes platform independent.
* Good, because WebAssembly provides sandboxed execution.
* Good, because cloud and edge environments increasingly support WebAssembly.
* Bad, because direct operating system integration is more limited.
* Bad, because some low-level optimizations may be constrained by the target platform.

### Confirmation

Compliance is confirmed by ensuring that the primary compiler pipeline produces WebAssembly artifacts and that new language features remain compatible with WebAssembly execution requirements.

## Pros and Cons of the Options

### WebAssembly (WASM)

* Good, because it enables browser execution.
* Good, because it is cross-platform.
* Good, because it supports sandboxed execution.
* Bad, because direct platform integration is limited.

### JVM

* Good, because it has a mature ecosystem.
* Good, because it is widely used in enterprises.
* Bad, because it does not satisfy the browser-first objective.

### Native Machine Code

* Good, because it provides maximum performance.
* Good, because it enables low-level system access.
* Bad, because portability becomes more complex.

### Custom Bytecode VM

* Good, because it provides complete control over execution.
* Good, because it can be optimized specifically for Jua.
* Bad, because it significantly increases implementation complexity.

## More Information

Future JVM and native backends remain valid goals. This decision only establishes the primary implementation target for the initial versions of Jua.

