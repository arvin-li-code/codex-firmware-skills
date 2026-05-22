# Firmware Baseline

Use these rules for every firmware workflow.

## Required Operating Rules

1. Identify the target before editing:
   - Board.
   - MCU.
   - SDK/framework.
   - Toolchain.
   - Build system.
   - Flash/debug method when relevant.

2. Map before editing:
   - Source layout.
   - Modules and ownership.
   - Public interfaces.
   - Config entrypoints.
   - Drivers and hardware resources.
   - RTOS tasks, interrupts, callbacks, queues, timers, and DMA when present.

3. Leave evidence:
   - Commands run.
   - Results.
   - Failures.
   - Skipped checks.
   - Reasons for skipped hardware or environment checks.

4. Make changes traceable:
   - User request.
   - Files changed.
   - Behavior impact.
   - Hardware/config impact.
   - Verification result.
   - Residual risk.

5. Keep handoff current:
   - Create `brief/project-brief.md` after first discovery.
   - Refresh it when purpose, usage, architecture, commands, or risk areas change.

6. Govern skill changes:
   - Use `fw-skill-governance` for skill additions, removals, renames, trigger changes, artifact schema changes, workflow changes, and user-facing documentation updates.

## Completion Rule

Do not claim firmware work is complete unless verification evidence and change records exist, or the blocker is explicitly documented.
