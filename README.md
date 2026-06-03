# Codex Firmware Skills

> Reusable Codex skills for firmware automation: project discovery, handoff briefs, feature iteration, Keil-aware build/flash workflows, verification, governance, and generated-output sanity checks.

> 一套可复用的 Codex 固件自动化 skills：支持项目理解、交接简报、已有项目功能迭代、Keil 编译烧录、验证收尾、skill 治理和生成物自检。

![version](https://img.shields.io/badge/version-0.7.2-blue)
![skills](https://img.shields.io/badge/skills-10-success)
![platform](https://img.shields.io/badge/platform-Codex-111827)
![firmware](https://img.shields.io/badge/domain-firmware-orange)

当前版本 / Current version: `0.7.2`

---

## What This Is / 这是什么

`codex-firmware-skills` is a lightweight workflow skill set for using Codex on firmware projects.

`codex-firmware-skills` 是一套让 Codex 更稳定处理固件项目的工作流 skills。它不是一个单独的大 prompt，而是一组单职责 skill，用 artifact 把项目理解、功能迭代、编译烧录、验证和收尾串起来。

It helps with:

- Understanding an existing firmware project before editing.
- Generating a handoff brief for the next human or agent.
- Iterating focused behavior changes without unrelated refactor.
- Running build/rebuild/flash/build-flash workflows, including Keil MDK/uVision.
- Capturing verification evidence before claiming completion.
- Checking generated files for mojibake, malformed Markdown, and broken skill frontmatter.

它主要解决这些问题：

- 还没理解项目结构就开始改代码。
- 接手人不知道固件项目是干什么的、怎么编译烧录、功能入口在哪里。
- 改功能时顺手动了无关模块。
- 编译通过就误以为验证完成。
- 生成 Markdown、skill 或代码时偶发乱码，没人复查。

第一次使用只记住一句话：

> 不知道下一步做什么，就先用 `fw-auto`。它只会推荐下一步，不会自动替你执行其他 skill。

---

## Quick Start / 快速开始

Clone and install:

```powershell
git clone https://github.com/arvin-li-code/codex-firmware-skills.git
cd codex-firmware-skills
Copy-Item -Path .\skills\fw-* -Destination $HOME\.codex\skills -Recurse -Force
```

Then restart or open a new Codex session.

然后重启或新开一个 Codex 会话，让 Codex 重新发现这些 skills。

Validate locally:

```powershell
.\scripts\validate-skills.ps1
.\scripts\check-generated-output.ps1
```

---

## Common Paths / 常用路径

### Existing Project Understanding / 了解已有固件项目

```text
fw-project-discovery -> fw-project-brief
```

Use when you want Codex to understand what a firmware project does, where the important modules are, how to build/flash it, and where business logic lives.

当你想知道“这个固件项目是干什么的、功能逻辑在哪里、如何编译烧录、接手时要注意什么”，先走这条。

Example:

```text
Use fw-project-discovery to understand this firmware project.
Then use fw-project-brief to generate a handoff brief.
```

### Existing Project Feature Iteration / 已有项目功能迭代

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

Use when adding or changing a focused behavior in an existing firmware project.

用于“给已有固件项目加功能、改行为、接一个驱动入口、改协议处理”等场景。

Example:

```text
Use fw-feature-iterate to add a UART command: version.
Only make the focused behavior change. Do not perform unrelated refactor.
```

### Build / Rebuild / Flash / 编译烧录

```text
fw-build-runner
```

Supported modes:

| Mode | 中文 | Meaning |
|---|---|---|
| `build` | 编译 | Compile without forcing a clean rebuild. |
| `rebuild` | 重新编译 | Clean or force rebuild, then compile. |
| `flash` | 烧录 | Program the target without rebuilding unless required. |
| `build-flash` | 编译加烧录 | Build first, then flash only if build succeeds. |

Keil example:

```text
Use fw-build-runner to build and flash this Keil project.
If there are multiple .uvprojx targets, ask me before flashing.
```

### Generated Output Check / 生成物自检

```text
fw-output-sanity-check
```

Run this after Codex creates or edits files.

每次 Codex 生成或修改文件后，建议跑它检查乱码、Markdown 结构、skill frontmatter 和明显异常输出。

For this repository:

```powershell
.\scripts\check-generated-output.ps1
```

---

## Skills / Skill 清单

### Ready / 已实现

| Skill | 中文说明 | English Purpose |
|---|---|---|
| `fw-auto` | 入口推荐器，只判断下一步 | Recommend the next firmware workflow skill. |
| `fw-project-discovery` | 读取项目结构、构建方式、目标板、配置、测试和接口 | Inspect an existing firmware project and generate project maps. |
| `fw-project-brief` | 生成接手人能看懂的项目简报 | Generate a human-readable handoff brief. |
| `fw-intake` | 把模糊需求整理成结构化输入 | Turn unclear firmware requirements into structured inputs. |
| `fw-feature-iterate` | 在已有项目中做聚焦功能迭代 | Implement focused behavior changes in an existing firmware project. |
| `fw-build-runner` | 编译、重新编译、烧录、编译加烧录，支持 Keil | Build, rebuild, flash, or build-and-flash firmware, including Keil MDK/uVision. |
| `fw-output-sanity-check` | 检查生成物乱码和结构问题 | Check generated files for mojibake, malformed Markdown, and invalid skill frontmatter. |
| `fw-verify` | 收集验证证据 | Collect firmware verification evidence. |
| `fw-finish` | 汇总变更、证据、风险和提交信息 | Summarize final status, changes, evidence, risks, and refs. |
| `fw-skill-governance` | 管理 skill 新增/变更和版本记录 | Record skill-system changes and semantic version decisions. |

### Planned / 规划中

| Skill | 中文说明 | English Purpose |
|---|---|---|
| `fw-arch-plan` | 复杂功能或高风险修改前出架构方案 | Produce architecture plans for complex firmware work. |
| `fw-new-project` | 从零创建固件项目骨架 | Create new firmware project skeletons. |
| `fw-refactor` | 不改变行为地重构固件 | Refactor firmware while preserving behavior. |
| `fw-debug-fix` | 根据真机问题数据复验、定位、修复 | Run hypothesis-driven firmware debugging from field data. |
| `fw-review` | 固件专项代码评审 | Perform firmware-specific code review. |
| `fw-logbook` | 记录执行日志 | Maintain chronological workflow logs. |
| `fw-change-record` | 记录固件项目变更点 | Record firmware project changes. |
| `fw-regression-guard` | 为高风险修改定义回归保护 | Define behavior-preservation checks for risky changes. |

---

## How To Talk To Codex / 怎么在对话里用

Project understanding:

```text
Use fw-project-discovery and fw-project-brief to analyze this firmware project's functionality and business logic.
Focus on startup flow, core features, inputs, outputs, state transitions, files/functions, and risk areas.
```

中文：

```text
使用 fw-project-discovery 和 fw-project-brief，帮我分析这个固件项目的功能逻辑和业务逻辑。
重点看启动流程、核心功能、输入输出、状态切换、相关文件函数和风险点。
```

Feature iteration:

```text
Use fw-feature-iterate to implement: <feature>.
First map affected modules/config/interfaces/hardware resources.
Do not perform unrelated refactor.
```

Build and flash:

```text
Use fw-build-runner in build-flash mode for this Keil project.
Confirm project file, target, board, and debug adapter before flashing.
```

Finish:

```text
Use fw-verify to collect evidence, then fw-finish to summarize changes, risks, refs, and suggested commit message.
```

---

## Build And Flash Profiles / 编译烧录支持

`fw-build-runner` selects the safest command profile from project files, docs, scripts, or user input.

`fw-build-runner` 会根据项目文件、文档、脚本或用户输入选择安全的编译烧录方式。

Supported profiles:

- Keil MDK/uVision: `.uvprojx`, `.uvproj`, `.uvoptx`, `.uvopt`
- ESP-IDF: `idf.py`
- Zephyr: `west`
- PlatformIO: `pio`
- CMake, Ninja, Make
- STM32Cube/vendor SDK projects
- Custom build/flash scripts

Keil command examples:

```powershell
UV4.exe -b <project.uvprojx> -j0 -o <build.log>
UV4.exe -r <project.uvprojx> -j0 -o <rebuild.log>
UV4.exe -f <project.uvprojx> -j0 -o <flash.log>
```

Before flashing, the skill must confirm:

- Project file / 工程文件
- Target / 编译目标
- Board / 目标板
- Debug adapter or programmer / 调试器或烧录器

---

## Artifacts / 产物目录

Firmware workflows write handoff data under:

```text
.codex/artifacts/firmware/
```

Common paths:

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

这些 artifact 用来让流程可暂停、可恢复、可交接。

---

## Validation / 校验

Run before publishing changes:

```powershell
.\scripts\validate-skills.ps1
.\scripts\check-generated-output.ps1
```

Checks include:

- `SKILL.md` frontmatter.
- Skill folder/name consistency.
- Mojibake and replacement-character detection.
- NUL byte detection.
- Markdown code fence balance.

GitHub Actions runs these checks on push and pull request.

---

## Repository Layout / 仓库结构

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
- `references/`: shared policies, artifact schema, build/flash profiles, and versioning rules.
- `scripts/`: validation scripts.
- `.codex/artifacts/firmware/skill-system/`: governance records for skill-system changes.

---

## Versioning / 版本规则

Skill-system changes use semantic versioning:

- Major: breaking routing, required artifact schema, terminal-status meaning, or skill names.
- Minor: compatible new skill, optional artifact, optional workflow branch, or new supported framework.
- Patch: wording, examples, trigger clarification, or typo fixes without behavior/schema changes.

新增、删除、重命名、改变触发条件、改变 artifact schema 或改变主流程时，使用 `fw-skill-governance` 记录版本影响。

---

## Documentation / 文档

- [Architecture](./firmware-auto-architecture-dev-skills-style.md)
- [Original Skill Map](./firmware-skill-map.md)
- [Build And Flash Profiles](./references/build-flash-profiles.md)
- [Skill Registry](./references/skill-registry.md)
- [Versioning Policy](./references/versioning-policy.md)
- [Contributing](./CONTRIBUTING.md)

---

## FAQ / 常见问题

### Do these skills automatically call each other?

No. `fw-auto` recommends the next skill, but does not automatically execute other skills. This keeps each step controllable and reviewable.

不会。`fw-auto` 只推荐下一步，不会自动调用其他 skill。这样每一步都更可控、可复核。

### Is the full firmware automation system complete?

Not yet. The existing-project feature iteration path is usable. New-project creation, refactor, debug/fix, and review flows are planned but not fully implemented.

还没有。当前可用的是“已有项目理解 + 功能迭代 + 编译烧录 + 验证收尾”这条 MVP 链路。新建项目、重构、真机问题定位和专项 review 还在规划中。

### Can I use it with Keil?

Yes. `fw-build-runner` includes Keil MDK/uVision detection and command profiles. It still asks before flashing when project, target, board, or adapter is ambiguous.

可以。`fw-build-runner` 已支持 Keil MDK/uVision，但烧录前如果工程、target、目标板或烧录器不明确，会先询问用户。
