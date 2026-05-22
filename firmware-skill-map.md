# Firmware Auto-Iteration Skill Map

## 0. Core Goal

Build a skill system for firmware automation that can safely guide Codex through three independent macro workflows:

1. Create a new firmware project.
2. Iterate features in an existing firmware project.
3. Refactor features in an existing firmware project.

The three macro workflows must not pollute each other. They may call shared small skills as tools, but each macro workflow owns its own decision path, acceptance criteria, rollback strategy, and artifact structure.

## 1. Architecture Principles

- Keep the top-level firmware skill as an orchestrator, not a giant implementation manual.
- Split reusable operations into small tool skills with narrow responsibilities.
- Require logging and change recording in all three macro workflows.
- Prefer inspect -> plan -> execute -> verify -> record over direct editing.
- Treat build success as insufficient. Firmware changes also need interface, resource, timing, hardware, and regression checks where applicable.
- Separate project creation, feature iteration, and refactor logic to prevent accidental assumptions crossing boundaries.
- Make every step resumable from artifacts: logs, maps, plans, diffs, test results, and change records.
- Keep a human-facing project brief current enough for a new maintainer or agent to take over quickly.
- Record every skill-system change and classify whether it is a major, minor, or patch version change.

## 2. Proposed Skill Layers

### 2.1 Top-Level Orchestrator

Skill name candidate: `firmware-auto-iterate`

Responsibility:

- Classify user intent into one of the three macro workflows.
- Load only the relevant macro flow reference.
- Call common tool skills when needed.
- Enforce logging, change recording, and verification gates.
- Stop and ask only when hardware target, SDK, board, toolchain, or acceptance criteria are unknowable.

Suggested structure:

```text
firmware-auto-iterate/
  SKILL.md
  references/
    workflow-new-project.md
    workflow-feature-iteration.md
    workflow-refactor.md
    tool-skill-map.md
    artifact-schema.md
```

### 2.2 Macro Workflow Skills

These may either be separate skills or reference files behind the top-level orchestrator.

Recommended as separate skills once the process grows:

- `firmware-new-project`
- `firmware-feature-iterate`
- `firmware-refactor`

Each macro skill should:

- Own its own workflow.
- Define required inputs.
- Define exit criteria.
- Define allowed and forbidden edits.
- Invoke shared tool skills.
- Emit logs and change records.

### 2.3 Small Tool Skills

Small skills should be callable by all macro flows.

Recommended first wave:

- `firmware-logbook`
- `firmware-change-record`
- `firmware-project-discovery`
- `firmware-project-brief`
- `firmware-build-runner`
- `firmware-test-runner`
- `firmware-config-auditor`
- `firmware-interface-map`
- `firmware-hardware-profile`
- `firmware-regression-guard`

Recommended second wave:

- `firmware-rtos-task-map`
- `firmware-driver-map`
- `firmware-memory-audit`
- `firmware-power-audit`
- `firmware-bootloader-map`
- `firmware-ota-update-map`
- `firmware-protocol-analyzer`
- `firmware-pinmux-auditor`
- `firmware-ci-integrator`
- `firmware-release-note`
- `firmware-skill-governance`

## 3. Shared Artifact Model

All macro workflows should create or update artifacts under a project-local directory.

Suggested path:

```text
.codex/firmware/
  session-log.md
  project-map.md
  project-brief.md
  change-record.md
  verification-report.md
  risks.md
  decisions.md
  skill-system/
    skill-registry.md
    skill-changelog.md
    version-decisions.md
  workflows/
    new-project/
    feature-iteration/
    refactor/
```

Minimum required artifacts:

- `session-log.md`: chronological notes of actions, commands, findings, blockers.
- `project-map.md`: architecture, board, toolchain, modules, interfaces, build/test commands.
- `project-brief.md`: human-facing handoff summary explaining purpose, functions, architecture, usage, commands, risks, and common modification entrypoints.
- `change-record.md`: exact behavioral and code changes, changed files, rationale.
- `verification-report.md`: commands run, results, failures, skipped checks, residual risk.
- `decisions.md`: assumptions, user choices, tradeoffs, rejected options.
- `skill-system/skill-changelog.md`: records additions, removals, and behavior changes in the skill stack.
- `skill-system/version-decisions.md`: records major/minor/patch decisions for skill-system changes.

## 4. Macro Flow A: New Firmware Project

Purpose:

Create a new firmware project from scratch or from a template while preserving a clear architecture map from day one.

Required inputs:

- Target MCU or board.
- SDK/framework/toolchain, if known.
- Project purpose.
- Required peripherals and protocols.
- Build environment expectations.
- Minimum verification target.

Flow:

1. Intake and target classification.
   - Identify MCU, board, SDK, RTOS/bare-metal, language, build system.
   - If missing, ask only for blocking target choices.

2. Architecture scaffold.
   - Define firmware layers.
   - Define module boundaries.
   - Define hardware abstraction strategy.
   - Define configuration ownership.

3. Project skeleton creation.
   - Create build files.
   - Create source tree.
   - Create board/config files.
   - Create initial drivers or stubs.
   - Add README only if the user explicitly asks; skill artifacts should live under `.codex/firmware/`.

4. Baseline build.
   - Run formatting if present.
   - Run build.
   - Capture errors in log.
   - Fix setup issues only within the new project scope.

5. Minimal firmware behavior.
   - Implement a first verifiable behavior, such as blink, serial hello, test shell, or boot banner.
   - Keep behavior aligned with target constraints.

6. Verification and recording.
   - Run build/test checks.
   - Update project map.
   - Create or update project brief.
   - Write change record.
   - Write verification report.

Exit criteria:

- Project builds or has a documented external blocker.
- Architecture map exists.
- Project brief exists.
- Toolchain/build commands are recorded.
- First behavior is implemented or intentionally stubbed.
- Change record and verification report are complete.

## 5. Macro Flow B: Feature Iteration in Existing Project

Purpose:

Add, modify, or extend firmware functionality in an existing project without damaging existing architecture or hidden hardware assumptions.

Required inputs:

- User-requested feature or behavioral change.
- Existing project path.
- Acceptance criteria or expected behavior.
- Hardware target, if not discoverable.

Flow:

1. Project discovery.
   - Read existing build files, source layout, configs, board files, tests, CI, and docs.
   - Update or create `project-map.md`.

2. Project brief check.
   - If no handoff brief exists, create `project-brief.md`.
   - If the requested feature changes project purpose, usage, architecture, commands, or risk areas, mark the brief as stale.

3. Requirement framing.
   - Convert request into behavior, interfaces, constraints, and non-goals.
   - Identify affected modules and external contracts.

4. Impact map.
   - Map call paths, drivers, tasks, interrupts, protocols, config flags, memory impact, and tests.
   - Mark unknowns and assumptions.

5. Implementation plan.
   - Choose the smallest architecture-consistent change.
   - Identify files to edit.
   - Identify verification gates.

6. Change execution.
   - Edit only affected modules.
   - Preserve existing style and ownership boundaries.
   - Add focused tests, mocks, or compile-time checks where feasible.

7. Verification.
   - Run relevant build/test commands.
   - Run static checks or config validation if available.
   - Record skipped hardware checks explicitly.

8. Change recording.
   - Update change record.
   - Update project map if architecture changed.
   - Update project brief if purpose, usage, architecture, commands, or risk areas changed.
   - Update verification report.

Exit criteria:

- Feature is implemented or blocked with a specific reason.
- Affected interfaces and modules are recorded.
- Project brief exists and is current enough for handoff.
- Existing behavior risk is assessed.
- Build/test results are recorded.
- User can continue from the artifact trail.

## 6. Macro Flow C: Refactor Existing Project

Purpose:

Improve structure, maintainability, boundaries, or internal implementation while preserving behavior.

Required inputs:

- Refactor target.
- Reason for refactor.
- Behavior that must remain unchanged.
- Existing project path.

Flow:

1. Baseline capture.
   - Discover project.
   - Create or refresh project brief if missing or stale.
   - Run existing build/tests before editing.
   - Record current failures separately from introduced failures.

2. Behavior lock.
   - Identify observable behavior, public APIs, hardware interfaces, timing-sensitive paths, configs, and binary/interface expectations.
   - Add or identify regression checks when feasible.

3. Refactor scope map.
   - Define exact modules/files in scope.
   - Define forbidden changes.
   - Define migration sequence.

4. Incremental refactor.
   - Make small behavior-preserving steps.
   - Prefer mechanical moves before semantic cleanup.
   - Verify between risky steps when possible.

5. Compatibility verification.
   - Build and test.
   - Compare interfaces/config outputs where feasible.
   - Check timing, memory, protocol, and startup risks if applicable.

6. Change recording.
   - Distinguish structural changes from behavior changes.
   - Update project brief if module boundaries, architecture, build/debug flow, or risk areas changed.
   - If behavior changed, reclassify as feature iteration or ask for confirmation.

Exit criteria:

- Behavior preservation is verified or residual risk is explicit.
- Refactor scope is documented.
- Project brief is current if architecture or usage changed.
- Build/test status is recorded.
- Any intentional behavior changes are separated from refactor claims.

## 7. Common Tool Skill Map

### 7.1 `firmware-logbook`

Purpose:

Maintain a chronological, resumable execution log.

Inputs:

- Current workflow name.
- Action taken.
- Command run.
- Finding or blocker.

Outputs:

- Appended `session-log.md`.

Used by:

- All macro workflows.

### 7.2 `firmware-change-record`

Purpose:

Record exact change points and rationale.

Inputs:

- Changed files.
- User request.
- Implementation summary.
- Behavior impact.
- Verification result.

Outputs:

- Updated `change-record.md`.

Used by:

- All macro workflows.

### 7.3 `firmware-project-discovery`

Purpose:

Identify project type, toolchain, architecture, build commands, tests, board configs, and module map.

Outputs:

- Updated `project-map.md`.
- List of build/test commands.
- List of uncertainty points.

Used by:

- Existing feature iteration.
- Refactor.
- New project after scaffold creation.

### 7.4 `firmware-build-runner`

Purpose:

Run or infer build commands safely.

Outputs:

- Build result summary.
- Error classification.
- Build command record.

Used by:

- All macro workflows.

### 7.5 `firmware-project-brief`

Purpose:

Generate and maintain a human-facing handoff brief so a new maintainer or agent can quickly understand the firmware project.

Inputs:

- `project-map.md`
- `hardware-map.md`, if present.
- `interface-map.md`, if present.
- README, docs, build files, config files, source layout, tests, and known artifacts.

Outputs:

- Updated `project-brief.md`.

The brief should explain:

- What the project does.
- Target hardware and runtime environment.
- Main functions and how they are used.
- Startup/runtime flow.
- Important modules and ownership.
- Build, flash, monitor, debug, and test commands.
- Configuration entrypoints.
- Common modification entrypoints.
- Risk areas and unknowns.

Used by:

- New project after scaffold/discovery.
- Existing feature iteration before and after meaningful behavior or usage changes.
- Refactor before work starts and after architecture changes.

### 7.6 `firmware-test-runner`

Purpose:

Run unit tests, simulation tests, host tests, HIL tests, or CI-like checks where available.

Outputs:

- Test result summary.
- Skipped test explanation.

Used by:

- Feature iteration.
- Refactor.
- New project when tests exist.

### 7.7 `firmware-config-auditor`

Purpose:

Audit Kconfig, defconfig, CMake options, board config, linker scripts, partition tables, or generated config.

Used by:

- All macro workflows, especially feature work touching peripherals, memory, boot, OTA, or build flags.

### 7.8 `firmware-interface-map`

Purpose:

Map public APIs, driver boundaries, protocol contracts, message formats, callbacks, ISR/task interactions, and external interfaces.

Used by:

- Feature iteration.
- Refactor.

### 7.9 `firmware-hardware-profile`

Purpose:

Record board, MCU, pin usage, clock tree, memory map, peripherals, sensors, buses, and flashing/debug method.

Used by:

- New project.
- Feature iteration touching hardware.
- Refactor touching drivers or board config.

### 7.10 `firmware-regression-guard`

Purpose:

Define and run behavior-preservation checks for risky changes.

Used by:

- Refactor.
- Feature iteration with high blast radius.

### 7.11 `firmware-skill-governance`

Purpose:

Record and version changes to the firmware skill system itself.

Use when:

- Adding a skill.
- Removing a skill.
- Renaming a skill.
- Changing a skill trigger.
- Changing an artifact schema.
- Changing macro workflow order.
- Changing terminal status meaning.
- Updating README, registry, or baseline rules in a user-facing way.

Outputs:

- Updated `skill-system/skill-registry.md`.
- Updated `skill-system/skill-changelog.md`.
- Updated `skill-system/version-decisions.md`.
- Updated README or architecture docs when the change affects user-facing workflows.

Version rules:

- Major: breaking change, such as removing/renaming a skill, changing required artifact paths, changing terminal status meaning, or making an optional gate mandatory.
- Minor: compatible capability, such as adding an optional skill, adding an optional artifact, or adding a skippable verification check.
- Patch: compatible correction, such as wording clarification, trigger examples, or documentation cleanup without routing/schema changes.

## 8. Isolation Rules Between Macro Workflows

New project workflow must not:

- Assume existing legacy behavior.
- Run migration/refactor logic.
- Create compatibility burdens unless user requests them.

Feature iteration workflow must not:

- Perform broad architecture cleanup unless required.
- Rename modules opportunistically.
- Change unrelated configs.

Refactor workflow must not:

- Add features silently.
- Change public behavior without confirmation.
- Treat build success as proof of behavior preservation.

All workflows must:

- Log actions.
- Record changes.
- Create or refresh a project brief when project understanding, usage, architecture, or risk areas change.
- Preserve user changes.
- Verify or document blockers.
- Keep artifacts under their workflow-specific directory when details are lengthy.

Skill-system changes must:

- Use `firmware-skill-governance`.
- Update the skill registry.
- Record the version impact.
- Update README and architecture docs when routing, workflows, or user-facing behavior changes.

## 9. Suggested Trigger Classification

Use new project workflow when the user says:

- "新建固件项目"
- "从零搭一个"
- "创建一个 ESP32/STM32/nRF 项目"
- "帮我初始化 firmware"

Use feature iteration workflow when the user says:

- "加一个功能"
- "让现有固件支持..."
- "把这个驱动接进去"
- "改一下协议/上报/控制逻辑"

Use refactor workflow when the user says:

- "重构"
- "整理架构"
- "拆模块"
- "把驱动层抽出来"
- "不改变行为地优化"

If classification is ambiguous:

- Prefer feature iteration when behavior changes.
- Prefer refactor only when behavior preservation is explicit.
- Prefer new project only when no existing project is involved.

## 10. Build Order for the Skill System

Recommended implementation sequence:

1. Create `firmware-auto-iterate` as the top-level orchestrator.
2. Create shared artifact schema reference.
3. Create `firmware-logbook`.
4. Create `firmware-change-record`.
5. Create `firmware-project-discovery`.
6. Create `firmware-project-brief`.
7. Create `firmware-skill-governance`.
8. Create `firmware-build-runner`.
9. Implement macro flow B: existing project feature iteration.
10. Implement macro flow C: refactor.
11. Implement macro flow A: new project.
12. Add hardware/config/interface/regression helper skills.

Reason:

Existing-project feature iteration exercises discovery, logging, change recording, build, verification, and architecture mapping. It is the best first vertical slice.

## 11. Minimum Viable Skill Set

For the first usable version, build only:

- `firmware-auto-iterate`
- `firmware-logbook`
- `firmware-change-record`
- `firmware-project-discovery`
- `firmware-project-brief`
- `firmware-build-runner`
- `firmware-skill-governance`

This gives a resumable loop:

```text
classify request
-> discover or scaffold
-> brief project for handoff
-> plan affected area
-> edit
-> build
-> log
-> record changes
-> record skill-system changes when the skill stack changes
-> report next step
```

## 12. Next Writing Targets

Continue by writing these files in order:

1. `firmware-auto-iterate/SKILL.md`
2. `firmware-auto-iterate/references/artifact-schema.md`
3. `firmware-auto-iterate/references/tool-skill-map.md`
4. `firmware-auto-iterate/references/workflow-feature-iteration.md`
5. `firmware-logbook/SKILL.md`
6. `firmware-change-record/SKILL.md`
7. `firmware-project-discovery/SKILL.md`
8. `firmware-build-runner/SKILL.md`
9. `firmware-project-brief/SKILL.md`
10. `firmware-skill-governance/SKILL.md`

Pause point:

After this map, continue by drafting `firmware-auto-iterate/SKILL.md` as a concise orchestrator that routes to the three macro workflows and requires log/change-record gates.
