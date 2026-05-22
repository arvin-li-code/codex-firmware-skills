# Contributing

This repository is organized like a small skill system, not a single large prompt.

## Adding Or Changing A Skill

Use `fw-skill-governance` rules:

1. Add or edit `skills/<skill-name>/SKILL.md`.
2. Keep frontmatter to only:
   - `name`
   - `description`
3. Update `references/skill-registry.md`.
4. Update `README.md` if user-facing routing or workflow behavior changed.
5. Update `CHANGELOG.md`.
6. Add or update `.codex/artifacts/firmware/skill-system/version-decision-<slug>.md` when the version impact is not obvious.
7. Run local validation:

```powershell
.\scripts\validate-skills.ps1
```

## Skill Design Rules

- One skill, one responsibility.
- Keep `SKILL.md` concise and operational.
- Move shared policies into `references/`.
- Prefer artifact handoff over hidden chat context.
- Use terminal statuses for blocked or gated flows.

## Versioning

Use semantic versioning:

- Major for breaking workflow, routing, artifact schema, or terminal-status changes.
- Minor for compatible new skills or optional capabilities.
- Patch for compatible clarification and correction.
