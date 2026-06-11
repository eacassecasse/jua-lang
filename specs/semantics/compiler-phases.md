# Compiler Phases

## Purpose

This document defines the compilation pipeline used by the Jua compiler.

The purpose of the compilation pipeline is to transform Jua source code into an executable representation while maintaining a clear separation of responsibilities between compiler stages.

This specification complements:

* ADR-0008: Layered Compiler Architecture
* ADR-0010: Tool-Agnostic Frontend Architecture
* ADR-0021: Module Visibility Model
* ADR-0022: Import Resolution Strategy
* ADR-0023: Standard Library Injection

---

# Design Principles

The Jua compiler follows the following principles:

* Each compiler phase has a single responsibility.
* Compiler phases communicate through well-defined artifacts.
* Semantic decisions are not performed during parsing.
* Module resolution belongs to semantic analysis.
* Built-in symbol injection is compiler-managed.
* Diagnostics should be generated as early as possible without violating phase responsibilities.

---

# Compilation Pipeline

The Jua compiler consists of the following phases:

```text
Source Code
    │
    ▼
Lexical Analysis
    │
    ▼
Parsing
    │
    ▼
Abstract Syntax Tree (AST)
    │
    ▼
Semantic Analysis
    │
    ▼
Validated Program Model
    │
    ▼
Intermediate Representation (Future)
    │
    ▼
Backend Generation
```

For Jua 0.1, frontend phases are the primary focus.

---

# Phase 1: Lexical Analysis

## Responsibility

Convert source code into a stream of tokens.

Input:

```text
Source code
```

Output:

```text
Token stream
```

Example:

Source:

```jua
create age = 20
```

Tokens:

```text
CREATE
IDENTIFIER(age)
ASSIGN
INTEGER_LITERAL(20)
NEWLINE
EOF
```

---

## Responsibilities

The lexer is responsible for:

* Reading source text.
* Identifying tokens.
* Ignoring whitespace where appropriate.
* Processing comments.
* Tracking source locations.
* Emitting diagnostics for invalid lexical constructs.

---

## Non-Responsibilities

The lexer must not:

* Build AST nodes.
* Resolve symbols.
* Resolve imports.
* Perform type checking.
* Evaluate expressions.

---

# Phase 2: Parsing

## Responsibility

Transform tokens into an Abstract Syntax Tree.

Input:

```text
Token stream
```

Output:

```text
AST
```

Example:

Source:

```jua
create age = 20
```

AST:

```text
VariableDeclaration
 ├── name: age
 └── value: IntegerLiteral(20)
```

---

## Responsibilities

The parser is responsible for:

* Syntax validation.
* AST construction.
* Operator precedence handling.
* Grammar enforcement.

---

## Non-Responsibilities

The parser must not:

* Resolve imports.
* Resolve symbols.
* Perform type checking.
* Verify visibility.
* Validate module relationships.

---

# Phase 3: Semantic Analysis

## Responsibility

Assign meaning to the AST and validate program correctness.

Input:

```text
AST
```

Output:

```text
Validated Program Model
```

---

## Responsibilities

Semantic analysis is responsible for:

### Scope Resolution

Resolve identifiers according to lexical scoping rules.

Scope hierarchy:

```text
Global Scope
│
├── Module Scope
│   │
│   ├── Function Scope
│   │   │
│   │   └── Block Scope
│   │
│   ├── Object Scope
│   │
│   ├── Trait Scope
│   │
│   └── Interface Scope
```

---

### Symbol Table Construction

Build symbol tables for:

* Variables.
* Functions.
* Objects.
* Traits.
* Interfaces.
* Modules.

---

### Import Resolution

Resolve imported modules according to ADR-0022.

Example:

```jua
import math
```

The semantic analyzer:

1. Locates the module.
2. Loads the module.
3. Builds imported symbol tables.
4. Exposes exported symbols.

---

### Visibility Enforcement

Enforce export rules according to ADR-0021.

Example:

```jua
export function add()

function validate()
```

Only:

```text
add
```

is visible outside the module.

---

### Built-In Injection

Inject compiler-provided symbols before semantic validation.

Examples:

```text
print
assert
length
typeOf
```

See ADR-0023.

---

### Type Checking

Validate type compatibility.

Example:

```jua
create age: integer = "twenty"
```

Invalid.

---

### Entrypoint Resolution

Determine program startup behavior according to ADR-0020.

Rules:

```text
If main exists:
    execute main

Otherwise:
    execute top-level statements
```

---

### Mutability Validation

Enforce immutable-by-default semantics.

Example:

```jua
create age = 20

age = 30
```

Invalid.

---

### Closure Validation

Reject closure behavior according to ADR-0017.

Example:

```jua
function outer()

    create x = 10

    function inner()

        print(x)

    end

end
```

Invalid.

---

## Non-Responsibilities

Semantic analysis must not:

* Generate backend code.
* Perform optimization.
* Emit machine instructions.
* Execute user code.

---

# Phase 4: Intermediate Representation

## Status

Deferred.

Jua 0.1 does not yet define a mandatory intermediate representation.

The compiler architecture should permit the introduction of an IR in future versions.

Possible future uses include:

* Optimization.
* Multiple backend targets.
* Static analysis.
* Tooling integration.

---

# Phase 5: Backend Generation

## Responsibility

Transform validated programs into the selected execution target.

Examples:

```text
WebAssembly
```

Future:

```text
Native
JVM
CLR
```

See ADR-0002.

---

# Diagnostics

Diagnostics may be generated during multiple phases.

## Lexical Diagnostics

Examples:

```text
Invalid character.
Unterminated string.
Invalid numeric literal.
```

---

## Syntax Diagnostics

Examples:

```text
Unexpected token.
Missing end.
Expected expression.
```

---

## Semantic Diagnostics

Examples:

```text
Undefined symbol.
Module not found.
Type mismatch.
Cannot reassign immutable variable.
Symbol not exported.
```

---

# Compiler Artifact Flow

Each phase produces an artifact consumed by the next phase.

```text
Source Code
    ↓
Tokens
    ↓
AST
    ↓
Validated Program Model
    ↓
Backend Output
```

Each artifact must be considered immutable after creation.

---

# Future Extensions

Future versions may introduce:

* Intermediate Representation (IR).
* Optimization phases.
* Incremental compilation.
* Package resolution.
* Static analysis tooling.
* Language server integration.

Such additions should preserve the phase boundaries established by this specification.

---

# Related ADRs

* ADR-0002: WASM First Target
* ADR-0008: Layered Compiler Architecture
* ADR-0010: Tool-Agnostic Frontend Architecture
* ADR-0020: Entry Point Resolution
* ADR-0021: Module Visibility Model
* ADR-0022: Import Resolution Strategy
* ADR-0023: Standard Library Injection

---

# Related Specifications

* specs/grammar/
* specs/modules/
* specs/type-system/type-system.md
* specs/memory-model/memory-model.md
* specs/diagnostics/compiler-diagnostics.md

