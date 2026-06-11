---

status: accepted
date: 2026-06-10
decision-makers:

* Edmilson Cassecasse

---

# ADR-0017: Closure Deferral

## Context and Problem Statement

Closures are a common feature in modern programming languages. A closure is a function that captures variables from an enclosing scope and retains access to those variables after the enclosing scope has finished execution.

Examples of closure support can be found in languages such as JavaScript, Python, Rust, Kotlin, and Swift.

A typical closure example looks conceptually as follows:

```text
function outer()
    create count = 0

    function inner()
        count = count + 1
        return count
    end

    return inner
end
```

In this example, the inner function captures and retains access to the variable `count`, even after the execution of `outer()` has completed.

During the design of Jua 0.1, the language team needed to determine whether closure support should be included in the first version of the language.

While closures provide expressive power and enable functional programming patterns, they also introduce significant complexity into multiple parts of the compiler and runtime architecture.

The question to be resolved was:

> Should Jua 0.1 support closures and variable capture, or should closure support be deferred to a future version?

## Decision Drivers

* Keep the first compiler implementation achievable.
* Minimize semantic analysis complexity.
* Simplify scope resolution.
* Reduce runtime implementation requirements.
* Preserve predictable variable lifetime semantics.
* Maintain focus on core language functionality.
* Allow future language evolution without introducing breaking changes.

## Considered Options

* Support full closures.
* Support read-only closures.
* Support explicit capture lists.
* Defer closure support from Jua 0.1.

## Decision Outcome

Chosen option:

**"Defer closure support from Jua 0.1"**, because it best satisfies the goals of implementation simplicity, predictable semantics, and delivery of a stable first compiler while preserving the possibility of introducing closures in future versions.

### Consequences

* Good, because scope resolution remains significantly simpler.
* Good, because variable lifetime analysis remains straightforward.
* Good, because runtime environment objects are not required.
* Good, because semantic analysis can focus on local, module, and global scopes.
* Good, because the first compiler implementation remains more manageable.
* Good, because future closure support can be introduced through a dedicated ADR.
* Bad, because some functional programming patterns cannot be expressed.
* Bad, because higher-order stateful functions are not supported.
* Bad, because some developers may expect closure support based on experience with other languages.

### Confirmation

The decision is confirmed when:

* Functions are unable to access variables from enclosing function scopes.
* The language specification explicitly states that closures are not part of Jua 0.1.
* The semantic analyzer rejects attempts to capture variables from outer scopes.
* Compiler tests verify that only local, module-level, and global symbols may be referenced according to the language visibility rules.

## Pros and Cons of the Options

### Support Full Closures

Example:

```text
function outer()
    create value = 10

    function inner()
        return value
    end

    return inner
end
```

* Good, because it enables functional programming patterns.
* Good, because it allows higher-order functions to maintain state.
* Good, because it is a familiar feature in many modern languages.
* Good, because it increases language expressiveness.
* Neutral, because developers experienced with closures already understand the model.
* Bad, because it requires capture analysis.
* Bad, because it requires closure environment generation.
* Bad, because it complicates variable lifetime management.
* Bad, because it increases compiler and runtime complexity.

### Support Read-Only Closures

Example:

```text
function outer()
    create value = 10

    function inner()
        return value
    end
end
```

where captured variables cannot be modified.

* Good, because it is simpler than full mutable closures.
* Good, because it supports some functional programming patterns.
* Neutral, because it provides limited closure capabilities.
* Bad, because environment generation is still required.
* Bad, because capture analysis is still required.
* Bad, because it introduces additional semantic rules.

### Support Explicit Capture Lists

Example:

```text
function inner() capture(value)
```

* Good, because captured variables are explicit.
* Good, because the code is self-documenting.
* Good, because the compiler can clearly identify captured symbols.
* Neutral, because some languages successfully use explicit capture models.
* Bad, because it introduces additional syntax.
* Bad, because runtime capture infrastructure is still required.
* Bad, because it increases language complexity.

### Defer Closure Support from Jua 0.1

* Good, because scope management remains simple.
* Good, because semantic analysis remains easier to implement.
* Good, because runtime complexity is reduced.
* Good, because compiler development can focus on core language functionality.
* Good, because future closure support remains possible.
* Neutral, because equivalent behavior can sometimes be achieved through objects and module-level state.
* Bad, because some programming patterns become more verbose.
* Bad, because closure-based APIs cannot be implemented.

## More Information

Under this decision, functions in Jua 0.1 may access:

* Their parameters.
* Their local variables.
* Symbols visible through module imports.
* Global symbols.
* Object members through `self`.

Functions may not access variables declared inside enclosing functions.

For example, the following construct is invalid:

```text
function outer()

    create value = 10

    function inner()
        print(value)
    end

end
```

because `value` belongs to the scope of `outer()`.

This decision aligns with the overall objective of delivering a stable and understandable first version of the language before introducing more advanced semantic features.

Closure support may be reconsidered in future versions if one or more of the following conditions occur:

* Higher-order functions become a major use case.
* Lambda expressions are introduced.
* Functional programming support becomes a project goal.
* Runtime infrastructure evolves to support captured environments efficiently.

Any future closure implementation should be introduced through a dedicated ADR that specifies:

* Capture semantics.
* Variable lifetime rules.
* Mutable versus immutable captures.
* Runtime representation.
* Interaction with modules and objects.

Related ADRs:

* ADR-0008: Layered Compiler Architecture
* ADR-0014: Immutable by Default Variables
* ADR-0015: Repeat Loop Deferral
* ADR-0016: Value-Based Equality

Related Specifications:

* specs/functions/functions.md
* specs/semantics/scope-resolution.md
* specs/semantics/type-checking.md
* specs/memory-model/variable-lifetime.md

