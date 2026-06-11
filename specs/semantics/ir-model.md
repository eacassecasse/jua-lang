# Intermediate Representation (IR) Model

Version: 0.1 Draft
Status: Proposed

---

# Purpose

This document defines the Intermediate Representation (IR) used internally by the Jua compiler.

The IR serves as the bridge between:

```text
AST
 ↓
Semantic Analysis
 ↓
IR
 ↓
Backend (WASM initially)
```

The IR is not part of the language visible to users.

It exists solely to simplify compiler implementation.

---

# Design Philosophy

The Jua IR follows the principle:

> The AST represents syntax. The IR represents executable meaning.

The IR should:

* Be independent of source syntax
* Be easy to validate
* Be easy to transform
* Be backend-neutral
* Be simpler than the AST

---

# Compiler Pipeline

```text
Source Code
 ↓
Lexer
 ↓
Parser
 ↓
AST
 ↓
Semantic Analysis
 ↓
IR Generation
 ↓
Backend
 ↓
Executable Output
```

---

# Why an IR Exists

Consider:

```jua
create age = 10 + 20
```

AST:

```text
VariableDeclaration
 ├── name: age
 └── BinaryExpression(+)
      ├── 10
      └── 20
```

Backend code generation directly from the AST becomes increasingly difficult as the language grows.

Instead, AST becomes:

```text
CONST 10
CONST 20
ADD
STORE age
```

This IR is significantly easier to compile.

---

# IR Design Level

Jua 0.1 uses a:

```text
High-Level Typed IR
```

Not:

```text
SSA
Bytecode
Machine Instructions
```

Those may come later.

---

# Core IR Properties

Each IR node MUST:

```text
Have a type
Have source location
Be semantically valid
Be backend independent
```

---

# IR Categories

Jua IR contains:

```text
IR Program
IR Function
IR Block

IR Expressions
IR Statements

IR Types
IR Symbols
```

---

# IR Program

Represents a fully validated source file.

Example:

```text
Program
 ├── Functions
 ├── Objects
 ├── Traits
 ├── Interfaces
 └── Tests
```

---

# IR Function

Represents executable function logic.

Example:

```jua
function add(a, b)
    return a + b
end
```

IR:

```text
Function add
  Parameters:
    a
    b

  Body:
    LOAD a
    LOAD b
    ADD
    RETURN
```

---

# IR Block

Represents a sequence of instructions.

Example:

```text
Block
 ├── Instruction
 ├── Instruction
 └── Instruction
```

---

# Expression IR Nodes

---

## Constant

```text
CONST(value)
```

Examples:

```text
CONST(10)
CONST("hello")
CONST(true)
```

---

## Variable Reference

```text
LOAD(symbol)
```

Example:

```jua
print(age)
```

IR:

```text
LOAD age
```

---

## Assignment

```text
STORE(symbol)
```

Example:

```jua
age = 20
```

IR:

```text
CONST 20
STORE age
```

---

## Binary Operation

```text
ADD
SUB
MUL
DIV

EQ
NE

LT
GT
LE
GE

AND
OR
```

---

Example:

```jua
2 + 3
```

IR:

```text
CONST 2
CONST 3
ADD
```

---

## Unary Operations

```text
NEG
NOT
```

Example:

```jua
not true
```

IR:

```text
CONST true
NOT
```

---

# Control Flow IR

---

## Conditional Branch

Source:

```jua
if age > 18
    print("Adult")
end
```

IR:

```text
LOAD age
CONST 18
GT

BRANCH_IF_TRUE label1
JUMP label2

label1:
CALL print

label2:
```

---

## While Loop

Source:

```jua
while running
    print("...")
end
```

IR:

```text
loop_start:

LOAD running
BRANCH_IF_FALSE loop_end

CALL print

JUMP loop_start

loop_end:
```

---

# Function Calls

Source:

```jua
add(2, 3)
```

IR:

```text
CONST 2
CONST 3
CALL add
```

---

# Return

Source:

```jua
return x
```

IR:

```text
LOAD x
RETURN
```

---

# Object Construction

Source:

```jua
Student("Ana")
```

IR:

```text
NEW Student

CONST "Ana"

CALL Student.constructor
```

---

# Property Access

Source:

```jua
student.name
```

IR:

```text
LOAD student
GET_FIELD name
```

---

# Property Assignment

Source:

```jua
student.age = 20
```

IR:

```text
LOAD student
CONST 20
SET_FIELD age
```

---

# Method Calls

Source:

```jua
student.greet()
```

IR:

```text
LOAD student
CALL_METHOD greet
```

---

# Built-in Functions

Built-ins are represented as normal calls.

Example:

```jua
print("hello")
```

IR:

```text
CONST "hello"
CALL print
```

---

# Symbol References

All identifiers are resolved during semantic analysis.

IR MUST NOT contain unresolved names.

Valid:

```text
LOAD Symbol#17
```

Invalid:

```text
LOAD "age"
```

---

# Type Information

Each IR instruction stores type metadata.

Example:

```text
ADD
  leftType: integer
  rightType: integer
  resultType: integer
```

---

# Error Handling

The IR generator assumes:

```text
AST is already semantically valid
```

IR generation MUST NOT perform:

* Type checking
* Scope checking
* Mutability checking

Those belong to earlier phases.

---

# Backend Independence

The IR must not contain:

```text
WASM instructions
JVM instructions
Native machine code
```

Those belong to backend stages.

---

# Optimization Readiness

Future optimization passes may operate on IR:

```text
Constant folding
Dead code elimination
Inlining
```

However:

```text
Optimization is NOT required for Jua 0.1
```

---

# Compliance

A conforming Jua compiler MUST:

* Generate IR after semantic validation
* Produce typed IR
* Resolve all symbols
* Preserve source locations
* Remain backend-neutral
