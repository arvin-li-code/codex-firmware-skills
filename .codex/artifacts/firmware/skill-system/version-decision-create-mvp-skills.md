# Skill Version Decision: Create MVP Firmware Skills

## Version Impact

MINOR

## Previous Version

0.2.0

## Next Version

0.3.0

## Changed Skills

- Added `fw-auto`.
- Added `fw-project-discovery`.
- Added `fw-project-brief`.
- Added `fw-intake`.
- Added `fw-feature-iterate`.
- Added `fw-verify`.
- Added `fw-finish`.
- Added `fw-skill-governance`.

## Reason

The architecture previously described the MVP skill set but did not include actual skill directories. This change adds compatible new capabilities without removing or renaming existing skills.

## Affected Workflows

- Existing project feature iteration can now be routed and executed at a basic level.
- Project handoff can now be generated.
- Skill-system changes can now be governed.

## Artifact Impact

- New skill files under `skills/`.
- New references under `references/`.
- New skill-system governance artifacts under `.codex/artifacts/firmware/skill-system/`.

## Migration Notes

- This is compatible because no old skill behavior was removed.
- Future changes should update `references/skill-registry.md`, `README.md`, `CHANGELOG.md`, and this artifact area when user-facing behavior changes.
