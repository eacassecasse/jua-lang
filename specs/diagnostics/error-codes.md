# Error Codes

## Purpose

This document defines the diagnostic code system used by the Jua compiler.

Diagnostic codes provide a stable identifier for compiler diagnostics independent of message wording.

The goals are:

* Consistent error reporting.
* Easier debugging.
* IDE integration.
* Documentation references.
* Future localization support.

---

# Diagnostic Structure

Every diagnostic consists of:

```text
Code
Severity
Message
Source Location
```

Example:

```text
JUA2001 Error

Undefined symbol: age

--> main.jua:10:5
```

---

# Severity Levels

Jua defines the following diagnostic severities:

| Severity    | Description                                  |
| ----------- | -------------------------------------------- |
| Error       | Compilation cannot continue successfully     |
| Warning     | Suspicious code but compilation may continue |
| Information | Informational diagnostic                     |
| Hint        | Suggestion for improvement                   |

---

# Code Ranges

Diagnostic codes are grouped by subsystem.

| Range   | Category              |
| ------- | --------------------- |
| JUA1xxx | Lexical Analysis      |
| JUA2xxx | Syntax Analysis       |
| JUA3xxx | Name Resolution       |
| JUA4xxx | Type Checking         |
| JUA5xxx | Module Resolution     |
| JUA6xxx | Visibility and Access |
| JUA7xxx | Mutability            |
| JUA8xxx | Runtime Preparation   |
| JUA9xxx | Reserved              |

---

# Lexical Diagnostics

## JUA1001

Invalid character.

Example:

```text
Unexpected character.
```

---

## JUA1002

Unterminated string literal.

---

## JUA1003

Malformed numeric literal.

---

# Syntax Diagnostics

## JUA2001

Unexpected token.

---

## JUA2002

Expected expression.

---

## JUA2003

Expected end.

---

# Name Resolution Diagnostics

## JUA3001

Undefined symbol.

Example:

```jua
print(age)
```

when:

```jua
create age
```

does not exist.

---

## JUA3002

Duplicate symbol declaration.

---

## JUA3003

Invalid shadowing.

Reserved for future use.

---

# Type Diagnostics

## JUA4001

Type mismatch.

---

## JUA4002

Invalid assignment.

---

## JUA4003

Invalid argument type.

---

## JUA4004

Invalid return type.

---

# Module Diagnostics

## JUA5001

Module not found.

---

## JUA5002

Circular import detected.

Reserved for future use.

---

## JUA5003

Imported symbol not exported.

---

# Visibility Diagnostics

## JUA6001

Symbol not visible.

---

# Mutability Diagnostics

## JUA7001

Cannot reassign immutable variable.

---

## JUA7002

Invalid mutable declaration.

Reserved for future use.

---

# Stability Rules

Once a diagnostic code is released, its meaning must not change.

Messages may evolve.

Diagnostic codes must remain stable across compiler versions.

---

# Related Specifications

* specs/diagnostics/
* specs/semantics/scope-resolution.md
* specs/semantics/type-checking.md
* specs/modules/modules.md

