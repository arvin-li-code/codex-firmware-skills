---
name: fw-output-sanity-check
description: Global generated-output sanity checker. Use after Codex creates or edits files, code, Markdown, skill files, scripts, configs, or artifacts to verify that the generated output is readable, not mojibake/garbled, structurally valid, and consistent with the requested purpose before claiming completion.
---

# Firmware Output Sanity Check

Run this as a global quality gate after generating or editing files.

This skill is not tied to one firmware workflow. Use it after any file/code generation, especially:

- `SKILL.md` files.
- Markdown docs.
- Scripts.
- Build/flash profiles.
- Artifact templates.
- Generated source code or config files.

## Workflow

1. Identify the files created or edited in the current turn.
2. Re-read those files from disk.
3. Check for obvious corruption:
   - Mojibake patterns such as `鍥`, `涓`, `绋`, `�`, `ï¿½`, `Ã`, `Â`.
   - Unexpected NUL bytes.
   - Broken headings, tables, or code fences.
   - Truncated frontmatter.
   - Missing required sections.
4. Check structure:
   - `SKILL.md` files must have valid `name` and `description` frontmatter.
   - Skill `name` should match the folder name.
   - Markdown code fences should be balanced.
   - Links and file paths should be plausible.
5. Check intent:
   - The generated content should match the user request.
   - The document should not contradict registry, README, or changelog.
   - New global rules should be reflected in the relevant global docs.
6. If a deterministic checker exists, run it.
7. Fix issues before final response.

## Recommended Commands

For this repository:

```powershell
.\scripts\validate-skills.ps1
.\scripts\check-generated-output.ps1
```

When this skill is installed outside this repository, use the bundled script relative to the skill folder:

```powershell
.\scripts\check-generated-output.ps1
```

For a narrow check:

```powershell
.\scripts\check-generated-output.ps1 -Path <file-or-directory>
```

## Output

In the final response, mention:

- Whether generated-output sanity check passed.
- Any files fixed because of the check.
- Any checks that could not run.

## Guardrails

- Do not rely on console rendering alone to prove encoding correctness.
- If the shell displays suspicious mojibake, inspect the file contents again and fix if the file itself is corrupted.
- Do not ignore a checker failure unless it is a false positive and the reason is documented.
- Run this before committing generated skill files or documentation.
