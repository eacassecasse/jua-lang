# Built-in Functions

Version: 0.1 Draft
Status: Proposed

---

# Purpose

This document defines the built-in functions available in every Jua program.

Built-in functions:

* Are available without imports
* Are provided by the runtime
* Have predefined semantics
* Cannot be redefined by user code

---

# Design Philosophy

Jua built-ins follow the principle:

> A built-in should exist only when it is universally useful and difficult to express in user code.

Version 0.1 intentionally includes a very small set of built-ins.

---

# Built-in Function List

Jua 0.1 provides:

```text
print()
assert()
typeOf()
length()
```

---

# Reserved Names

The following identifiers are reserved:

```text
print
assert
typeOf
length
```

User code MUST NOT redefine them.

---

# print()

## Purpose

Outputs a textual representation of a value.

---

## Signature

```jua
print(value)
```

---

## Parameters

| Name  | Description         |
| ----- | ------------------- |
| value | Any printable value |

---

## Return Type

```text
null
```

---

## Example

```jua
print("Hello")
```

Output:

```text
Hello
```

---

## Multiple Calls

```jua
print("A")
print("B")
```

Output:

```text
A
B
```

---

# Formatting Rules

The runtime determines final output formatting.

At minimum:

```text
string → printed directly
integer → decimal representation
float → decimal representation
boolean → true/false
null → null
```

---

# assert()

## Purpose

Validates conditions during testing.

---

## Signature

```jua
assert(condition)
```

---

## Parameters

| Name      | Type    |
| --------- | ------- |
| condition | boolean |

---

## Return Type

```text
null
```

---

## Success Example

```jua
assert(1 + 1 == 2)
```

No output.

---

## Failure Example

```jua
assert(1 + 1 == 3)
```

Runtime failure:

```text
Assertion failed
```

---

## Type Rule

The argument MUST evaluate to:

```text
boolean
```

---

Invalid:

```jua
assert(10)
```

Error:

```text
assert() requires boolean argument
```

---

# typeOf()

## Purpose

Returns the runtime type name of a value.

---

## Signature

```jua
typeOf(value)
```

---

## Return Type

```text
string
```

---

## Examples

```jua
typeOf(10)
```

returns:

```text
"integer"
```

---

```jua
typeOf("hello")
```

returns:

```text
"string"
```

---

```jua
typeOf(true)
```

returns:

```text
"boolean"
```

---

# length()

## Purpose

Returns the length of a string or list.

---

## Signature

```jua
length(value)
```

---

## Supported Types

```text
string
list
```

---

## Examples

```jua
length("hello")
```

returns:

```text
5
```

---

```jua
length([1,2,3])
```

returns:

```text
3
```

---

## Invalid Example

```jua
length(10)
```

Error:

```text
length() requires string or list
```

---

# Evaluation Order

Arguments are evaluated before invocation.

Example:

```jua
print(add(2, 3))
```

Evaluation order:

```text
1. add(2,3)
2. print(result)
```

---

# Error Handling

Built-ins participate in standard runtime error reporting.

Example:

```jua
length(10)
```

Produces:

```text
Invalid argument type
```

---

# Compiler Integration

Built-ins are inserted automatically into the global symbol table.

Example:

```text
Global Scope
 ├── print
 ├── assert
 ├── typeOf
 └── length
```

---

# Semantic Rules

The semantic analyzer MUST:

* Recognize built-ins
* Validate argument count
* Validate argument types when possible
* Prevent redefinition

---

# Examples

## Printing

```jua
print("Hello World")
```

---

## Testing

```jua
test Addition

    assert(1 + 1 == 2)

end
```

---

## Type Inspection

```jua
create age = 10

print(typeOf(age))
```

Output:

```text
integer
```

---

## Length Calculation

```jua
print(length("Jua"))
```

Output:

```text
3
```

---

# Future Built-ins (Not Included in 0.1)

The following are intentionally deferred:

```text
input()
readFile()
writeFile()
parseInt()
parseFloat()
panic()
exit()
sleep()
```

---

# Compliance

A conforming Jua runtime MUST provide:

```text
print()
assert()
typeOf()
length()
```

with the semantics defined in this specification.
