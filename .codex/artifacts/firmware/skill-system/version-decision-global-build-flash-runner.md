# Skill Version Decision: Add Global Build And Flash Runner

## Version Impact

MINOR

## Previous Version

0.4.0

## Next Version

0.5.0

## Changed Skills

- Added `fw-build-runner`.
- Updated `fw-auto` routing.
- Updated `fw-verify` guidance.

## Reason

Compilation and flashing are global firmware operations used by every macro workflow. A repository may contain multiple project files, apps, boards, or build entrypoints, so build/flash behavior needs a dedicated tool skill that can select the correct project and mode.

## Affected Workflows

- Existing project feature iteration.
- Future new-project workflow.
- Future refactor workflow.
- Verification workflow.

## Artifact Impact

- Added `skills/fw-build-runner/SKILL.md`.
- Added `references/build-flash-profiles.md`.
- Build/flash evidence should be recorded in `.codex/artifacts/firmware/verification/<slug>.md`.

## Migration Notes

- Existing workflows can now route compile, rebuild, flash, and build-flash requests to `fw-build-runner`.
- If multiple project files or targets are found, the skill must ask the user before flashing.
