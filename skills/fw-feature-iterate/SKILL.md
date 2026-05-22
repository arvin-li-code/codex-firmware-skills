---
name: fw-feature-iterate
description: Implement focused feature or behavior changes in an existing firmware project. Use when the user asks to add firmware functionality, modify behavior, integrate a driver, change protocol handling, update telemetry or control logic, or extend an existing embedded project without broad refactor.
---

# Firmware Feature Iterate

Implement a focused behavior change in an existing firmware project.

Read first when available:

- `.codex/artifacts/firmware/maps/project-map.md`
- `.codex/artifacts/firmware/brief/project-brief.md`
- `.codex/artifacts/firmware/intake/<slug>.md`
- `.codex/artifacts/firmware/plans/<slug>.md`

## Workflow

1. Ensure project discovery exists. If missing, recommend `fw-project-discovery`.
2. Ensure a project brief exists, or mark it stale when behavior, usage, architecture, commands, or risk areas will change.
3. Frame the requested behavior and acceptance criteria.
4. Map impact before editing:
   - Files and modules.
   - Public interfaces.
   - Drivers and peripherals.
   - Config.
   - RTOS tasks, interrupts, timers, queues, DMA, and protocols when relevant.
5. Implement the smallest architecture-consistent change.
6. Add focused tests or checks when feasible.
7. Run relevant build/test commands when known.
8. Record skipped hardware checks.
9. Write a change record and recommend `fw-verify`.

## Guardrails

- Do not perform unrelated refactor.
- Preserve existing style and ownership boundaries.
- Do not hide behavior changes inside cleanup.
- Do not overwrite user changes.
- If impact is broad or risky, stop and recommend `fw-arch-plan`.

## Outputs

- Updated code/config as needed.
- `.codex/artifacts/firmware/changes/<slug>.md`
- Updated `brief/project-brief.md` if user-facing behavior, usage, architecture, commands, or risk areas changed.

## Terminal Status

- `READY_FOR_VERIFY`
- `NEEDS_INTAKE`
- `NEEDS_ARCH_PLAN`
- `BUILD_BLOCKED`
- `HARDWARE_BLOCKED`
