# Symbol Table Model

## Purpose

This document defines the symbol table model used by the Jua compiler during semantic analysis.

The symbol table is responsible for tracking declarations, scopes, visibility, and symbol resolution.

This specification complements:

* specs/semantics/compiler-phases.md
* specs/semantics/ast-model.md
* ADR-0004: Local by Default Variables
* ADR-0021: Module Visibility Model
* ADR-0022: Import Resolution Strategy
* ADR-0023: Standard Library Injection

---

# Design Principles

The symbol table system follows the following principles:

* Lexical (static) scoping.
* Deterministic symbol resolution.
* Scope ownership.
* Explicit visibility rules.
* Support for future language evolution.
* Separation between syntax and semantics.

---

# Purpose of Symbol Tables

A symbol table answers questions such as:

```text
What does this identifier refer to?
Where was it declared?
Is it visible from this location?
What kind of symbol is it?
Can it be reassigned?
```

Example:

```jua
create age = 20

print(age)
```

The semantic analyzer resolves:

```text
age
```

to the corresponding variable declaration.

---

# Symbol Categories

The following symbol categories exist in Jua 0.1.

## Variable Symbols

Examples:

```jua
create age = 20
mutable score = 10
```

Represent:

* Local variables.
* Module variables.
* Object fields.

---

## Function Symbols

Example:

```jua
function add(a, b)

end
```

Represents callable declarations.

---

## Object Symbols

Example:

```jua
object Student

end
```

Represents object declarations.

---

## Trait Symbols

Example:

```jua
trait Printable

end
```

Represents trait declarations.

---

## Interface Symbols

Example:

```jua
interface Serializable

end
```

Represents interface declarations.

---

## Module Symbols

Example:

```jua
import math
```

Represents imported modules.

---

## Built-In Symbols

Examples:

```text
print
assert
length
typeOf
```

Provided automatically by the compiler.

See ADR-0023.

---

# Symbol Structure

Every symbol contains common information.

Minimum structure:

```text
Symbol
├── name
├── kind
├── scope
└── declaration
```

Field descriptions:

| Field       | Description          |
| ----------- | -------------------- |
| name        | Symbol name          |
| kind        | Symbol category      |
| scope       | Owning scope         |
| declaration | AST declaration node |

---

# Scope Model

Jua uses lexical scoping.

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

This hierarchy determines symbol visibility and lookup order.

---

# Global Scope

The global scope exists for compiler-managed symbols.

Examples:

```text
print
assert
length
typeOf
```

User declarations cannot be placed directly into global scope.

---

# Module Scope

Each source file creates a module scope.

Example:

```jua
create version = "1.0"

function main()

end
```

Both declarations belong to module scope.

---

# Function Scope

Each function introduces a new scope.

Example:

```jua
function calculate()

    create value = 10

end
```

The variable:

```text
value
```

belongs to the function scope.

---

# Block Scope

Control-flow constructs introduce block scopes.

Examples:

```jua
if
while
for
```

Example:

```jua
if active

    create temp = 10

end
```

The symbol:

```text
temp
```

exists only within the block.

---

# Object Scope

Object declarations create object scopes.

Example:

```jua
object Student

    create name: string

end
```

The field:

```text
name
```

belongs to the object scope.

---

# Trait Scope

Trait declarations create trait scopes.

Example:

```jua
trait Printable

    function print()

    end

end
```

---

# Interface Scope

Interface declarations create interface scopes.

Example:

```jua
interface Serializable

    function serialize()

    end

end
```

---

# Symbol Resolution

Identifiers are resolved using nearest-scope lookup.

Lookup order:

```text
Current Scope
    ↓
Parent Scope
    ↓
Module Scope
    ↓
Imported Symbols
    ↓
Built-In Symbols
```

The first matching symbol wins.

---

# Example Resolution

Example:

```jua
create age = 20

function calculate()

    create age = 30

    print(age)

end
```

Resolution:

```text
print(age)
      │
      ▼
Function Scope age
```

The nearest declaration is selected.

---

# Shadowing

Jua allows symbol shadowing.

Example:

```jua
create age = 20

function calculate()

    create age = 30

end
```

Valid.

The inner declaration shadows the outer declaration.

---

# Duplicate Declarations

Duplicate declarations within the same scope are prohibited.

Example:

```jua
create age = 20

create age = 30
```

Invalid.

Compiler error:

```text
Symbol already defined: age
```

---

# Import Resolution

Imported symbols become visible after semantic import resolution.

Example:

```jua
import math
```

The imported module contributes exported symbols.

Only exported symbols are visible.

See ADR-0021 and ADR-0022.

---

# Built-In Injection

Before semantic validation begins, the compiler injects built-in symbols into the global scope.

Examples:

```text
print
assert
length
typeOf
```

These symbols are available to every module.

---

# Built-In Protection

Built-in symbols cannot be redefined.

Example:

```jua
function print()

end
```

Invalid.

Compiler error:

```text
Cannot redefine built-in symbol: print
```

---

# Visibility Rules

Visibility is controlled by module exports.

Example:

```jua
export function add()

function validate()
```

Visible:

```text
add
```

Not visible:

```text
validate
```

---

# Forward References

Functions may be referenced before declaration.

Example:

```jua
main()

function main()

end
```

Valid.

The semantic analyzer performs a declaration collection pass before symbol resolution.

---

# Semantic Analysis Passes

Recommended order:

```text
Pass 1
Collect declarations

Pass 2
Build symbol tables

Pass 3
Resolve imports

Pass 4
Inject built-ins

Pass 5
Resolve symbols

Pass 6
Validate types

Pass 7
Validate mutability
```

Implementations may vary provided observable behavior remains identical.

---

# Future Extensions

Future versions may introduce symbols for:

* Generic parameters.
* Lambda parameters.
* Pattern variables.
* Exception variables.
* Package declarations.

Such additions should integrate into the existing scope hierarchy.

---

# Related ADRs

* ADR-0004: Local by Default Variables
* ADR-0014: Immutable by Default Variables
* ADR-0021: Module Visibility Model
* ADR-0022: Import Resolution Strategy
* ADR-0023: Standard Library Injection

---

# Related Specifications

* specs/semantics/ast-model.md
* specs/semantics/compiler-phases.md
* specs/modules/modules.md
* specs/type-system/type-system.md

