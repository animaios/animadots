# Repository Guidelines

> Dotfiles for Hyprland-based desktop UI of [AnimAIOS](https://github.com/animaios/animacore).

---

## Project Overview

This is a configuration repo (dotfiles), not a code project. It provides a polished Hyprland desktop setup with:

- **Hyprland** window manager — Lua-configured (0.55+, uses `hyprland.lua` + modules)
- **hyprshell** — status bar (Rust config, RON format)
- **hyprexpose** — workspace overview/expos (TOML)
- **hyprlock** — screen lock (built into Hyprland, config at `.config/hypr/hyprlock.conf`)
- **hypridle** — idle management (built into Hyprland, config at `.config/hypr/hypridle.conf`)
- **nwg-dock-hyprland** — gtk3 dock (CSS-themed)
- **gtklock** — alternative screen locker (CSS + INI)
- **foot** — terminal (INI)
- **fish** — shell (config.fish)

---

## Architecture & Data Flow

All configuration lives under `.config/` at the repo root. The repo IS the `~/.config/` tree — copy/rsync the directory to deploy.

### Hyprland Config Structure

```
.config/hypr/
├── hyprland.lua         # Main entry point (require()s modules)
├── hyprland.conf        # Fallback for older plugins
├── keybinds.lua         # Key binding definitions
├── layer_rules.lua      # Wayland overlay layer rules
├── window_rules.lua     # Window floating/sizing/opacity rules
├── hypridle.conf        # Idle detection (DPMS + idle target)
├── hyprlock.conf        # Screen lock (themed lock screen)
├── start-hyprland       # Launch script (dbus + XDG vars)
```

**`hyprland.lua`** is the entry point. It calls `hl.on("hyprland.start", ...)` for autostart, sets environment variables via `hl.env()`, calls `hl.curve()` / `hl.animation()` for the animation block, then delegates via `require()` to the submodules.

### Hyprland Lua API Patterns

The config uses the Hyprland Lua DSL (`hl` global). Key patterns:

- **Keybinds:** `hl.bind(modifier + key, action)` — see `keybinds.lua` for all examples
- **Actions:** `hl.dsp.focus({ direction = "up"|"down" })`, `hl.dsp.window.close()`, `hl.dsp.layout("focus l")`, `hl.dsp.layout("colresize ±0.1")`
- **Config blocks:** `hl.config({ ... })` to pass a table; supports `general`, `decoration`, `misc` sections
- **Beziers:** `hl.curve("name", { type = "bezier"|"spring", points = {...}|{ mass, stiffness, dampening } })`
- **Animations:** `hl.animation({ leaf = "name", enabled = true, speed = N, bezier = "name" })`
- **Workspace rules:** `hl.workspace_rule({ workspace = "w[tv1]s[false]", ... })` — single-workspace settings
- **Layer rules:** `hl.layer_rule({ match = { namespace = "name" }, blur = true, ... })`
- **Window rules:** `hl.window_rule({ match = { class = "...", ... }, opacity = "...", suppress_event = "maximize", rounding = 0, ... })`
- **Loop through arrays** with `for i, name in ipairs(list) do ... end`

### File Resolution for `require()`

`require("keybinds")` → `.config/hypr/keybinds.lua` (Hyprland resolves relative to `hyprland.lua`'s directory).

### Layer Rules

`layer_rules.lua` defines overlay animation/visual rules per app namespace (desktop, notifications, docks, launchers, OSD, wallpapers, etc.). Each is `hl.layer_rule({ match = { namespace = "..." }, ... })`.

### Window Rules

`window_rules.lua` handles:
- **Transparency:** VSCodium windows get 0.85 opacity
- **XWayland drag fix:** no_focus on floating, fullscreen, no-title/no-class windows
- **Suppress maximize:** `suppress_event = "maximize"` on all windows
- **Smart gaps:** remove borders and rounding on non-floating windows in scroll layout workspaces

### Launch Flow

1. systemd `getty@tty1` → fish `config.fish` → `exec Hyprland` (or `start-hyprland`)
2. `start-hyprland` sets `XDG_CURRENT_DESKTOP=Hyprland`, `XDG_SESSION_TYPE=wayland`, exports dbus, then `exec Hyprland "$@"`
3. Hyprland loads `hyprland.lua`, which sets up animations/decoration, then requires `keybinds`, `layer_rules`, `window_rules`
4. Autostart: `hl.on("hyprland.start", ...)` spawns hyprshell, nwg-dock, pyprland, idle notifier, mako, asusctl, etc.

---

## Key Directories

| Directory | Purpose |
|-----------|---------|
| `.config/hypr/` | Hyprland window manager (Lua + conf + scripts) |
| `.config/hyprshell/` | hyprshell status bar (config.ron + styles.css) |
| `.config/hyprexpose/` | hyprexpose workspace overview (TOML) |
| `.config/nwg-dock-hyprland/` | nwg-dock gtk3 dock (CSS) |
| `.config/gtklock/` | gtklock alternative screen locker (CSS + INI) |
| `.config/foot/` | foot terminal (INI) |
| `.config/fish/` | fish shell (config.fish) |
| `.config/systemd/user/` | systemd user service drop-ins |

---

## Key Files

| File | Role |
|------|------|
| `.config/hypr/hyprland.lua` | Main Hyprland entry point; env, animations, requires submodules |
| `.config/hypr/keybinds.lua` | All keyboard shortcuts (workspace switching, window ops, layout ops, screenshots) |
| `.config/hypr/layer_rules.lua` | Wayland overlay layer blur/animation rules by namespace |
| `.config/hypr/window_rules.lua` | Floating windows, opacity, smart gaps, maximize suppression |
| `.config/hypr/hypridle.conf` | Idle detection (DPMS off after 5 min, start idle target) |
| `.config/hypr/hyprlock.conf` | Themed lock screen (dark, blue accent, clock/date/branding) |
| `.config/hypr/start-hyprland` | Launch script (XDG vars + dbus + exec) |
| `.config/fish/config.fish` | Shell config; auto-starts Hyprland on tty1 |
| `.config/hyprexpose/config.toml` | Workspace overview appearance and behavior |
| `.config/hyprshell/config.ron` | hyprshell status bar config (Rust RON format) |
| `.config/nwg-dock-hyprland/hyprland-1.css` | Dock styling (running/active dots, launcher separator) |

---

## Code Conventions

### Hyprland Lua Config

- **Entry point:** `hyprland.lua` — never import other configs directly here; delegate via `require()`
- **Module naming:** modules are named after their file (no prefix/suffix), e.g. `require("keybinds")` loads `keybinds.lua`
- **Workspace names:** single uppercase letters `A`–`L`; generated via `ipairs` over a `workspace_names` table
- **Modifier key:** `mainMod = "ALT"` — all core binds use `ALT + key`
- **Direction strings:** `"up"`, `"down"`, `"left"`, `"right"` (lowercase) for `hl.dsp.focus()`
- **Layout scroll strings:** `"l"`, `"r"`, `"focus l"`, `"swapcol l"`, `"colresize ±0.1"` for `hl.dsp.layout()`
- **Color format:** `#rrggbbaa` (8 hex digits or `rgba(r g b a)` with `rgba()` prefix) in all configs

### TOML Configs

- Inline comments with `#`; section headers with `[section_name]`
- Float values always include `.0` (e.g., `card_padding = 24.0`)
- Boolean values are lowercase (`true`, `false`)

### RON Config (hyprshell)

- Rust RON format: `(key: value, key2: value2)` — tuple-struct style
- Strings double-quoted; enums as `EnumVariant`

### INI (foot, hyprlock)

- `[section]` headers, `key = value` pairs
- Hyprlock uses `$variable` references for reuse (e.g., `$accent`, `$bg`, `$font`)

### CSS (nwg-dock, gtklock)

- gtk3 CSS: `window`, `#box`, `button`, `button.running`, `button.active`, `image`, `button.launcher`
- Colors use `rgba(r, g, b, a)` functional notation

### Shell (fish, bash)

- Fish: `test`/`if` for conditionals; `set -Ux` for universal exported vars; `exec` replaces shell
- Bash (start-hyprland): standard POSIX; `export KEY=val` before `exec`

---

## Important Patterns

### Adding a New Keybind

In `keybinds.lua`, add a line:
```lua
hl.bind(mainMod .. " + KeyName", hl.dsp.exec_cmd("command"))
```
For directional focus: `hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "up" }))`

### Adding a Workspace

In `keybinds.lua`, add a name to `workspace_names` and a key to `key_names` (same index), e.g.:
```lua
local workspace_names = {"A", "B", "C", ...}
local key_names = {"1", "2", "3", ...}
```
Both arrays must have the same length.

### Adding a Layer Rule

In `layer_rules.lua`:
```lua
hl.layer_rule({
    match = { namespace = "app-name" },
    blur = true,
})
```

### Adding a Window Rule

In `window_rules.lua`:
```lua
hl.window_rule({
    match = { class = "AppName" },
    opacity = "0.85 override 0.85 override",
})
```

---

## Runtime & Tooling Preferences

- **Window Manager:** Hyprland 0.55+ (Lua config required)
- **Shell:** fish
- **Terminal:** foot
- **Deployment:** Copy or `rsync -av .config/ ~/` — repo root maps to `~/.config/`
- **Autostart:** systemd `getty@tty1` → fish `config.fish` → `~/.config/hypr/start-hyprland`

---

## Testing & QA

No tests exist — this is pure configuration. Validation is manual:

- After editing Hyprland config: `Hyprland reload` (or configured keybind) to apply without logout
- After editing `hyprland.lua`: syntax errors prevent Hyprland startup — check `~/.cache/hyprland.log`
- `hyprctl version` confirms Hyprland is running and config loaded
- Test keybinds by pressing them — workspace switches, window focus, layout operations
- CSS/INI/TOML changes: restart the affected service (or relogin) to see changes

---

## Deployment

```bash
# Dry run
rsync -av --delete .config/ ~/

# Apply
rsync -av --delete .config/ ~/
```