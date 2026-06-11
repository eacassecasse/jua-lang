---

status: accepted
date: 2026-06-10
decision-makers:

* Edmilson Cassecasse

---

# ADR-0016: Value-Based Equality

## Context and Problem Statement

Comparison operations are fundamental to program correctness and developer expectations. During the design of Jua 0.1, a decision was required regarding how equality should be represented and interpreted within the language.

Many programming languages distinguish between value equality and reference identity. For example, some languages use one operator to determine whether two values are equivalent and another operator to determine whether two references point to the same underlying object.

Several alternatives were considered, including symbolic operators and keyword-based approaches.

Examples discussed included:

```jua id="q2a8dr"
a == b
```

```jua id="z8k9fy"
a equals b
```

```jua id="w7v1ep"
a is b
```

The design team needed to determine whether Jua 0.1 should distinguish between value equality and identity equality, and if so, how that distinction should be represented.

The question to be resolved was:

> Should Jua 0.1 support both value equality and identity equality, or should it adopt a simpler equality model?

## Decision Drivers

* Maintain a simple and teachable language.
* Reduce cognitive overhead for new programmers.
* Avoid introducing runtime identity semantics prematurely.
* Keep semantic analysis straightforward.
* Ensure predictable behavior across primitive and object types.
* Preserve future extensibility.

## Considered Options

* Support both value equality and identity equality.
* Use keyword-based equality operators.
* Use value-based equality only.
* Defer equality semantics until a later version.

## Decision Outcome

Chosen option:

**"Use value-based equality only"**, because it provides the simplest and most predictable behavior for Jua 0.1 while avoiding the additional complexity required to support object identity semantics.

### Consequences

* Good, because equality semantics remain easy to understand.
* Good, because the compiler only needs to implement a single equality model.
* Good, because the language remains approachable for beginners.
* Good, because common comparison use cases are fully supported.
* Good, because future identity operators can still be introduced without changing existing equality behavior.
* Bad, because object identity cannot be explicitly compared in Jua 0.1.
* Bad, because some advanced programming patterns may require future language extensions.

### Confirmation

The decision is confirmed when:

* The language specification defines `==` as value equality.
* No identity comparison operator exists in the Jua 0.1 grammar.
* Semantic analysis applies the same equality semantics consistently across all supported types.
* Compiler tests verify equality behavior for integers, floating-point values, strings, booleans, lists, and objects.

## Pros and Cons of the Options

### Support Both Value Equality and Identity Equality

Example:

```jua id="d4e9mx"
a == b
```

for value equality and:

```jua id="p3t8wv"
a is b
```

for identity equality.

* Good, because it provides maximum flexibility.
* Good, because it supports advanced object-oriented scenarios.
* Good, because it aligns with the capabilities of many mature languages.
* Neutral, because experienced developers are generally familiar with the distinction.
* Bad, because it introduces additional concepts for beginners.
* Bad, because it requires defining object identity semantics.
* Bad, because it increases compiler and runtime complexity.

### Use Keyword-Based Equality Operators

Example:

```jua id="m5s2kh"
a equals b
```

* Good, because the intent is explicit.
* Good, because the syntax reads naturally.
* Neutral, because it resembles natural language.
* Bad, because it deviates from common programming language conventions.
* Bad, because it introduces additional grammar constructs.
* Bad, because developers familiar with symbolic operators may find it less intuitive.

### Use Value-Based Equality Only

Example:

```jua id="r8n3jc"
score == 100
```

```jua id="k4u1yd"
name == "Jua"
```

* Good, because it is simple and predictable.
* Good, because it aligns with the most common comparison use cases.
* Good, because it minimizes implementation complexity.
* Good, because it provides a consistent mental model.
* Neutral, because identity comparisons are not available.
* Bad, because advanced identity-based comparisons cannot be expressed.

### Defer Equality Semantics Until a Later Version

* Good, because additional time could be spent evaluating alternatives.
* Neutral, because implementation work would be postponed.
* Bad, because equality is a foundational language feature.
* Bad, because compiler implementation cannot proceed without a defined equality model.
* Bad, because language users require predictable comparison behavior.

## More Information

Under this decision, the equality operator:

```jua id="h7f5rp"
==
```

represents value equality for all supported Jua 0.1 types.

Assignment remains represented by:

```jua id="g2w8nf"
=
```

Identity comparison is intentionally excluded from Jua 0.1.

Future versions of Jua may introduce a dedicated identity comparison mechanism if one or more of the following conditions occur:

* Object identity becomes a common requirement.
* Reference semantics are expanded.
* Additional object-oriented capabilities are introduced.
* Runtime architecture evolves to expose identity semantics.

Possible future alternatives include:

```jua id="n6y4tk"
is
```

```jua id="v1q9be"
equals
```

or another dedicated identity operator.

Related ADRs:

* ADR-0014: Immutable by Default Variables
* ADR-0015: Repeat Loop Deferral

Related Specifications:

* specs/semantics/type-checking.md
* specs/grammar/expressions.md
* specs/type-system/type-system.md

