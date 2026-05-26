# Build And Flash Profiles

Use this reference to select likely build/flash commands. Prefer project docs and scripts over these defaults.

## Command Selection Rule

1. Use explicit user instruction first.
2. Use existing project scripts second.
3. Use project-map or brief third.
4. Use standard framework commands only when the project files clearly match.
5. Ask when multiple project entrypoints, targets, or ports are plausible.

## ESP-IDF

Indicators:

- `CMakeLists.txt`
- `sdkconfig`
- `idf_component.yml`
- `main/`

Commands:

```powershell
idf.py build
idf.py fullclean
idf.py flash
idf.py build flash
idf.py -p <port> flash
```

Notes:

- Ask for port when not discoverable.
- Confirm target when `sdkconfig` or docs are unclear.

## Zephyr

Indicators:

- `west.yml`
- `prj.conf`
- `boards/`
- `app.overlay`

Commands:

```powershell
west build -b <board> <app>
west build -b <board> <app> -p always
west flash
```

Notes:

- Board is usually required.
- Multiple apps are common; ask when ambiguous.

## PlatformIO

Indicators:

- `platformio.ini`

Commands:

```powershell
pio run
pio run -e <env>
pio run -t clean
pio run -t upload
pio run -e <env> -t upload
```

Notes:

- Ask for environment when multiple `[env:*]` entries exist.

## CMake With Ninja Or Make

Indicators:

- `CMakeLists.txt`
- `CMakePresets.json`
- `build/`

Commands:

```powershell
cmake -S . -B build
cmake --build build
cmake --build build --clean-first
cmake --build build --target <flash-target>
```

Notes:

- Prefer presets when present.
- Flash target names vary: `flash`, `upload`, `program`, `burn`.

## Make

Indicators:

- `Makefile`

Commands:

```powershell
make
make clean
make flash
make upload
```

Notes:

- Inspect targets before assuming flash target names.

## STM32Cube / Vendor IDE Projects

Indicators:

- `.ioc`
- `.project`
- `.cproject`
- `STM32CubeIDE`
- vendor scripts.

Commands:

Use project scripts when present. Otherwise ask for the expected build and flash tool:

- STM32CubeIDE headless build.
- CMake/Make wrapper.
- OpenOCD.
- STM32_Programmer_CLI.

Notes:

- Do not invent flash commands without board, probe, and binary path.

## Keil MDK / uVision

Indicators:

- `.uvprojx`
- `.uvproj`
- `.uvoptx`
- `.uvopt`
- `Listings/`
- `Objects/`
- `RTE/`

Common executable:

```powershell
C:\Keil_v5\UV4\UV4.exe
```

Other installations may place `UV4.exe` elsewhere. If the path is not known, look for:

- Project docs.
- Environment variables.
- Common install paths such as `C:\Keil_v5\UV4\UV4.exe`.
- User-provided Keil path.

Commands:

```powershell
UV4.exe -b <project.uvprojx> -j0 -o <build.log>
UV4.exe -r <project.uvprojx> -j0 -o <rebuild.log>
UV4.exe -f <project.uvprojx> -j0 -o <flash.log>
```

Mode mapping:

| Mode | Keil command |
|---|---|
| `build` | `UV4.exe -b <project.uvprojx> -j0 -o <build.log>` |
| `rebuild` | `UV4.exe -r <project.uvprojx> -j0 -o <rebuild.log>` |
| `flash` | `UV4.exe -f <project.uvprojx> -j0 -o <flash.log>` |
| `build-flash` | run `-b`, then run `-f` only if build succeeds |

Target selection:

- A Keil project may contain multiple targets.
- If the user names a target, pass it using the Keil-supported target option for the installed version.
- If multiple targets exist and the intended one is unclear, ask the user.
- Do not assume the first target is safe for flashing.

Before flashing:

- Confirm the project file.
- Confirm the Keil target.
- Confirm the connected board.
- Confirm the debug adapter or programmer, such as ST-Link, J-Link, ULINK, CMSIS-DAP, or DAPLink.
- Confirm that the Keil project already has flash algorithm/debug settings configured.

Failure classes:

- `KEIL_UV4_MISSING`
- `KEIL_TARGET_AMBIGUOUS`
- `KEIL_LICENSE_ERROR`
- `KEIL_PACK_MISSING`
- `KEIL_INCLUDE_PATH_ERROR`
- `KEIL_COMPILE_ERROR`
- `KEIL_LINK_ERROR`
- `KEIL_FLASH_ALGORITHM_ERROR`
- `KEIL_DEBUG_ADAPTER_MISSING`
- `KEIL_FLASH_FAILED`

Notes:

- Prefer Keil command-line build when `.uvprojx` or `.uvproj` is the primary project file.
- For CI or headless machines, license and pack availability are common blockers.
- For flashing, Keil usually depends on debug settings saved in `.uvoptx` or project options.
- If command-line flash is unreliable, ask whether to use J-Link, STM32_Programmer_CLI, pyOCD, or OpenOCD instead.

## Custom Scripts

Indicators:

- `build.ps1`
- `build.bat`
- `build.sh`
- `flash.ps1`
- `flash.bat`
- `upload.*`
- `program.*`

Rule:

- Prefer these scripts after reading their parameters.
- Ask before running scripts that erase flash, modify environment, or require hardware.
