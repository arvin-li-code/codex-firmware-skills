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
