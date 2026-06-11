# Result-Based Error Handling

Version: 0.1 Draft

---

# Purpose

This document defines error handling in the Jua programming language.

Jua distinguishes between:

```text
Recoverable failures
```

and

```text
Fatal failures
```

Recoverable failures are represented through Result objects.

Fatal failures terminate execution through panic.

---

# Design Philosophy

Jua follows the principle:

> Errors are values.

Errors should be visible, predictable, and explicitly handled by developers.

Version 0.1 does not support exceptions.

---

# Design Goals

The error handling model should be:

* Easy to learn
* Explicit
* Predictable
* Tool-friendly
* Compatible with asynchronous programming
* Compatible with WebAssembly execution

---

# Error Categories

Version 0.1 defines:

```text
Recoverable Error
Fatal Error
```

---

# Recoverable Errors

Recoverable errors are failures that applications may reasonably handle.

Examples:

* Missing file
* Invalid JSON
* Network timeout
* Invalid user input

Recoverable operations return a Result object.

---

# Fatal Errors

Fatal errors represent unrecoverable conditions.

Examples:

* Runtime corruption
* Internal compiler defects
* Invalid runtime state
* Memory exhaustion

Fatal errors terminate execution.

---

# Result Object

A Result object contains:

```text
value
error
```

Exactly one of these fields must contain a meaningful value.

---

# Successful Result

Example:

```jua
{
    value: data,
    error: null
}
```

---

# Failed Result

Example:

```jua
{
    value: null,
    error: {
        code: "FILE_NOT_FOUND",
        message: "users.json does not exist"
    }
}
```

---

# Result Contract

Successful operations must return:

```text
error = null
```

Failed operations must return:

```text
value = null
```

---

# Error Object

Version 0.1 defines the following error fields:

```text
code
message
```

---

# Error Code

The code field identifies the error category.

Example:

```jua
FILE_NOT_FOUND
```

---

# Error Message

The message field provides a human-readable description.

Example:

```jua
users.json does not exist
```

---

# Reading Files

Example:

```jua
create result = file.read("users.json")
```

---

# Success Handling

Example:

```jua
if result.error == null

    print(result.value)

end
```

---

# Failure Handling

Example:

```jua
if result.error != null

    print(result.error.message)

end
```

---

# Complete Example

```jua
create result = file.read("users.json")

if result.error != null

    print(result.error.message)

    return

end

print(result.value)
```

---

# Explicit Handling

Errors should be handled explicitly.

Jua does not automatically ignore failures.

---

# No Exceptions

Version 0.1 does not support:

```text
try
catch
throw
finally
```

These keywords are not part of the language.

---

# No Hidden Control Flow

Functions do not unexpectedly transfer execution through exception propagation.

All recoverable failures are visible through returned Result values.

---

# Function Results

Functions may return Result objects.

Example:

```jua
function loadUser(id)

    ...

end
```

Possible return:

```jua
{
    value: user,
    error: null
}
```

or

```jua
{
    value: null,
    error: {
        code: "USER_NOT_FOUND",
        message: "User does not exist"
    }
}
```

---

# Error Propagation

Version 0.1 requires explicit propagation.

Example:

```jua
create result = loadUser(id)

if result.error != null

    return result

end
```

---

# Automatic Propagation

Version 0.1 does not define automatic propagation operators.

Examples not supported:

```jua
?
```

```jua
!
```

Future versions may introduce simplified propagation syntax.

---

# Asynchronous Operations

Asynchronous operations use the same Result model.

Example:

```jua
create result = await http.get(url)

if result.error != null

    print(result.error.message)

end
```

No special async error mechanism exists.

---

# Error Equality

Error objects may be compared by code.

Example:

```jua
if result.error.code == "FILE_NOT_FOUND"

    ...

end
```

---

# Structured Error Handling

Applications should prefer error codes over message matching.

Preferred:

```jua
if result.error.code == "NETWORK_TIMEOUT"
```

Avoid:

```jua
if result.error.message == "Request timed out"
```

---

# Panic

Jua provides panic for unrecoverable failures.

Example:

```jua
panic("Internal runtime failure")
```

---

# Panic Behavior

A panic:

1. Terminates execution.
2. Produces diagnostic output.
3. Returns a non-zero process exit code.

---

# Appropriate Uses of Panic

Valid:

```jua
panic("Compiler invariant violated")
```

Valid:

```jua
panic("Unexpected runtime corruption")
```

---

# Inappropriate Uses of Panic

Avoid:

```jua
panic("User entered invalid email")
```

User errors should be represented as Result failures.

---

# Diagnostics

Errors should produce meaningful diagnostics.

Example:

```text
File operation failed.

Code:
FILE_NOT_FOUND

Message:
users.json does not exist
```

---

# Educational Guidance

Diagnostic messages should explain:

* What failed
* Why it failed
* Possible corrective action

whenever such information is available.

---

# Future Evolution

Future versions may introduce:

```text
Typed Result<T>
Result helpers
Pattern matching
Propagation operators
Error hierarchies
```

Such additions must preserve explicitness and backward compatibility whenever possible.

---

# Compliance

A conforming implementation must implement the Result model and panic behavior defined in this specification.
