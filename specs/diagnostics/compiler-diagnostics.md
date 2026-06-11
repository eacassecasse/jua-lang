# Compiler Diagnostics

Version: 0.1 Draft
Status: Proposed

---

# Purpose

This document defines how the Jua compiler reports errors, warnings, and informational messages.

It standardizes:

* Error format
* Warning format
* Location tracking
* Message structure
* Diagnostic categories
* Severity levels

---

# Design Philosophy

Jua diagnostics follow the principle:

> Errors must be actionable, precise, and human-readable.

The compiler must:

* Clearly identify what went wrong
* Clearly indicate where it happened
* Avoid redundant cascading errors
* Provide deterministic formatting

---

# Diagnostic Types

Jua defines three diagnostic levels:

```text id="d1"
ERROR
WARNING
INFO
```

---

# Severity Rules

## ERROR

* Stops compilation (in 0.1)
* Must be fixed

---

## WARNING

* Compilation continues
* Indicates potential issue

---

## INFO

* Non-critical compiler feedback
* Used for debugging or tooling

---

# Diagnostic Structure

Every diagnostic MUST include:

```text id="s1"
severity
code
message
location (file, line, column)
context (optional)
```

---

# Standard Format

All diagnostics MUST follow this format:

```text id="f1"
[SEVERITY] CODE: message
  at file.jua:line:column
  context: optional detail
```

---

# Example Error

```text id="e1"
[ERROR] UNDEFINED_SYMBOL: Undefined symbol 'x'
  at main.jua:3:5
```

---

# Example Warning

```text id="e2"
[WARNING] UNUSED_VARIABLE: Variable 'x' is never used
  at main.jua:2:9
```

---

# Example Info

```text id="e3"
[INFO] TYPE_INFERRED: Inferred type 'integer'
  at main.jua:1:7
```

---

# Location Tracking

Each AST node MUST carry:

```text id="l1"
line number
column number
(optional) file identifier
```

This enables precise diagnostics.

---

# Error Codes

All errors MUST include a stable code.

## Examples:

```text id="c1"
UNDEFINED_SYMBOL
TYPE_MISMATCH
INVALID_ASSIGNMENT
IMMUTABLE_REASSIGNMENT
SYNTAX_ERROR
MISSING_RETURN
INVALID_FUNCTION_CALL
```

---

# Error Categorization

## Syntax Errors

Generated during parsing.

Examples:

* Missing `end`
* Invalid token sequence
* Malformed expressions

---

## Semantic Errors

Generated during semantic analysis.

Examples:

* Undefined variable
* Type mismatch
* Mutability violation

---

## Runtime Errors (future)

Not part of 0.1 compiler phase.

---

# Cascading Error Control

The compiler MUST:

> Avoid reporting follow-up errors caused by a single root issue.

Example:

```jua id="x1"
create x = 10
print(y)
print(z)
```

Preferred output:

```text id="o1"
[ERROR] UNDEFINED_SYMBOL: 'y'
```

NOT:

```text id="bad1"
[ERROR] UNDEFINED_SYMBOL: 'y'
[ERROR] UNDEFINED_SYMBOL: 'z'
```

unless independent validation confirms both.

---

# Error Recovery Strategy

In 0.1:

```text id="r1"
Compilation stops on first fatal semantic error
```

Parser may attempt basic recovery to continue parsing.

---

# Warning Rules

Warnings are emitted for:

* Unused variables (future pass)
* Suspicious constructs (future)
* Deprecated features (future)

Not required for initial implementation but structure is defined.

---

# Diagnostic Emission API (Compiler Side)

Compiler MUST expose:

```text id="api1"
reportError(code, message, location)
reportWarning(code, message, location)
reportInfo(code, message, location)
```

---

# Integration Points

Diagnostics are used in:

```text id="i1"
Lexer → lexical errors
Parser → syntax errors
Semantic Analyzer → semantic errors
Type Checker → type errors
Mutability Checker → state errors
```

---

# Example Full Compilation Failure

Input:

```jua id="ex1"
create x = 10
print(y)
```

Output:

```text id="out1"
[ERROR] UNDEFINED_SYMBOL: Undefined symbol 'y'
  at main.jua:2:7
```

---

# Success Case Output

```text id="ok1"
Compilation succeeded with no errors.
```

---

# Diagnostic Stability Rules

* Error codes MUST NOT change between minor versions
* Message text MAY improve
* Location format MUST remain stable

---

# Non-Goals

This document does NOT define:

* Fix suggestions (future feature)
* IDE integration
* LSP protocol
* Runtime stack traces
* Optimization hints

---

# Compliance

A conforming Jua compiler MUST:

* Emit structured diagnostics
* Provide accurate locations
* Use stable error codes
* Respect severity levels
* Avoid cascading errors
* Stop compilation on fatal errors (0.1)
