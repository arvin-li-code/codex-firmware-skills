# Skill-System Versioning Policy

Use semantic versioning for the firmware skill stack:

```text
MAJOR.MINOR.PATCH
```

## Major

Use Major for breaking changes:

- Remove a skill.
- Rename a skill.
- Change a skill trigger in a way that reroutes existing requests.
- Change required artifact paths or schemas.
- Change terminal status meaning.
- Make a previously optional gate mandatory.
- Change macro workflow order in a way that invalidates existing instructions.

## Minor

Use Minor for compatible new capability:

- Add an optional skill.
- Add a supported framework, SDK, or workflow branch.
- Add an optional artifact section.
- Add a skippable verification check.
- Add a recommended handoff or governance step that does not block old flows.

## Patch

Use Patch for compatible corrections:

- Clarify wording.
- Fix examples.
- Add trigger examples.
- Tighten non-routing safety guidance.
- Correct typos without changing behavior.

## Required Record

Every skill-system change must record:

- Version impact.
- Previous and next version.
- Changed skills.
- Reason.
- Affected workflows.
- Artifact impact.
- Migration notes.
