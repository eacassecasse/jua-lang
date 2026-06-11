# Testing

Version: 0.1 Draft

Status: Proposed

---

# Purpose

This document defines the testing model of the Jua programming language.

Testing enables developers to verify correctness, prevent regressions, and document expected behavior.

Jua includes testing as a first-class language capability through the `test` keyword.

---

# Design Philosophy

Jua follows the principle:

> Testing should be simple enough for beginners and powerful enough for production systems.

Tests should:

* Be easy to write
* Be easy to read
* Encourage good development practices
* Integrate naturally with the language

---

# Design Goals

The testing system should:

* Minimize boilerplate
* Support automated execution
* Produce clear diagnostics
* Support CI/CD workflows
* Encourage test-driven development
* Remain beginner-friendly

---

# Core Concept

A test defines expected behavior.

General form:

```jua
test TestName

    assertions

end
```

---

Example

```jua
test Addition

    assert(1 + 1 == 2)

end
```

---

# Test Declaration

Tests are declared using:

```jua
test
```

---

Example

```jua
test UserCreation

end
```

Valid.

---

# Test Naming

Test names should use PascalCase.

Preferred:

```jua
test UserCreation
```

---

Discouraged:

```jua
test usercreation
```

---

# Test Scope

Tests may appear:

```text
At module level
```

only.

---

Valid:

```jua
test Addition

end
```

---

Invalid:

```jua
function calculate()

    test Addition

    end

end
```

Compiler Error:

```text
Tests cannot be declared inside functions.
```

---

# Assertions

Version 0.1 provides:

```text
assert()
```

as the primary assertion mechanism.

---

Example

```jua
test Equality

    assert(10 == 10)

end
```

Passes.

---

Example

```jua
test Equality

    assert(10 == 20)

end
```

Fails.

---

# Assertion Failure

When an assertion evaluates to:

```text
false
```

the test fails.

---

Example Diagnostic

```text
Test Failed: Equality

Expected:
true

Actual:
false
```

---

# Testing Functions

Example:

```jua
function add(a, b)

    return a + b

end
```

---

```jua
test AddNumbers

    assert(add(2, 3) == 5)

end
```

Valid.

---

# Testing Collections

Example:

```jua
test ListEquality

    assert(
        [1, 2, 3]
        ==
        [1, 2, 3]
    )

end
```

Valid.

---

# Testing Objects

Example:

```jua
test StudentEquality

    assert(
        {
            name: "Ana"
        }
        ==
        {
            name: "Ana"
        }
    )

end
```

Valid.

---

# Test Discovery

The compiler and tooling should automatically discover:

```text
test
```

blocks.

No manual registration is required.

---

# Test Execution

A test runner executes tests independently.

Conceptually:

```text
Discover Tests

        ↓

Execute Tests

        ↓

Collect Results

        ↓

Report Results
```

---

# Isolation

Tests should not depend on execution order.

Example:

```text
Test A
```

must not require:

```text
Test B
```

to run first.

---

# Test Results

Each test produces one of:

```text
PASS
FAIL
SKIP (future)
```

Version 0.1 requires:

```text
PASS
FAIL
```

---

# Example Output

```text
PASS Addition
PASS UserCreation
FAIL DivisionByZero

2 Passed
1 Failed
```

---

# Compiler Representation

Tests are represented as dedicated AST nodes.

Conceptually:

```text
Test Declaration

        ↓

AST Test Node

        ↓

Execution Metadata

        ↓

Test Runner
```

---

# Export Rules

Tests are not exported.

Example:

```jua
export test Addition
```

Invalid.

Compiler Error:

```text
Tests cannot be exported.
```

---

# Production Compilation

Compilers may exclude tests from production builds.

Example:

```text
Development Build
    Includes Tests

Production Build
    Excludes Tests
```

---

# Diagnostics

Diagnostics should identify:

* Invalid assertions
* Nested tests
* Duplicate test names
* Invalid test placement

---

Example

```text
Duplicate test:

Addition
```

---

# Educational Guidance

Beginners should be encouraged to write:

```jua
function add(a, b)

    return a + b

end

test AddNumbers

    assert(add(2, 3) == 5)

end
```

immediately after creating functionality.

This reinforces verification habits early.

---

# Future Evolution

Future versions may introduce:

```text
assertEqual()
assertThrows()

Parameterized Tests

Test Suites

Fixtures

Mocking

Coverage Reports

Benchmark Tests

Property-Based Testing
```

All future additions must remain compatible with Version 0.1 test semantics.

---

# Compliance

A conforming implementation must:

```text
Support test declarations
Support assert()
Support automatic discovery
Support pass/fail reporting
```
