# Changelog

This file records changes to the firmware skill architecture itself.

Use semantic versioning:

- Major: breaking workflow, routing, artifact schema, or terminal-status changes.
- Minor: compatible new skills, optional artifacts, or new supported flows.
- Patch: compatible wording, examples, or clarification changes.

## 0.5.0 - Add global build and flash runner

Version impact: Minor

Reason:

- Implemented `fw-build-runner` as a global firmware build/flash tool skill.
- Added support for build, rebuild, flash, and build-then-flash modes.
- Added guidance for repositories with multiple firmware project files or build entrypoints.

Added skill files:

- `skills/fw-build-runner/SKILL.md`

Added references:

- `references/build-flash-profiles.md`

Changed files:

- `README.md`: moved `fw-build-runner` into the current usable skill set.
- `references/skill-registry.md`: moved `fw-build-runner` from planned to MVP skills.
- `skills/fw-auto/SKILL.md`: added routing for compile/rebuild/flash/build-flash requests.
- `skills/fw-verify/SKILL.md`: added handoff to `fw-build-runner` for verification evidence.
- `firmware-auto-architecture-dev-skills-style.md`: updated `fw-build-runner` responsibility.

Artifact impact:

- Added skill-system version decision for the global build/flash runner.

Migration notes:

- This is compatible because it adds a new implemented skill without changing existing skill behavior.
- Use `fw-build-runner` before `fw-verify` when build or flash evidence is required.

## 0.4.0 - Prepare Git repository structure

Version impact: Minor

Reason:

- Organized the firmware skills architecture as a GitHub-ready repository.
- Added repository hygiene, contribution instructions, local validation, and CI validation.

Added files:

- `.gitignore`
- `AGENTS.md.template`
- `CONTRIBUTING.md`
- `scripts/validate-skills.ps1`
- `.github/workflows/validate-skills.yml`

Changed files:

- `README.md`: added Git usage, upload commands, and CI explanation.
- `references/skill-registry.md`: bumped architecture version.

Artifact impact:

- Added skill-system version decision for repository preparation.

Migration notes:

- This is compatible because it adds repository tooling and documentation without changing skill behavior or artifact schemas.
- Run `.\scripts\validate-skills.ps1` before pushing.

## 0.3.0 - Create MVP skill files

Version impact: Minor

Reason:

- Converted the MVP firmware skill architecture into actual `skills/*/SKILL.md` files.
- Added reference documents used by the MVP skills.
- Added skill-system governance artifacts for this change.

Added skill files:

- `skills/fw-auto/SKILL.md`
- `skills/fw-project-discovery/SKILL.md`
- `skills/fw-project-brief/SKILL.md`
- `skills/fw-intake/SKILL.md`
- `skills/fw-feature-iterate/SKILL.md`
- `skills/fw-verify/SKILL.md`
- `skills/fw-finish/SKILL.md`
- `skills/fw-skill-governance/SKILL.md`

Added references:

- `references/fw-baseline.md`
- `references/artifact-schema.md`
- `references/versioning-policy.md`
- `references/skill-registry.md`
- `references/terminal-status.md`

Artifact impact:

- Added `.codex/artifacts/firmware/skill-system/skill-changelog.md`.
- Added `.codex/artifacts/firmware/skill-system/version-decision-create-mvp-skills.md`.

Migration notes:

- This is compatible because it adds the first usable skill files without breaking previous docs.
- Planned skills still need implementation.

## 0.2.0 - Add handoff brief and skill governance

Version impact: Minor

Reason:

- Added a project handoff skill so future maintainers or agents can quickly understand a firmware project.
- Added a skill governance skill so additions and changes to the skill stack are recorded and versioned.

Added skills:

- `fw-project-brief`: generates and maintains a human-facing project brief.
- `fw-skill-governance`: records skill additions, removals, behavior changes, artifact impacts, and semantic version decisions.

Affected workflows:

- New project: create or update project brief after scaffold and discovery.
- Feature iteration: create brief when missing or stale; refresh it when behavior, usage, architecture, commands, or risk areas change.
- Refactor: create brief when missing or stale; refresh it when architecture or usage changes.
- Skill-system maintenance: route through governance before changing skills, README, registry, baseline rules, or user-facing workflow behavior.

Artifact impact:

- Added optional/recommended project artifact: `.codex/artifacts/firmware/brief/project-brief.md`.
- Added skill-system artifacts:
  - `.codex/artifacts/firmware/skill-system/skill-registry.md`
  - `.codex/artifacts/firmware/skill-system/skill-changelog.md`
  - `.codex/artifacts/firmware/skill-system/version-decision-<slug>.md`

Migration notes:

- Existing flows can still operate with discovery -> intake -> implementation.
- For better handoff, run `fw-project-brief` after first discovery and after meaningful project changes.
- Future skill changes must classify version impact as Major, Minor, or Patch.

## 0.1.0 - Initial firmware skill map

Version impact: Minor

Reason:

- Created the first architecture map for firmware automation skills.

Included workflows:

- New firmware project.
- Existing project feature iteration.
- Existing project refactor.

Included initial shared skills:

- Logging.
- Change recording.
- Project discovery.
- Build running.
- Test running.
- Config audit.
- Interface map.
- Hardware profile.
- Regression guard.
