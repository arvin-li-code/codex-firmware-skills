---
name: fw-project-discovery
description: Discover facts about an existing firmware project before editing. Use when Codex needs to inspect firmware source layout, build system, board or MCU target, SDK, toolchain, configs, tests, CI, flashing/debug scripts, modules, hardware resources, RTOS tasks, interrupts, drivers, public interfaces, or project architecture maps.
---

# Firmware Project Discovery

Inspect the project and write machine-facing maps. Do not implement feature changes.

Read `references/fw-baseline.md` and `references/artifact-schema.md` when available.

## Workflow

1. Inspect repository structure.
2. Identify build system, SDK/framework, toolchain, board, and target hints.
3. Identify source roots, generated code, vendor code, tests, CI, scripts, configs, and docs.
4. Map modules, entrypoints, drivers, tasks, interrupts, timers, callbacks, queues, protocols, and external interfaces when present.
5. Find build, test, flash, monitor, and debug commands from docs or scripts.
6. Record unknowns instead of guessing.

## Outputs

Create or update:

- `.codex/artifacts/firmware/maps/project-map.md`
- `.codex/artifacts/firmware/maps/hardware-map.md` when hardware facts exist
- `.codex/artifacts/firmware/maps/interface-map.md` when interfaces exist

## `project-map.md` Sections

- Project type and purpose inferred from source/docs.
- Build system and commands.
- SDK/framework/toolchain.
- Source layout.
- Important modules.
- Config entrypoints.
- Tests and verification commands.
- Flash/monitor/debug commands.
- Generated/vendor code boundaries.
- Unknowns and assumptions.

## Guardrails

- Prefer `rg` and existing docs/scripts.
- Do not overwrite user changes.
- Do not treat inference as fact; label it as inference.
- If a project brief is missing or stale, recommend `fw-project-brief` next.
