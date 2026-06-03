# Codex Firmware Skills

Current architecture version: `0.7.1`

Reusable Codex skills for firmware automation: project discovery, handoff briefs, feature iteration, Keil-aware build/flash workflows, verification, skill governance, and generated-output sanity checks.

## What Is Ready

The following skills are implemented and validated:

| Skill | Purpose |
|---|---|
| `fw-auto` | Recommend the next firmware workflow skill. |
| `fw-project-discovery` | Inspect an existing firmware project and generate project maps. |
| `fw-project-brief` | Generate a human-readable handoff brief for maintainers or future agents. |
| `fw-intake` | Turn unclear firmware requirements into structured inputs. |
| `fw-feature-iterate` | Implement focused behavior changes in an existing firmware project. |
| `fw-build-runner` | Build, rebuild, flash, or build-and-flash firmware, including Keil MDK/uVision projects. |
| `fw-output-sanity-check` | Check generated files for mojibake, malformed Markdown, invalid skill frontmatter, and obvious corruption. |
| `fw-verify` | Collect firmware verification evidence before claiming work is ready. |
| `fw-finish` | Summarize final status, changes, evidence, risks, and artifact refs. |
| `fw-skill-governance` | Record skill-system changes and semantic version decisions. |

## Planned Skills

These are referenced by the architecture but are not implemented yet:

| Skill | Planned Purpose |
|---|---|
| `fw-arch-plan` | Produce architecture plans for complex firmware work. |
| `fw-new-project` | Create new firmware project skeletons. |
| `fw-refactor` | Refactor firmware while preserving behavior. |
| `fw-debug-fix` | Run hypothesis-driven firmware debugging from field data. |
| `fw-review` | Perform firmware-specific code review. |
| `fw-logbook` | Maintain chronological workflow logs. |
| `fw-change-record` | Record firmware project changes. |
| `fw-regression-guard` | Define behavior-preservation checks for risky changes. |

## Repository Layout

```text
.
  README.md
  CHANGELOG.md
  CONTRIBUTING.md
  AGENTS.md.template
  .github/workflows/validate-skills.yml
  references/
  scripts/
  skills/
```

Important folders:

- `skills/`: implemented Codex skills.
- `references/`: shared workflow policies, artifact schema, build/flash profiles, and versioning rules.
- `scripts/`: local validation scripts.
- `.codex/artifacts/firmware/skill-system/`: governance records for skill-system changes.

## Install Locally

Clone the repository:

```powershell
git clone https://github.com/arvin-li-code/codex-firmware-skills.git
cd codex-firmware-skills
```

Install the implemented skills into Codex:

```powershell
Copy-Item -Path .\skills\fw-* -Destination $HOME\.codex\skills -Recurse -Force
```

Restart or open a new Codex session so the newly installed skills can be discovered.

## Validate

Run these checks before using or publishing changes:

```powershell
.\scripts\validate-skills.ps1
.\scripts\check-generated-output.ps1
```

The checks verify:

- Every `skills/*/SKILL.md` has valid frontmatter.
- Skill `name` matches the folder name.
- Generated text files do not contain obvious mojibake or NUL bytes.
- Markdown code fences are balanced.
- Skill files are structurally valid.

GitHub Actions runs the same validation on push and pull request.

## Typical Existing-Project Workflow

Use this workflow first. It is the currently supported MVP path:

```text
fw-auto
-> fw-project-discovery
-> fw-project-brief
-> fw-intake
-> fw-feature-iterate
-> fw-build-runner
-> fw-output-sanity-check
-> fw-verify
-> fw-finish
```

Example prompts:

```text
Use fw-project-discovery to understand this firmware project.
```

```text
Use fw-project-brief to generate a handoff brief for this project.
```

```text
Use fw-feature-iterate to add: <feature request>.
Only make the focused behavior change. Do not perform unrelated refactor.
```

```text
Use fw-build-runner to build and flash this Keil project.
If there are multiple .uvprojx targets, ask me before flashing.
```

```text
Use fw-verify to collect build/test/flash evidence and skipped-check reasons.
```

```text
Use fw-finish to summarize changes, verification evidence, residual risk, and suggested commit message.
```

## Build And Flash Support

`fw-build-runner` supports these modes:

| Mode | Meaning |
|---|---|
| `build` | Compile without forcing a clean rebuild. |
| `rebuild` | Clean or force rebuild, then compile. |
| `flash` | Program the target without rebuilding unless required by the tool. |
| `build-flash` | Build first, then flash only if build succeeds. |

Supported profiles include:

- Keil MDK/uVision: `.uvprojx`, `.uvproj`, `.uvoptx`, `.uvopt`.
- ESP-IDF: `idf.py`.
- Zephyr: `west`.
- PlatformIO: `pio`.
- CMake, Ninja, Make.
- STM32Cube/vendor SDK projects.
- Custom build/flash scripts.

For Keil projects, the runner must confirm project file, target, board, and debug adapter before flashing.

## Generated Output Safety

Use `fw-output-sanity-check` after Codex generates or edits files.

For this repository, run:

```powershell
.\scripts\check-generated-output.ps1
```

This is intended to catch common problems such as mojibake, broken Markdown fences, invalid skill frontmatter, and corrupted generated files before committing or publishing.

## Artifacts

Firmware workflows should store handoff data under:

```text
.codex/artifacts/firmware/
```

Common artifact paths:

```text
.codex/artifacts/firmware/maps/project-map.md
.codex/artifacts/firmware/maps/hardware-map.md
.codex/artifacts/firmware/maps/interface-map.md
.codex/artifacts/firmware/brief/project-brief.md
.codex/artifacts/firmware/intake/<slug>.md
.codex/artifacts/firmware/changes/<slug>.md
.codex/artifacts/firmware/verification/<slug>.md
.codex/artifacts/firmware/finish/<slug>.md
```

## Versioning

Skill-system changes use semantic versioning:

- Major: breaking routing, required artifact schema, terminal-status meaning, or skill names.
- Minor: compatible new skill, optional artifact, optional workflow branch, or new supported framework.
- Patch: wording, examples, trigger clarification, or typo fixes without behavior/schema changes.

Use `fw-skill-governance` when adding, removing, renaming, or changing a skill.

## Documentation

- [Architecture](./firmware-auto-architecture-dev-skills-style.md)
- [Original Skill Map](./firmware-skill-map.md)
- [Build And Flash Profiles](./references/build-flash-profiles.md)
- [Skill Registry](./references/skill-registry.md)
- [Versioning Policy](./references/versioning-policy.md)
- [Contributing](./CONTRIBUTING.md)
