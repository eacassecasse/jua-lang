# Abstract Syntax Tree Model

## Purpose

This document defines the Abstract Syntax Tree (AST) structure used by the Jua compiler.

The AST is the primary artifact produced by the parser and consumed by semantic analysis.

The AST represents the syntactic structure of a Jua program while remaining independent from semantic validation and backend implementation details.

This specification complements:

* ADR-0008: Layered Compiler Architecture
* ADR-0010: Tool-Agnostic Frontend Architecture
* specs/grammar/
* specs/semantics/compiler-phases.md

---

# Design Principles

The Jua AST follows the following principles:

* Preserve source structure.
* Remain independent of semantic information.
* Remain independent of backend concerns.
* Be deterministic.
* Be easy to traverse.
* Support future compiler extensions.

---

# Root Node

Every parsed source file produces a single root node.

```text
Module
```

Example:

```jua
import math

function main()

    print("Hello")

end
```

AST:

```text
Module
├── imports
└── declarations
```

---

# Node Categories

The AST consists of the following major categories:

```text
Module Nodes
Declaration Nodes
Statement Nodes
Expression Nodes
Type Nodes
```

---

# Module Nodes

## Module

Represents a source file.

Structure:

```text
Module
├── imports
└── declarations
```

Fields:

| Field        | Description            |
| ------------ | ---------------------- |
| imports      | Import declarations    |
| declarations | Top-level declarations |

---

## ImportDeclaration

Represents an import statement.

Example:

```jua
import math
```

Structure:

```text
ImportDeclaration
└── moduleName
```

---

# Declaration Nodes

Declarations introduce symbols.

---

## FunctionDeclaration

Example:

```jua
function add(a, b)

    return a + b

end
```

Structure:

```text
FunctionDeclaration
├── name
├── parameters
├── returnType
└── body
```

---

## VariableDeclaration

Example:

```jua
create age = 20
```

Structure:

```text
VariableDeclaration
├── name
├── type
├── value
└── mutable
```

Example:

```jua
mutable age = 20
```

produces:

```text
mutable = true
```

---

## ObjectDeclaration

Example:

```jua
object Student

end
```

Structure:

```text
ObjectDeclaration
├── name
├── traits
├── interfaces
└── members
```

---

## TraitDeclaration

Example:

```jua
trait Printable

end
```

Structure:

```text
TraitDeclaration
├── name
└── members
```

---

## InterfaceDeclaration

Example:

```jua
interface Serializable

end
```

Structure:

```text
InterfaceDeclaration
├── name
└── members
```

---

# Statement Nodes

Statements represent executable actions.

---

## BlockStatement

Represents a block of statements.

Structure:

```text
BlockStatement
└── statements
```

---

## ExpressionStatement

Represents an expression used as a statement.

Example:

```jua
print("Hello")
```

Structure:

```text
ExpressionStatement
└── expression
```

---

## IfStatement

Example:

```jua
if age >= 18

    print("Adult")

end
```

Structure:

```text
IfStatement
├── condition
├── thenBranch
└── elseBranch
```

---

## WhileStatement

Example:

```jua
while active

end
```

Structure:

```text
WhileStatement
├── condition
└── body
```

---

## ForStatement

Example:

```jua
for item in items

end
```

Structure:

```text
ForStatement
├── variable
├── iterable
└── body
```

---

## ReturnStatement

Example:

```jua
return total
```

Structure:

```text
ReturnStatement
└── value
```

---

# Expression Nodes

Expressions produce values.

---

## IdentifierExpression

Example:

```jua
age
```

Structure:

```text
IdentifierExpression
└── name
```

---

## AssignmentExpression

Example:

```jua
age = 30
```

Structure:

```text
AssignmentExpression
├── target
└── value
```

Semantic validation determines whether assignment is legal.

---

## BinaryExpression

Example:

```jua
a + b
```

Structure:

```text
BinaryExpression
├── left
├── operator
└── right
```

Examples:

```text
+
-
*
/
%
==
!=
>
<
>=
<=
```

---

## UnaryExpression

Example:

```jua
-nota
```

Structure:

```text
UnaryExpression
├── operator
└── operand
```

---

## CallExpression

Example:

```jua
print(name)
```

Structure:

```text
CallExpression
├── callee
└── arguments
```

---

## MemberAccessExpression

Example:

```jua
student.name
```

Structure:

```text
MemberAccessExpression
├── object
└── member
```

---

## IndexExpression

Example:

```jua
names[0]
```

Structure:

```text
IndexExpression
├── collection
└── index
```

---

# Literal Nodes

---

## IntegerLiteral

Example:

```jua
10
```

Structure:

```text
IntegerLiteral
└── value
```

---

## FloatLiteral

Example:

```jua
3.14
```

Structure:

```text
FloatLiteral
└── value
```

---

## BooleanLiteral

Example:

```jua
true
```

Structure:

```text
BooleanLiteral
└── value
```

---

## StringLiteral

Example:

```jua
"Hello"
```

Structure:

```text
StringLiteral
└── value
```

---

## ListLiteral

Example:

```jua
[1, 2, 3]
```

Structure:

```text
ListLiteral
└── elements
```

---

# Type Nodes

Type nodes represent declared types.

They are not semantic types.

They only represent syntax.

---

## NamedType

Example:

```jua
integer
```

Structure:

```text
NamedType
└── name
```

Examples:

```text
integer
float
double
boolean
string
list
object
```

---

# Source Locations

Every AST node must contain source location information.

Minimum information:

```text
line
column
```

Recommended:

```text
startLine
startColumn
endLine
endColumn
```

This information is required for diagnostics.

---

# Semantic Separation

The AST must not contain:

* Symbol references.
* Resolved types.
* Visibility information.
* Scope information.
* Import resolution information.

Those belong to semantic analysis.

---

# Future Extensions

Future versions may introduce:

* Lambda expressions.
* Closures.
* Generic types.
* Pattern matching.
* Exception handling.

New nodes should be added without breaking existing AST structure.

---

# Related ADRs

* ADR-0008: Layered Compiler Architecture
* ADR-0010: Tool-Agnostic Frontend Architecture
* ADR-0017: Closure Deferral
* ADR-0018: Generics Deferral
* ADR-0019: Exception Handling Deferral

---

# Related Specifications

* specs/grammar/
* specs/type-system/type-system.md
* specs/semantics/compiler-phases.md
* specs/modules/modules.md

