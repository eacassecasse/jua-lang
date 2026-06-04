# Development Setup

## Overview

This guide helps contributors set up a working environment for Jua development.

At this stage of the project, some components may still be evolving.

---

## Requirements

### Core Tools

* Git
* Java (required for lexer/parser tooling such as JFlex)
* Node.js (for tooling and CI scripts)
* pnpm

---

## Repository Setup

```bash
git clone https://github.com/eacassecasse/jua-lang.git
cd jua
```

---

## Install Dependencies

```bash
pnpm install
```

---

## Project Structure Overview

```text
specs/          → language specification
compiler/       → compiler implementation
runtime/        → execution engine
stdlib/         → standard library
toolchain/      → developer tools
tests/          → test suites
education/      → learning materials
architecture/   → ADRs and design docs
```

---

## Validation Commands (Planned)

These will evolve as the project matures:

```bash
pnpm lint
pnpm test
pnpm build
```

---

## Contribution Flow

1. Create issue
2. Create branch
3. Implement change
4. Run validations
5. Submit pull request

---

## Notes

Some components (compiler, runtime) may not yet be fully operational. Contributors should consult ADRs and specifications before implementing changes.

