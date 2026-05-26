# Skill Version Decision: Add Keil Build And Flash Support

## Version Impact

MINOR

## Previous Version

0.5.0

## Next Version

0.6.0

## Changed Skills

- Updated `fw-build-runner`.

## Reason

Keil MDK/uVision is a common firmware build and flashing environment. The build runner should support Keil projects directly instead of treating them only as generic vendor IDE projects.

## Affected Workflows

- Build.
- Rebuild.
- Flash.
- Build then flash.
- Feature iteration verification.
- Future new-project and refactor verification.

## Artifact Impact

- Updated `references/build-flash-profiles.md`.
- Build/flash evidence remains recorded in `.codex/artifacts/firmware/verification/<slug>.md`.

## Migration Notes

- Keil projects should be detected through `.uvprojx`, `.uvproj`, `.uvoptx`, or `.uvopt`.
- Keil command-line operations use `UV4.exe` when available.
- Flashing must not proceed when project file, target, board, or debug adapter is ambiguous.
