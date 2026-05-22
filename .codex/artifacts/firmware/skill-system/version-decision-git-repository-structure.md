# Skill Version Decision: Prepare Git Repository Structure

## Version Impact

MINOR

## Previous Version

0.3.0

## Next Version

0.4.0

## Changed Skills

- No skill behavior changed.

## Reason

The project needed a GitHub-ready repository structure so the firmware skill system can be uploaded, validated, and maintained like a normal open-source repository.

## Affected Workflows

- Skill-system maintenance.
- Contribution and validation workflow.

## Artifact Impact

- Added repository files:
  - `.gitignore`
  - `AGENTS.md.template`
  - `CONTRIBUTING.md`
  - `scripts/validate-skills.ps1`
  - `.github/workflows/validate-skills.yml`
- Updated `README.md`.
- Updated `CHANGELOG.md`.
- Updated `references/skill-registry.md`.

## Migration Notes

- Existing skills remain compatible.
- Future pull requests can run skill frontmatter validation through GitHub Actions.
