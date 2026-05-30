---
name: fw-auto
description: Firmware workflow entry recommender. Use when the user asks what to do next in a firmware project, wants to continue a firmware workflow, gives a firmware request that must be routed to new project, feature iteration, refactor, debug/fix, verify, generated-output sanity check, finish, handoff brief, or skill-system governance, or when a previous firmware skill returned a terminal status.
---

# Firmware Auto

Recommend the next firmware skill. Do not edit code, run builds, or replace another skill.

## Inputs To Inspect

- User request.
- Existing artifacts under `.codex/artifacts/firmware/`, if present.
- `references/terminal-status.md` when recovering from a status.
- `references/skill-registry.md` when routing skill-system work.

## Routing

- No existing project and user wants a scaffold: recommend `fw-new-project`.
- Existing project and user wants behavior change: recommend `fw-feature-iterate`.
- Existing project and user emphasizes behavior preservation: recommend `fw-refactor`.
- Bug, crash, peripheral failure, boot failure, OTA failure, timing, memory, or hardware anomaly: recommend `fw-debug-fix`.
- User wants onboarding, handoff, project purpose, usage, or architecture summary: recommend `fw-project-brief`.
- User asks whether work is ready or complete: recommend `fw-verify`.
- User asks to compile, rebuild, flash, upload, program a board, or build then flash: recommend `fw-build-runner`.
- User asks to check generated files, code, Markdown,乱码, mojibake, malformed output, or whether generated content is normal: recommend `fw-output-sanity-check`.
- User asks to summarize final state, commit, release, or hand off completed work: recommend `fw-finish`.
- User adds, removes, renames, or changes a skill, workflow, trigger, artifact schema, README, registry, or version policy: recommend `fw-skill-governance`.
- Requirement or target is unclear: recommend `fw-intake`.
- Impact is broad or risky: recommend `fw-arch-plan`.

## Output Format

```text
Recommended next skill: <skill>
Reason: <short reason>
Read artifacts:
- <path or none>
Expected output:
- <path or none>
Recovery:
- <terminal-status recovery, if relevant>
```

Keep the recommendation short and actionable.
