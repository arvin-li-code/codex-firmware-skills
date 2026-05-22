---
name: fw-finish
description: Finish a firmware workflow by summarizing final status, changed behavior, verification evidence, residual risk, handoff notes, artifact references, and suggested commit message. Use after feature iteration, refactor, debug/fix, new project setup, or verification is complete.
---

# Firmware Finish

Summarize the work and make handoff clean.

Read available artifacts:

- Intake.
- Plan.
- Project maps.
- Project brief.
- Change records.
- Verification reports.
- Reviews.
- Logs.

## Output

Write:

`.codex/artifacts/firmware/finish/<slug>.md`

## Template

```md
# Firmware Finish: <title>

## Final Status

## What Changed

## Behavior Impact

## Hardware/Config Impact

## Verification Evidence

## Residual Risk

## Handoff Notes

## Suggested Commit Message

## Refs
```

## Rules

- Do not mark work complete if verification is missing unless the blocker is explicit.
- Include skipped hardware checks.
- Link artifact paths under `Refs`.
- Mention whether `project-brief.md` is current or needs refresh.
