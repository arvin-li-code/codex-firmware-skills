# Firmware Terminal Status

Use these statuses when a skill cannot continue or has reached a gate.

| Status | Meaning | Recovery |
|---|---|---|
| `READY` | Gate passed | Continue to `fw-finish` |
| `NOT_READY` | Verification or review failed | Return to implementation skill |
| `NEEDS_INTAKE` | Requirement or constraint unclear | Run `fw-intake` |
| `NEEDS_ARCH_PLAN` | Impact is broad or risky | Run `fw-arch-plan` |
| `BUILD_BLOCKED` | Build failed | Run build diagnosis or fix config |
| `HARDWARE_BLOCKED` | Board, probe, device, or instrument needed | Record skipped checks and manual checklist |
| `BEHAVIOR_CHANGE_DETECTED` | Refactor changed behavior | Stop refactor and route to feature iteration |
| `BELOW_CONFIDENCE_THRESHOLD` | Debug evidence insufficient | Continue evidence collection |
| `SKILL_VERSION_REQUIRED` | Skill-system change lacks version decision | Run `fw-skill-governance` |
| `SKILL_REGISTRY_STALE` | Skill docs and registry disagree | Update registry and changelog |
