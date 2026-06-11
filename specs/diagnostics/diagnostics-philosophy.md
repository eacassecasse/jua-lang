# Diagnostics Philosophy

Version: 0.1 Draft

---

# Purpose

This document defines the philosophy, principles, and requirements governing diagnostics produced by Jua implementations.

Diagnostics include:

* Errors
* Warnings
* Notes
* Suggestions

The objective of diagnostics is not merely to report failures but to help developers understand, correct, and learn from them.

---

# Design Philosophy

Jua adopts the following principle:

> Diagnostics should teach before they criticize.

Compiler messages should explain what happened, why it happened, and how it can be corrected whenever possible.

---

# Educational Objective

A compiler diagnostic may be the first interaction a new developer has with the language.

Diagnostic quality directly influences:

* Learning speed
* User confidence
* Productivity
* Developer experience

---

# Diagnostic Categories

Version 0.1 defines four diagnostic categories.

```text
Error
Warning
Note
Suggestion
```

---

# Errors

Errors represent violations that prevent successful compilation or execution.

Examples:

* Syntax violations
* Type mismatches
* Visibility violations
* Module resolution failures

Errors terminate the affected compilation phase.

---

# Warnings

Warnings identify potentially incorrect or unsafe code.

Compilation may continue.

Examples:

* Unused variables
* Unused imports
* Unreachable code

---

# Notes

Notes provide additional contextual information.

Notes do not represent failures.

Example:

```text
Error:
Unknown symbol 'User'.

Note:
Did you mean 'Users'?
```

---

# Suggestions

Suggestions provide actionable guidance.

Example:

```text
Expected '==' for comparison.

Suggestion:
Replace '=' with '=='.
```

---

# Diagnostic Structure

Diagnostics should contain:

```text
Severity
Location
Description
Explanation
Suggestion
```

whenever applicable.

---

# Example Structure

Example:

```text
Error

Line 12, Column 8

Expected ')'.

Explanation:
A function call was started but not closed.

Suggestion:
Add ')' before the end of the statement.
```

---

# Source Location Reporting

Diagnostics should identify:

* File
* Line
* Column

Example:

```text
src/auth/login.jua

Line 22
Column 15
```

---

# Highlighted Source Context

Implementations should display relevant source context.

Example:

```text
Line 10

create result = add(10, 20

                         ^

Expected ')'
```

---

# Precision Requirement

Diagnostics should identify the smallest relevant source location whenever possible.

Preferred:

```text
Line 15, Column 12
```

Less desirable:

```text
Line 15
```

---

# Actionability Requirement

Diagnostics should explain how to resolve the problem.

Bad:

```text
Unexpected token.
```

Better:

```text
Expected ')' to close function call.

Suggestion:
Add ')' after the final argument.
```

---

# Beginner-Friendly Language

Diagnostic wording should prioritize clarity over compiler terminology.

Avoid:

```text
Failed AST construction.
```

Prefer:

```text
The expression could not be understood because a closing ')' is missing.
```

---

# Consistency Requirement

Equivalent errors should produce equivalent diagnostics.

Developers should not receive different messages for identical mistakes.

---

# Multi-Diagnostic Reporting

Implementations should continue analysis when safe to do so.

Example:

```text
Missing ')'
Unknown variable
Missing 'end'
```

All may be reported during a single compilation.

---

# Error Recovery

Compilers should attempt error recovery when possible.

Recovery enables:

* Additional diagnostics
* Better IDE support
* Improved learning experience

---

# Diagnostic Ordering

Diagnostics should be reported in source order.

Example:

```text
Line 10
Line 15
Line 18
```

rather than internal compiler order.

---

# Naming Conventions

Diagnostic messages should:

* Use complete sentences.
* Use consistent terminology.
* Avoid abbreviations.

---

# Internal Terminology

Compiler implementation details should remain hidden whenever possible.

Avoid:

```text
HIR construction failed.
```

Prefer:

```text
The compiler could not determine the type of this expression.
```

---

# Type Diagnostics

Type errors should include:

* Expected type
* Received type

Example:

```text
Expected:

int

Received:

string
```

---

# Import Diagnostics

Import failures should explain:

* Requested module
* Resolution attempt
* Possible correction

Example:

```text
Module not found:

users.authentication

Did you mean:

users.auth
```

---

# Visibility Diagnostics

Visibility errors should explain:

* Symbol name
* Module name
* Visibility restriction

Example:

```text
Cannot access 'hashPassword'.

Reason:
The symbol is private to module 'users.auth'.
```

---

# Interface Diagnostics

Interface violations should identify missing members.

Example:

```text
Missing property:

email

Required by interface:

User
```

---

# Trait Diagnostics

Trait violations should identify missing behavior.

Example:

```text
Trait implementation incomplete.

Missing method:

print()
```

---

# Warning Philosophy

Warnings should indicate probable problems.

Warnings should not be used for stylistic preferences.

Style concerns belong to:

```text
Formatter
Linter
```

rather than the compiler.

---

# Suggestion Philosophy

Suggestions should never change program meaning.

Suggestions should only propose highly probable corrections.

---

# Future Tooling Integration

Diagnostics should support:

* IDE integration
* Language server protocols
* Machine-readable formats
* Automated code actions

---

# Stability Requirement

Diagnostic identifiers may evolve.

Diagnostic meaning should remain stable whenever possible.

---

# Compliance

A conforming implementation must follow the diagnostic principles described in this document.
