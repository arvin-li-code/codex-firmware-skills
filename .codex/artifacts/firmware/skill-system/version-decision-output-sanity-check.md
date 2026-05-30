# Skill Version Decision: Add Generated Output Sanity Check

## Version Impact

MINOR

## Previous Version

0.6.0

## Next Version

0.7.0

## Changed Skills

- Added `fw-output-sanity-check`.
- Updated `fw-auto` routing.

## Reason

Generated files and code need a global self-check gate because malformed output, encoding issues, mojibake, broken Markdown, or invalid skill frontmatter can make generated artifacts unusable.

## Affected Workflows

- All workflows that generate or edit files.
- Skill-system maintenance.
- Documentation generation.
- Code generation.

## Artifact Impact

- Added `skills/fw-output-sanity-check/SKILL.md`.
- Added `scripts/check-generated-output.ps1`.
- Updated GitHub Actions to run generated-output checks.

## Migration Notes

- After creating or editing files, run `fw-output-sanity-check`.
- For this repository, run `.\scripts\check-generated-output.ps1`.
- Do not claim completion if generated-output sanity check fails unless the failure is documented as a false positive.
