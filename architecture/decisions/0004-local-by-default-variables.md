# ADR-0004 — Local Variables by Default

---

status: accepted
date: 2026-06-02
decision-makers:

* Edmilson Cassecasse

---

# Adopt Local Variables by Default

## Context and Problem Statement

Accidental global state is a common source of bugs and maintenance issues in software systems.

The language requires a predictable and safe variable scoping model that supports both beginners and professional developers.

## Decision Drivers

* Maintainability
* Predictability
* Safety
* Educational value

## Considered Options

* Local variables by default
* Global variables by default
* Mixed implicit model

## Decision Outcome

Chosen option: "Local variables by default", because it minimizes accidental shared state and encourages safer programming practices.

### Consequences

* Good, because unintended side effects become less common.
* Good, because code becomes easier to reason about.
* Good, because modularity is encouraged.
* Bad, because explicit global declarations become necessary when shared state is required.

### Confirmation

The compiler must treat undeclared variables as local unless explicitly marked as global.

## Pros and Cons of the Options

### Local variables by default

* Good, because it reduces bugs.
* Good, because it improves maintainability.
* Good, because it encourages modular design.

### Global variables by default

* Good, because access is simple.
* Bad, because accidental coupling becomes common.
* Bad, because large systems become harder to maintain.

### Mixed implicit model

* Good, because it offers flexibility.
* Bad, because behavior becomes less predictable.

## More Information

Global variables remain available through explicit declaration mechanisms.

