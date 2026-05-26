---
name: fw-build-runner
description: Global firmware build and flash runner. Use when Codex needs to compile, rebuild, flash, or build-and-flash firmware across one or more project files or build entrypoints in an embedded repository, including Keil MDK/uVision, CMake/Ninja/Make, ESP-IDF, Zephyr west, PlatformIO, STM32Cube, vendor SDKs, or custom scripts.
---

# Firmware Build Runner

Run build and flash operations safely across firmware projects.

This is a global tool skill. Use it from any macro workflow that needs:

- Build.
- Rebuild.
- Flash.
- Build then flash.

Read when available:

- `.codex/artifacts/firmware/maps/project-map.md`
- `.codex/artifacts/firmware/brief/project-brief.md`
- `references/build-flash-profiles.md`

## Modes

Support four modes:

| Mode | Meaning |
|---|---|
| `build` | Compile without forcing a clean rebuild |
| `rebuild` | Clean or force regeneration, then compile |
| `flash` | Program the target without rebuilding unless required by the tool |
| `build-flash` | Compile first, then program the target |

If the user does not specify a mode, infer from the request. If still unclear, ask.

## Workflow

1. Identify candidate project entrypoints:
   - `CMakeLists.txt`
   - `Makefile`
   - `west.yml`
   - `platformio.ini`
   - `.uvprojx` or `.uvproj`
   - ESP-IDF project files.
   - Keil MDK/uVision project files.
   - STM32Cube project files.
   - Vendor SDK build scripts.
   - Existing project scripts such as `build.*`, `flash.*`, `upload.*`, `idf.py`, `west`, or `pio`.
2. Detect whether the repository has multiple firmware projects or targets.
3. Select the project/target:
   - Use the user's explicit project, board, target, or path when provided.
   - Use project-map facts when available.
   - If multiple plausible entries remain, ask the user to choose.
4. Select the command profile from `references/build-flash-profiles.md` or project docs/scripts.
5. Before flashing, confirm hardware assumptions:
   - Board/target.
   - Keil target when using Keil.
   - Port/probe when required.
   - Debug adapter/programmer when required.
   - Bootloader or flashing mode when required.
   - Whether flashing could overwrite a connected device.
6. Run the command only after the project/target is clear.
7. Record exact command, working directory, result, and failure class.

## Output

Write or update:

`.codex/artifacts/firmware/verification/<slug>.md`

Append build/flash evidence:

```md
## Build/Flash Evidence

Mode:
Project entrypoint:
Working directory:
Target/board:
Command:
Result:
Failure class:
Notes:
```

## Failure Classes

Use these labels:

- `TOOLCHAIN_MISSING`
- `CONFIG_MISSING`
- `TARGET_AMBIGUOUS`
- `PROJECT_AMBIGUOUS`
- `COMPILE_ERROR`
- `LINK_ERROR`
- `FLASH_PORT_MISSING`
- `FLASH_TARGET_MISMATCH`
- `FLASH_FAILED`
- `ENVIRONMENT_BLOCKED`
- `KEIL_UV4_MISSING`
- `KEIL_TARGET_AMBIGUOUS`
- `KEIL_LICENSE_ERROR`
- `KEIL_PACK_MISSING`
- `KEIL_FLASH_ALGORITHM_ERROR`
- `KEIL_DEBUG_ADAPTER_MISSING`
- `UNKNOWN`

## Guardrails

- Do not guess between multiple project files when flashing hardware.
- Do not flash if board/target identity is unclear.
- For Keil projects, do not flash if the `.uvprojx/.uvproj`, Keil target, connected board, or debug adapter is unclear.
- Do not erase, mass-flash, or overwrite device storage unless the user explicitly requested it.
- Prefer existing project scripts over inventing commands.
- For `rebuild`, use the project's normal clean command. Do not delete arbitrary directories manually.
- If a command fails because dependencies or devices are unavailable, record the blocker and stop.

## Terminal Status

- `READY`
- `BUILD_BLOCKED`
- `FLASH_BLOCKED`
- `PROJECT_AMBIGUOUS`
- `TARGET_AMBIGUOUS`
- `HARDWARE_BLOCKED`
