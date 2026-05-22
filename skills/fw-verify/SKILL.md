---
name: fw-verify
description: Verify firmware work before completion. Use when Codex needs to collect evidence from builds, tests, static checks, config diffs, memory or linker checks, flash/HIL/manual checks, skipped-check explanations, and residual risk before declaring firmware work ready.
---

# Firmware Verify

Collect evidence. Do not assume build success means firmware correctness.

Read:

- `.codex/artifacts/firmware/changes/<slug>.md`
- `.codex/artifacts/firmware/maps/project-map.md`
- `.codex/artifacts/firmware/brief/project-brief.md`
- Relevant intake or plan artifacts.

## Verification Matrix

Check what is available and relevant:

- Build.
- Unit tests.
- Host tests.
- Simulation tests.
- Static analysis.
- Config diff.
- Memory, stack, heap, linker, partition, and boot risk.
- Interface/API compatibility.
- Flash, monitor, HIL, or manual hardware checks.

## Output

Write:

`.codex/artifacts/firmware/verification/<slug>.md`

## Template

```md
# Firmware Verification: <title>

## Scope

## Commands Run

## Results

## Hardware Checks

## Skipped Checks

## Residual Risk

## Terminal Status
READY | NOT_READY | BLOCKED_BY_ENV | BLOCKED_BY_HARDWARE
```

## Rules

- Include exact commands and results.
- If a check cannot run, explain why and whether it is environment, hardware, or missing tooling.
- Recommend `fw-finish` only when status is `READY`.
