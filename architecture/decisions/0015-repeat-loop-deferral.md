---

status: accepted
date: 2026-06-10

Decision-makers:
* Edmilson Cassecasse
  
Consulted:
* ChatGPT
  
Informed:
* Future Jua contributors

---

# ADR-0015: Repeat Loop Deferral

## Context and Problem Statement

During the design of Jua 0.1, the need for an additional repetition construct emerged. The primary motivation was to support scenarios where developers think in terms of repeated execution rather than iteration over a range or evaluation of a loop condition.

Examples discussed included:

```jua
repeat
    statements
until condition
```

and

```jua
repeat until condition
    statements
end
```

The motivation originated from use cases such as command-line applications, interactive programs, and long-running processes that repeatedly execute a block of code until a termination condition is met.

The question to be resolved was:

> Should Jua 0.1 include a dedicated repeat loop construct, and if so, which semantics and syntax should be adopted?

At the time of evaluation, Jua already provided two looping mechanisms:

```jua
while condition
    statements
end
```

and

```jua
for i from start to end
    statements
end
```

The design team needed to determine whether a third looping construct would provide sufficient value to justify its addition.

## Decision Drivers

* Maintain a small and teachable language surface for Jua 0.1.
* Avoid introducing partially specified language constructs.
* Reduce compiler implementation complexity.
* Preserve language consistency.
* Allow future evolution without introducing breaking changes.
* Ensure that every language construct has a clearly defined semantic purpose.

## Considered Options

* Introduce a post-condition repeat loop.
* Introduce a pre-condition repeat loop.
* Introduce a generic infinite loop construct.
* Defer repeat loops from Jua 0.1.

## Decision Outcome

Chosen option:

**"Defer repeat loops from Jua 0.1"**, because it best satisfies the goals of language simplicity, implementation feasibility, and semantic clarity while preserving the ability to introduce a repeat construct in a future version once stronger use cases and semantics have been identified.

### Consequences

* Good, because the language grammar remains simpler.
* Good, because semantic analysis remains less complex.
* Good, because compiler implementation effort is reduced.
* Good, because existing `while` and `for` constructs already cover the required repetition use cases.
* Good, because future versions retain flexibility to introduce a repeat construct without having to maintain an immature design.
* Bad, because some programs may express their intent less naturally when implemented using `while`.
* Bad, because developers familiar with languages such as Pascal may expect a repeat-until construct.

### Confirmation

The decision is confirmed when:

* The Jua 0.1 grammar contains no repeat-loop production.
* The parser rejects any use of a `repeat` construct.
* The language specification explicitly lists repeat loops as deferred functionality.
* All looping behavior in Jua 0.1 is expressed using `while` and `for`.

Compiler tests should verify that unsupported repeat syntax results in appropriate diagnostics.

## Pros and Cons of the Options

### Introduce a Post-Condition Repeat Loop

Example:

```jua
repeat
    statements
until condition
```

* Good, because the body is guaranteed to execute at least once.
* Good, because the construct is familiar to users of Pascal-like languages.
* Good, because it provides semantics distinct from `while`.
* Neutral, because the syntax is relatively easy to parse.
* Bad, because it introduces additional control-flow semantics.
* Bad, because it requires specification of condition evaluation timing.
* Bad, because it increases implementation effort for Jua 0.1.

### Introduce a Pre-Condition Repeat Loop

Example:

```jua
repeat until condition
    statements
end
```

* Good, because it aligns with Jua's block-oriented syntax.
* Good, because it is straightforward to parse.
* Neutral, because it reads naturally in English.
* Bad, because it is semantically very similar to `while`.
* Bad, because it adds language surface area without introducing significant expressive power.
* Bad, because it increases documentation and maintenance requirements.

### Introduce a Generic Infinite Loop Construct

Example:

```jua
loop
    statements
end
```

* Good, because the semantics are simple.
* Good, because it can support event loops and long-running processes.
* Neutral, because it resembles constructs found in several modern languages.
* Bad, because it requires future specification of `break` semantics.
* Bad, because accidental infinite loops become easier to write.
* Bad, because the use cases can already be represented using `while`.

### Defer Repeat Loops from Jua 0.1

* Good, because the language remains focused and compact.
* Good, because compiler implementation effort is reduced.
* Good, because semantic ambiguity is avoided.
* Good, because future design work can be informed by real-world experience using Jua.
* Neutral, because developers can still express all required looping behavior using existing constructs.
* Bad, because the language lacks a dedicated repetition construct beyond `while` and `for`.

## More Information

This decision does not permanently reject repeat loops.

Future versions of Jua may introduce a dedicated repetition construct if one or more of the following conditions occur:

* Significant demand emerges from language users.
* A use case cannot be naturally represented using existing constructs.
* A repeat construct can be shown to provide semantics that are clearly distinct from `while`.
* Additional control-flow features such as `break`, `continue`, or concurrency mechanisms require revisiting loop design.

Related ADRs:

* ADR-0006: Control Flow Constructs
* ADR-0014: Immutable by Default Variables

Related Specifications:

* specs/control-flow/loops.md
* specs/grammar/statements.md
* specs/versioning/jua-0.1-language-spec.md

