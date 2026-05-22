---
name: fw-project-brief
description: Generate or refresh a human-facing handoff brief for a firmware project. Use when the user wants to understand what the current firmware project does, how to build/flash/use it, what features exist, where to modify it, or when project discovery, new project setup, feature iteration, or refactor needs an up-to-date onboarding summary for the next maintainer or agent.
---

# Firmware Project Brief

Write a concise handoff brief for humans and future agents.

Prefer reading existing discovery artifacts first:

- `.codex/artifacts/firmware/maps/project-map.md`
- `.codex/artifacts/firmware/maps/hardware-map.md`
- `.codex/artifacts/firmware/maps/interface-map.md`

If maps are missing, inspect README, docs, build files, config files, scripts, and source layout enough to write a useful brief. Recommend `fw-project-discovery` if facts are too thin.

## Output

Write or update:

`.codex/artifacts/firmware/brief/project-brief.md`

## Required Sections

```md
# Project Brief

## One-Sentence Purpose

## Target Hardware

## Core Functions

## Startup And Runtime Flow

## Architecture Overview

## Build, Flash, Monitor, And Debug

## Configuration Entrypoints

## Test And Verification

## Common Modification Entrypoints

## Risk Areas

## Unknowns
```

## Style

- Be readable, not exhaustive.
- Separate facts from inferences.
- Include exact commands only when found in the project or confidently inferred from standard project files.
- Call out stale or missing information.
- Refresh the brief after meaningful changes to purpose, behavior, architecture, commands, or risk areas.
