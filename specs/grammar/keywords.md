# Jua Reserved Keywords

Version: 0.1 Draft

---

# Purpose

This document defines the reserved keywords recognized by the Jua language.

Reserved keywords cannot be used as identifiers.

Example:

Invalid:

```code
create function = 10
```

because "function" is a reserved keyword.

---

# Variable Declarations

## create

Declares a local variable.

Example:

```code
create age = 25
```

---

## mutable

Marks a variable as mutable.

Example:

```code
create mutable counter = 0
```

---

## constant

Declares an immutable constant.

Example:

```code
constant PI = 3.14159
```

---

# Functions

## function

Declares a function.

Example:

```code
function greet(name)
    print(name)
end
```

---

## return

Returns a value from a function.

Example:

```code
return total
```

---

# Conditional Execution

## if

Begins a conditional block.

---

## else

Defines an alternative execution path.

---

# Iteration

## while

Defines a conditional loop.

---

## for

Defines an iteration loop.

---

## from

Defines the starting point of a range.

---

## until

Defines the end boundary of a range.

---

## in

Defines collection iteration.

---

## break

Terminates the current loop.

---

## continue

Skips the current iteration.

---

# Boolean Literals

## true

Represents a logical true value.

---

## false

Represents a logical false value.

---

## null

Represents the absence of a value.

---

# Boolean Operators

## and

Logical conjunction.

---

## or

Logical disjunction.

---

## not

Logical negation.

---

# Modules

## import

Imports functionality from another module.

---

# Testing

## test

Defines a test block.

---

# Structure

## end

Terminates a language block.

Used with:

* function
* if
* while
* for
* test

---

# Reserved Keyword Policy

New reserved keywords may only be introduced through:

* RFC approval
* Specification update
* Conformance validation

The introduction of new reserved keywords should be minimized to preserve backwards compatibility.

