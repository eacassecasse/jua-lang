# Security Policy

## Supported Versions

Only the `main` branch is considered actively maintained.

Security fixes will be applied to:

* latest stable state of `main`

---

## Reporting a Vulnerability

We take security issues seriously, especially given that Jua includes:

* a compiler
* a runtime system
* tooling that executes user code

Do NOT open public issues for vulnerabilities.

Instead, report privately via:

* GitHub Security Advisories (preferred)

or (future):

* [security@jua-lang.org](mailto:security@jua-lang.org)

---

## Scope of Security Concerns

The following are considered security-sensitive:

* compiler code execution flaws
* unsafe code generation (WASM or future backends)
* runtime memory safety issues
* tooling that executes untrusted code
* package management vulnerabilities

---

## What to Include in Reports

* description of the vulnerability
* minimal reproduction case
* affected version or commit
* potential impact

---

## Response Process

1. Acknowledgement within reasonable timeframe
2. Assessment and severity classification
3. Patch development
4. Coordinated disclosure after fix

---

## Disclosure Policy

Security issues will be:

* fixed privately first
* disclosed publicly after mitigation
