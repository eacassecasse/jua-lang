# Repeat Loops

Version: 0.1 Draft

Status: Deferred

---

# Purpose

This document describes the planned repeat loop construct for the Jua programming language.

The language intends to support a repeat construct as part of its control-flow system. However, the exact syntax and execution semantics have not yet been finalized.

This specification records the current design direction, candidate approaches, and unresolved questions.

---

# Design Philosophy

Jua follows the principle:

> Language constructs should exist because they provide meaningful value, not because they exist in other languages.

The repeat construct should introduce behavior that is useful, easy to understand, and distinct from existing control-flow mechanisms.

---

# Current Status

The repeat construct is currently under evaluation.

The language design team has not yet selected a final syntax or semantic model.

As a result:

```text
repeat is part of the roadmap

repeat is not part of the finalized Version 0.1 specification

repeat syntax may change

repeat semantics may change
```

Compiler implementations should not consider repeat a required feature until a final specification is approved.

---

# Design Goals

The repeat construct should:

* Be easy to teach
* Be beginner-friendly
* Improve readability
* Avoid unnecessary duplication with existing loop constructs
* Support common user-interaction workflows
* Support validation and retry patterns
* Remain simple to implement
* Remain easy to analyze statically

---

# Relationship with Existing Loops

Jua already provides:

```text
while
    condition-controlled iteration

for
    range-based and collection-based iteration
```

The repeat construct must provide value beyond these existing mechanisms.

---

# Candidate A — Post-Condition Loop

Syntax:

```jua
repeat

    statements

until condition
```

Example:

```jua
create mutable answer = ""

repeat

    answer = read()

until answer != ""
```

---

## Semantics

Execution model:

```text
Execute body

Evaluate condition

If condition is false
    repeat

If condition is true
    stop
```

---

## Characteristics

* Executes at least once.
* Traditional repeat-until behavior.
* Familiar to Pascal and Ada developers.
* Easily lowered into while loops during compilation.
* Useful for input-validation workflows.

---

## Possible Lowering

Example:

```jua
repeat

    body

until condition
```

may be lowered into:

```jua
while true

    body

    if condition

        break

    end

end
```

---

## Advantages

* Introduces behavior not provided by while.
* Natural for retry workflows.
* Well-established language design pattern.
* Easy to explain once semantics are understood.

---

## Disadvantages

* Condition appears after the body.
* Less common in modern mainstream languages.
* Requires understanding of post-condition execution.

---

# Candidate B — Pre-Condition Repeat

Syntax:

```jua
repeat until condition

    statements

end
```

Example:

```jua
create mutable answer = ""

repeat until answer != ""

    answer = read()

end
```

---

## Semantics

Execution model:

```text
Evaluate condition

If true
    stop

If false
    execute body

Repeat
```

---

## Characteristics

* Reads similarly to natural language.
* Does not guarantee first execution.
* Behaves similarly to a while-not loop.

---

## Possible Lowering

Example:

```jua
repeat until condition

    body

end
```

may be lowered into:

```jua
while NOT condition

    body

end
```

---

## Advantages

* Highly readable.
* Consistent with English phrasing.
* Easy for beginners to understand.

---

## Disadvantages

* Does not introduce fundamentally new behavior.
* Semantically similar to while.
* May duplicate existing language capabilities.
* Could create confusion for developers familiar with traditional repeat-until loops.

---

# Candidate C — Retry-Oriented Repeat

Under this model, repeat is designed primarily for workflows involving:

* User input
* Validation
* Retries
* Waiting for conditions

Example:

```jua
repeat

    password = read()

until password != ""
```

---

## Characteristics

The construct would still resemble Candidate A or Candidate B syntactically, but the language documentation would emphasize interaction-driven repetition rather than general looping.

---

## Advantages

* Matches common beginner programming exercises.
* Useful for command-line applications.
* Aligns with educational use cases.

---

## Disadvantages

* May be too specialized.
* Risks overlapping with existing loop constructs.

---

# Unresolved Questions

The following questions remain open:

## Syntax

Should repeat use:

```jua
repeat

    ...

until condition
```

or:

```jua
repeat until condition

    ...

end
```

---

## Execution Timing

Should the condition be evaluated:

```text
Before execution
```

or:

```text
After execution
```

---

## First Execution Guarantee

Should repeat guarantee at least one execution?

---

## Compiler Representation

Should repeat be:

```text
A distinct AST node
```

or:

```text
A syntactic transformation into while
```

during parsing?

---

## Educational Positioning

Should repeat be presented as:

```text
A general-purpose loop
```

or:

```text
A validation and retry loop
```

within educational materials?

---

# Decision Criteria

A final decision should be evaluated against:

* Readability
* Educational accessibility
* Language consistency
* Implementation complexity
* Semantic uniqueness
* Compiler simplicity
* Long-term maintainability

---

# Future Review

This specification should be revisited before:

```text
Language Version 0.1 Freeze
```

or before implementation of parser support for repeat begins.

At that time a formal ADR should be created documenting the chosen design and rationale.

---

# Related Specifications

```text
specs/control-flow/if.md

specs/control-flow/while.md

specs/control-flow/for.md

specs/functions/functions.md
```

---

# Compliance

This specification is informational only.

No conforming Jua implementation is currently required to support repeat loops.
