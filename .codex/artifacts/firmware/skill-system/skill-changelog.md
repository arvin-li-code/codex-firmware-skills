# Skill-System Changelog

## 2026-05-30 - Add generated-output sanity check

Version impact: Minor
Previous version: 0.6.0
Next version: 0.7.0

Changed skills:

- `fw-output-sanity-check`: added.
- `fw-auto`: added routing for generated-output sanity checks.

Reason:

- Generated files and code need a global post-generation self-check to catch mojibake, malformed Markdown, invalid skill frontmatter, and obvious output corruption.

Affected workflows:

- All file/code generation workflows.
- Skill-system maintenance.
- Documentation generation.

Artifact impact:

- Added `skills/fw-output-sanity-check/SKILL.md`.
- Added `scripts/check-generated-output.ps1`.
- Added `.codex/artifacts/firmware/skill-system/version-decision-output-sanity-check.md`.
- Updated GitHub Actions to run the generated-output sanity check.

Migration notes:

- Run `.\scripts\check-generated-output.ps1` after generating or editing files.
- Run `.\scripts\validate-skills.ps1` and `.\scripts\check-generated-output.ps1` before committing skill changes.

## 2026-05-26 - Add Keil MDK/uVision build and flash support

Version impact: Minor
Previous version: 0.5.0
Next version: 0.6.0

Changed skills:

- `fw-build-runner`: added Keil project detection, command mapping, target confirmation, adapter confirmation, and Keil failure classes.

Reason:

- Keil MDK/uVision is a common firmware build and flashing environment and should be a first-class profile.

Affected workflows:

- Build.
- Rebuild.
- Flash.
- Build then flash.
- Verification.

Artifact impact:

- Updated `references/build-flash-profiles.md`.
- Added `.codex/artifacts/firmware/skill-system/version-decision-keil-build-flash-support.md`.

Migration notes:

- Use `UV4.exe -b` for build, `UV4.exe -r` for rebuild, and `UV4.exe -f` for flash when Keil is the selected tool.
- Ask before flashing when the Keil target, connected board, or debug adapter is unclear.

## 2026-05-26 - Add global build and flash runner

Version impact: Minor
Previous version: 0.4.0
Next version: 0.5.0

Changed skills:

- `fw-build-runner`: added.
- `fw-auto`: route compile/rebuild/flash/build-flash requests to `fw-build-runner`.
- `fw-verify`: use `fw-build-runner` for build/flash evidence.

Reason:

- Build and flash are global operations used by all firmware workflows and must support repositories with multiple project files or targets.

Affected workflows:

- Feature iteration.
- Verification.
- Future new-project flow.
- Future refactor flow.

Artifact impact:

- Added `skills/fw-build-runner/SKILL.md`.
- Added `references/build-flash-profiles.md`.
- Added `.codex/artifacts/firmware/skill-system/version-decision-global-build-flash-runner.md`.

Migration notes:

- Use `fw-build-runner` for build, rebuild, flash, and build-then-flash.
- Ask the user before flashing when project, target, board, port, or probe is ambiguous.

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
