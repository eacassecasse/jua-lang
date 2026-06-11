# Functions

Version: 0.1 Draft

---

# Purpose

This document defines functions in the Jua programming language.

Functions provide a mechanism for organizing behavior into reusable, named units of execution.

Functions enable:

* Code reuse
* Abstraction
* Modularity
* Composition
* Testing

Functions are first-class language constructs and form the primary mechanism for defining executable behavior.

---

# Design Philosophy

Jua follows the principle:

> Functions should be easy to read, easy to teach, and easy to reason about.

The function system prioritizes:

* Explicitness
* Predictability
* Readability
* Educational accessibility

over advanced language features.

---

# Design Goals

The function system should be:

* Simple for beginners
* Suitable for professional applications
* Easy to analyze statically
* Compatible with gradual typing
* Compatible with Result-based error handling
* Future-proof for language evolution

---

# Function Declaration

Functions are declared using the `function` keyword.

General form:

```jua
function name(parameters)

    ...

end
```

Example:

```jua
function greet(name)

    print("Hello " + name)

end
```

---

# Function Names

Function names must follow identifier rules.

Valid:

```jua
function greet()

function calculateTotal()

function userExists()
```

Invalid:

```jua
function 123abc()

function create-user()
```

---

# Function Body

A function body consists of zero or more statements.

Example:

```jua
function welcome()

    print("Welcome")

end
```

---

# Empty Functions

Functions may be empty.

Example:

```jua
function futureImplementation()

end
```

---

# Function Invocation

Functions are invoked using parentheses.

Example:

```jua
greet("Ana")
```

---

# Arguments

Arguments provide values to function parameters.

Example:

```jua
function greet(name)

    print(name)

end

greet("Ana")
```

Output:

```text
Ana
```

---

# Positional Parameters

Version 0.1 uses positional parameters exclusively.

Example:

```jua
function createUser(name, age)

    ...

end

createUser("Ana", 20)
```

The order of arguments must match the order of parameters.

---

# Named Arguments

Named arguments are not supported in Version 0.1.

Invalid:

```jua
createUser(
    age = 20,
    name = "Ana"
)
```

---

# Parameter Count Validation

The number of supplied arguments must match the number of declared parameters.

Example:

```jua
function greet(name)

end
```

Valid:

```jua
greet("Ana")
```

Invalid:

```jua
greet()
```

Compiler Error:

```text
Expected 1 argument.

Received 0 arguments.
```

---

# Parameter Mutability

Function parameters are immutable.

Example:

```jua
function greet(name)

    name = "Pedro"

end
```

Compiler Error:

```text
Cannot assign to immutable parameter 'name'.
```

---

# Local Scope

Parameters exist only within the function scope.

Example:

```jua
function greet(name)

    print(name)

end
```

The parameter `name` cannot be accessed outside the function.

---

# Return Statement

Functions return values using the `return` keyword.

Example:

```jua
function add(a, b)

    return a + b

end
```

---

# Returning Values

Example:

```jua
function multiply(a, b)

    return a * b

end

create result = multiply(2, 5)
```

Value:

```text
10
```

---

# Early Return

Execution stops immediately after a return statement.

Example:

```jua
function checkAge(age)

    if age < 18

        return false

    end

    return true

end
```

---

# Functions Without Return

Functions may omit return statements.

Example:

```jua
function log(message)

    print(message)

end
```

---

# Implicit Return Value

When no explicit return is provided, the function returns:

```text
null
```

Version 0.1 defines `null` as the default return value.

---

# Multiple Return Values

Multiple return values are not supported.

Invalid:

```jua
return x, y
```

Instead:

```jua
return {

    x: x,

    y: y

}
```

---

# Recursion

Functions may invoke themselves.

Example:

```jua
function factorial(n)

    if n <= 1

        return 1

    end

    return n * factorial(n - 1)

end
```

---

# Mutual Recursion

Functions may invoke each other.

Example:

```jua
function isEven(n)

    if n == 0

        return true

    end

    return isOdd(n - 1)

end

function isOdd(n)

    if n == 0

        return false

    end

    return isEven(n - 1)

end
```

---

# Function Overloading

Version 0.1 does not support function overloading.

Invalid:

```jua
function add(a, b)

end

function add(a, b, c)

end
```

Compiler Error:

```text
Function 'add' is already defined.
```

---

# Anonymous Functions

Anonymous functions are not supported in Version 0.1.

Unsupported examples:

```jua
function(x)

end
```

```jua
(x) => x * 2
```

---

# Nested Functions

Version 0.1 does not support nested function declarations.

Invalid:

```jua
function outer()

    function inner()

    end

end
```

---

# Function Visibility

Version 0.1 defines all functions as visible within their module.

Future versions may introduce:

```text
public
private
protected
```

visibility modifiers.

---

# Typed Parameters

Parameters may be declared with explicit types.

Example:

```jua
function add(
    a: integer,
    b: integer
)

    return a + b

end
```

---

# Parameter Type Validation

Valid:

```jua
add(2, 3)
```

Invalid:

```jua
add("2", 3)
```

Compiler Error:

```text
Expected:

integer

Received:

string
```

---

# Typed Return Values

Functions may define return types.

Example:

```jua
function add(
    a: integer,
    b: integer
): integer

    return a + b

end
```

---

# Return Type Validation

Compiler implementations must verify that returned values satisfy declared return types.

Example:

```jua
function getAge(): integer

    return "twenty"

end
```

Compiler Error:

```text
Expected return type:

integer

Received:

string
```

---

# Type Inference

Functions may omit type declarations.

Example:

```jua
function square(value)

    return value * value

end
```

Type checking follows the gradual typing model defined elsewhere.

---

# Result-Based Errors

Functions participate in the Result-based error model.

Example:

```jua
function loadUser(id)

    ...

    return {
        value: user,
        error: null
    }

end
```

---

# Error Propagation

Functions may return Result objects.

Example:

```jua
function processUser(id)

    create result = loadUser(id)

    if result.error != null

        return result

    end

    ...

end
```

---

# Entry Point Discovery

Jua supports a hybrid entry-point model.

---

## Explicit Entry Point

When a function named `main` exists:

```jua
function main()

    print("Hello")

end
```

execution begins at `main`.

---

## Top-Level Execution

When no `main` function exists:

```jua
print("Hello")
```

execution begins at the top level.

---

# Entry Point Selection

Compiler behavior:

```text
main exists?

Yes:
    Start at main()

No:
    Execute top-level statements
```

---

# Duplicate Main Functions

A module may define only one `main` function.

Invalid:

```jua
function main()

end

function main()

end
```

Compiler Error:

```text
Function 'main' is already defined.
```

---

# Diagnostics

Function-related diagnostics should:

* Identify the failing function
* Identify the parameter involved
* Explain the expected behavior
* Provide corrective guidance when possible

Example:

```text
Invalid argument.

Function:
createUser

Parameter:
age

Expected:
integer

Received:
string
```

---

# Educational Guidance

Functions should encourage decomposition of behavior into small, reusable units.

Educational materials should favor:

```text
Single responsibility

Descriptive names

Limited parameter counts

Explicit return values
```

---

# Future Evolution

Future versions may introduce:

```text
Named arguments
Default parameters
Anonymous functions
Closures
Generics
Function visibility modifiers
Function attributes
Coroutines
Async functions
Method declarations
```

Such features must remain compatible with the Version 0.1 function model.

---

# Compliance

A conforming implementation must support all function behavior defined in this specification.
