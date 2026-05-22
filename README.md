# Firmware Skills Architecture

Current architecture version: `0.4.0`

固件自动迭代 skill 系统，参考 `Jason-chen-coder/dev-skills` 的组织方式设计：

- 一个入口推荐器。
- 多个单职责 skill。
- 通过 artifact 松耦合。
- 完成前有验证和评审门禁。
- skill 自身的新增和变更也要记录并判断版本影响。

## 核心流程

系统覆盖三条互相独立的大流程：

| 流程 | 入口场景 | 主 skill |
|---|---|---|
| 新建固件项目 | 从零创建项目、初始化 SDK/board 工程 | `fw-new-project` |
| 已有项目功能迭代 | 给已有固件加功能、改行为、接驱动、改协议 | `fw-feature-iterate` |
| 已有项目重构 | 不改变行为地拆模块、整理架构、抽象驱动层 | `fw-refactor` |

三条流程共享小工具 skill，但不能互相污染：

- 功能迭代不能顺手做无关重构。
- 重构不能偷偷改变行为。
- 新建项目不能默认背负旧项目兼容逻辑。

## Skill 清单

| Skill | 一句话职责 |
|---|---|
| `fw-auto` | 入口推荐器，只判断下一步，不直接执行 |
| `fw-intake` | 把模糊固件需求转成结构化输入 |
| `fw-project-discovery` | 读取已有项目的 build、board、SDK、目录、配置、测试、接口等事实 |
| `fw-project-brief` | 生成接手人快速理解项目用途、功能、架构和使用方式的简报 |
| `fw-arch-plan` | 为复杂功能、新项目或高风险重构生成架构方案 |
| `fw-new-project` | 从零创建固件项目骨架 |
| `fw-feature-iterate` | 在已有固件项目中迭代功能 |
| `fw-refactor` | 在行为不变的前提下重构已有固件 |
| `fw-debug-fix` | 假设驱动地复现、定位、修复固件问题 |
| `fw-verify` | 固件完成前的构建、测试、硬件证据门禁 |
| `fw-review` | 固件专项评审，检查硬件、并发、资源、配置、可回滚性 |
| `fw-finish` | 汇总变更、验证、残余风险和 Refs |
| `fw-logbook` | 记录执行日志 |
| `fw-change-record` | 记录固件项目变更点 |
| `fw-build-runner` | 推断、确认并执行构建命令 |
| `fw-skill-governance` | 记录 skill 新增/变更/删除，并判断版本升级级别 |

## Artifact 目录

建议所有中间产物放在项目内：

```text
.codex/artifacts/firmware/
  intake/
  plans/
  brief/
    project-brief.md
  maps/
    project-map.md
    hardware-map.md
    interface-map.md
  logs/
    session-log.md
  changes/
  verification/
  reviews/
  finish/
  skill-system/
    skill-registry.md
    skill-changelog.md
    version-decision-<slug>.md
```

## 推荐链路

新建项目：

```text
fw-auto
-> fw-intake
-> fw-arch-plan
-> fw-new-project
-> fw-build-runner
-> fw-project-discovery
-> fw-project-brief
-> fw-verify
-> fw-review
-> fw-finish
```

已有项目功能迭代：

```text
fw-auto
-> fw-project-discovery
-> fw-project-brief when missing or stale
-> fw-intake
-> optional fw-arch-plan
-> fw-feature-iterate
-> fw-build-runner
-> fw-verify
-> fw-review
-> fw-change-record
-> fw-project-brief if behavior/use/architecture changed
-> fw-finish
```

已有项目重构：

```text
fw-auto
-> fw-project-discovery
-> fw-project-brief when missing or stale
-> fw-refactor
-> fw-regression-guard
-> fw-verify
-> fw-review
-> fw-change-record
-> fw-project-brief if architecture/use changed
-> fw-finish
```

skill 系统自身变更：

```text
fw-auto
-> fw-skill-governance
-> classify version impact
-> update skill registry
-> update README/architecture if user-facing
-> write skill changelog
-> fw-review
-> fw-finish
```

## `fw-project-brief` 的定位

`fw-project-discovery` 是机器视角：找事实、命令、配置、路径、模块关系。

`fw-project-brief` 是接手视角：把项目讲清楚，让下一个人或 agent 快速知道：

- 项目是干什么的。
- 运行在什么硬件上。
- 核心功能怎么用。
- 启动和运行流程是什么。
- 主要模块在哪里。
- 怎么 build、flash、monitor、debug。
- 改功能通常从哪里入手。
- 哪些区域风险高。

## Skill 变更和版本规则

新增、删除、重命名、改变触发条件、改变 artifact schema、改变主流程顺序，都必须走 `fw-skill-governance`。

版本规则：

| 版本级别 | 什么时候升级 |
|---|---|
| Major | 破坏兼容：删除/重命名 skill、改变必需 artifact 路径、改变 terminal status 含义、主流程顺序破坏旧用法 |
| Minor | 兼容新增：新增可选 skill、新增可选 artifact、新增可跳过的验证项、新增支持框架 |
| Patch | 兼容修正：文字澄清、示例修复、补充触发词、不改变路由和产物格式 |

例子：

- 新增 `fw-project-brief`，作为推荐的交接简报，不破坏旧流程：Minor。
- 强制所有已有项目流程必须先生成 `fw-project-brief` 才能编辑：可能是 Major。
- 澄清 `fw-project-brief` 和 `fw-project-discovery` 的区别：Patch。

## 当前最小可用版本

第一版建议先写：

1. `fw-auto`
2. `fw-project-discovery`
3. `fw-project-brief`
4. `fw-intake`
5. `fw-feature-iterate`
6. `fw-verify`
7. `fw-finish`
8. `fw-skill-governance`

这样先把“已有项目功能迭代 + 可交接 + 可治理”跑通，再扩展新建项目、重构、debug、硬件专项检查。

## 主要文档

- [Firmware Auto-Iteration Skill Architecture](./firmware-auto-architecture-dev-skills-style.md)
- [Original Firmware Skill Map](./firmware-skill-map.md)

## Git 仓库使用方式

本目录已经按可上传 GitHub 的仓库形态组织：

```text
.
  README.md
  CHANGELOG.md
  CONTRIBUTING.md
  AGENTS.md.template
  .gitignore
  .github/workflows/validate-skills.yml
  scripts/validate-skills.ps1
  references/
  skills/
```

本地校验：

```powershell
.\scripts\validate-skills.ps1
```

初始化和首次提交：

```powershell
git init -b main
git add .
git commit -m "feat: initialize firmware skills"
```

关联 GitHub 远端并上传：

```powershell
git remote add origin https://github.com/<user>/<repo>.git
git push -u origin main
```

如果仓库已经存在 `.git`，跳过 `git init -b main`。

## GitHub Actions

仓库包含一个轻量 CI：

```text
.github/workflows/validate-skills.yml
```

它会在 push 和 pull request 时运行：

```powershell
./scripts/validate-skills.ps1
```

当前检查内容：

- 每个 `skills/*/SKILL.md` 必须有 frontmatter。
- frontmatter 必须包含 `name` 和 `description`。
- `name` 必须和 skill 文件夹名一致。
