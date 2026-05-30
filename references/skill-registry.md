# Firmware Skill Registry

Current architecture version: `0.7.0`

## MVP Skills

| Skill | Responsibility | Primary output |
|---|---|---|
| `fw-auto` | Recommend the next firmware skill and recovery path | Recommendation message |
| `fw-project-discovery` | Discover project facts, build system, target, layout, configs, tests, interfaces | `maps/*.md` |
| `fw-project-brief` | Write a human-facing project handoff brief | `brief/project-brief.md` |
| `fw-intake` | Structure unclear firmware requests and constraints | `intake/<slug>.md` |
| `fw-feature-iterate` | Implement focused behavior changes in existing firmware projects | `changes/<slug>.md` |
| `fw-build-runner` | Compile, rebuild, flash, or build-and-flash firmware across one or more project entrypoints, including Keil MDK/uVision | `verification/<slug>.md` |
| `fw-output-sanity-check` | Check generated files/code for mojibake, malformed structure, invalid skill frontmatter, and obvious output corruption | Sanity check result |
| `fw-verify` | Collect completion evidence for firmware work | `verification/<slug>.md` |
| `fw-finish` | Summarize final status, evidence, risks, and refs | `finish/<slug>.md` |
| `fw-skill-governance` | Record and version skill-system changes | `skill-system/*.md` |

## Planned Skills

| Skill | Responsibility |
|---|---|
| `fw-arch-plan` | Produce architecture plans for complex firmware work |
| `fw-new-project` | Create new firmware project skeletons |
| `fw-refactor` | Refactor firmware while preserving behavior |
| `fw-debug-fix` | Run hypothesis-driven firmware debugging |
| `fw-review` | Perform firmware-specific code review |
| `fw-logbook` | Maintain chronological workflow logs |
| `fw-change-record` | Record firmware project changes |
