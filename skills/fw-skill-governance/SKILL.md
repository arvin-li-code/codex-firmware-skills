---
name: fw-skill-governance
description: Govern changes to the firmware skill system. Use when adding, removing, renaming, or changing a skill, changing trigger descriptions, workflow order, artifact schema, terminal statuses, README, registry, baseline rules, version policy, or any user-facing skill behavior.
---

# Firmware Skill Governance

Record and version skill-system changes before considering them complete.

Read:

- `references/versioning-policy.md`
- `references/skill-registry.md`
- `README.md`
- `firmware-auto-architecture-dev-skills-style.md`
- Relevant `skills/*/SKILL.md`

## Workflow

1. Identify what changed:
   - Added skill.
   - Removed skill.
   - Renamed skill.
   - Trigger changed.
   - Workflow changed.
   - Artifact schema changed.
   - Terminal status changed.
   - Documentation changed.
2. Classify version impact as Major, Minor, or Patch.
3. Update the skill registry.
4. Update README or architecture docs when user-facing behavior changed.
5. Write a skill changelog entry.
6. Write a version decision artifact when the impact is not obvious.

## Outputs

- `.codex/artifacts/firmware/skill-system/skill-changelog.md`
- `.codex/artifacts/firmware/skill-system/version-decision-<slug>.md`
- Updated `references/skill-registry.md`
- Updated `README.md` when needed
- Updated architecture docs when needed

## Version Decision Template

```md
# Skill Version Decision: <title>

## Version Impact
MAJOR | MINOR | PATCH

## Previous Version

## Next Version

## Changed Skills

## Reason

## Affected Workflows

## Artifact Impact

## Migration Notes
```

## Rules

- New optional skill is usually Minor.
- Breaking routing, required artifact schema, skill names, or terminal status meaning is Major.
- Clarification without behavior change is Patch.
- Do not let skill docs and `references/skill-registry.md` drift.
