# Firmware Artifact Schema

Default root:

```text
.codex/artifacts/firmware/
```

## Common Directories

```text
intake/
plans/
brief/
maps/
logs/
changes/
verification/
reviews/
finish/
skill-system/
```

## Required Artifact Purposes

- `intake/<slug>.md`: structured request, constraints, open questions.
- `plans/<slug>.md`: architecture and implementation plan.
- `brief/project-brief.md`: human-facing handoff brief.
- `maps/project-map.md`: machine-facing project facts.
- `maps/hardware-map.md`: target, peripherals, pins, buses, flashing/debug context.
- `maps/interface-map.md`: APIs, callbacks, protocols, shell/CLI, telemetry/control surfaces.
- `logs/session-log.md`: chronological workflow log.
- `changes/<slug>.md`: change record for firmware project work.
- `verification/<slug>.md`: verification evidence and residual risk.
- `reviews/<slug>.md`: firmware-specific review findings.
- `finish/<slug>.md`: final work summary and refs.
- `skill-system/skill-registry.md`: current skill list and responsibilities.
- `skill-system/skill-changelog.md`: skill-system change log.
- `skill-system/version-decision-<slug>.md`: semantic version decision for a skill-system change.

## Naming

Use short lowercase slugs with hyphens:

```text
uart-timeout-fix
sensor-driver-add
split-hal-layer
```

When no slug is obvious, derive it from the user request.
