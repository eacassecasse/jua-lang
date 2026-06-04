# Commit Conventions

## Purpose

Jua uses the Conventional Commits specification to ensure a consistent commit history, improve repository governance, support automated tooling, and simplify future release management.

Commit messages are validated locally using Husky and Commitlint, and validated again in GitHub Actions during pull request and merge workflows.

## Format

```
<type>(<scope>): <description>
```

Example:

```
feat(parser): add support for trait declarations
```

---

## Commit Types

### feat

Introduces a new feature.

```
feat(runtime): add async scheduler
```

---

### fix

Fixes a defect.

```
fix(lexer): handle unicode whitespace
```

---

### docs

Documentation-only changes.

```
docs(specs): clarify module resolution rules
```

---

### style

Formatting or stylistic changes that do not affect behavior.

```
style(parser): apply formatting rules
```

---

### refactor

Code restructuring without changing behavior.

```
refactor(ast): simplify node hierarchy
```

---

### perf

Performance improvements.

```
perf(compiler): optimize symbol lookup
```

---

### test

Add or update tests.

```
test(conformance): add trait validation tests
```

---

### build

Build system changes.

```
build(ci): improve workflow caching
```

---

### ci

Continuous integration changes.

```
ci(actions): add pull request validation
```

---

### chore

Maintenance tasks.

```
chore(governance): update repository labels
```

---

## Recommended Scopes

### Language

```
specs
grammar
types
semantics
modules
```

### Compiler

```
lexer
parser
ast
frontend
middleend
backend
driver
runtime
```

### Toolchain

```
formatter
linter
lsp
debugger
package-manager
```

### Governance

```
governance
adr
docs
ci
```

### Education

```
education
curriculum
tutorials
```

---

## Examples

```
feat(grammar): add match expression syntax

fix(parser): resolve precedence ambiguity

docs(adr): add gradual typing decision

chore(governance): add issue templates

ci(actions): add commitlint validation
```

---

## Rules

* Use lowercase commit types.
* Keep descriptions concise.
* Use the imperative mood.
* Do not end descriptions with a period.
* One logical change per commit whenever practical.
* Reference issues and ADRs where appropriate.

