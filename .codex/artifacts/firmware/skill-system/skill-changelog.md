# Skill-System Changelog

## 2026-05-22 - Prepare Git repository structure

Version impact: Minor
Previous version: 0.3.0
Next version: 0.4.0

Changed skills:

- No skill behavior changed.

Reason:

- Added GitHub-ready repository files, local validation script, CI workflow, and contribution instructions.

Affected workflows:

- Skill-system maintenance.
- Contributor validation.

Artifact impact:

- Added `.gitignore`.
- Added `AGENTS.md.template`.
- Added `CONTRIBUTING.md`.
- Added `scripts/validate-skills.ps1`.
- Added `.github/workflows/validate-skills.yml`.
- Added `.codex/artifacts/firmware/skill-system/version-decision-git-repository-structure.md`.

Migration notes:

- Run `.\scripts\validate-skills.ps1` before pushing.
- GitHub Actions will validate skill frontmatter on push and pull request.

## 2026-05-22 - Create MVP firmware skills

Version impact: Minor
Previous version: 0.2.0
Next version: 0.3.0

Changed skills:

- `fw-auto`: added.
- `fw-project-discovery`: added.
- `fw-project-brief`: added.
- `fw-intake`: added.
- `fw-feature-iterate`: added.
- `fw-verify`: added.
- `fw-finish`: added.
- `fw-skill-governance`: added.

Reason:

- Turned the architecture map into usable skill directories with `SKILL.md` files for the first vertical slice.

Affected workflows:

- Existing project feature iteration.
- Project handoff.
- Verification and finish.
- Skill-system maintenance.

Artifact impact:

- Added skill source files under `skills/*/SKILL.md`.
- Added reference files under `references/`.
- Added skill-system changelog artifact.

Migration notes:

- The MVP skill set is now physically represented in the repository.
- Planned skills such as `fw-arch-plan`, `fw-new-project`, `fw-refactor`, `fw-debug-fix`, `fw-review`, `fw-logbook`, `fw-change-record`, and `fw-build-runner` still need implementation.
