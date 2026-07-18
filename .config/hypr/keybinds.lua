-- Keybinds module for Hyprland Lua config

local mainMod = "ALT"

-- ── Workspace switching (named workspaces A-L) ───────────────
local workspace_names = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"}
-- Key names for number row: 1-9 are "1"-"9", 10="0", 11="minus", 12="equal"
local key_names = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal"}

for i, name in ipairs(workspace_names) do
    local key = key_names[i]
    -- Switch to workspace
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = "name:" .. name }))
    -- Move active window to workspace (follow = true moves the window and follows it)
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = "name:" .. name, follow = true }))
end

-- ── Application launchers ────────────────────────────────────
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("Telegram"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("chromium-browser-unstable"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("chromium-browser-unstable --app=https://www.google.com?udm=50"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- ── Window cycling ───────────────────────────────────────────
-- Retired: delegated to hyprshell switch (Alt+Tab, modifier "alt"/key "Tab").
-- NOTE: this dropped Alt+Shift+Tab (backward cycle); hyprshell has no Shift variant.
-- hl.bind(mainMod .. " + Tab",         hl.dsp.window.cycle_next())
-- hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.window.cycle_next({ prev = true }))

-- ── Screenshots ──────────────────────────────────────────────
-- Shift+Print: full screen
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim - | tee ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png | wl-copy --type image/png"))
-- Print: area selection (default)
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png | wl-copy --type image/png"))
-- Ctrl+Print: active window
hl.bind("CTRL + Print", hl.dsp.exec_cmd("grim -g \"$(hyprctl activewindow -j | jq -r '\"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\"')\" - | tee ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png | wl-copy --type image/png"))

-- ── Scrolling layout navigation ───────────────────────────────
-- Move focus left/right between columns
hl.bind(mainMod .. " + Left",  hl.dsp.layout("focus l"))
hl.bind(mainMod .. " + Right", hl.dsp.layout("focus r"))
-- Move focus up/down between windows in the same column
hl.bind(mainMod .. " + Up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down",  hl.dsp.focus({ direction = "down" }))

-- Swap current column with neighbor
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.layout("swapcol r"))

-- Move view by columns
hl.bind(mainMod .. " + comma",  hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + period", hl.dsp.layout("move +col"))

-- Resize current column
hl.bind(mainMod .. " + R + Left",  hl.dsp.layout("colresize -0.1"))
hl.bind(mainMod .. " + R + Right", hl.dsp.layout("colresize +0.1"))

-- Cycle through preset column widths
hl.bind(mainMod .. " + bracketleft",  hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("colresize +conf"))

-- Resize all columns at once
hl.bind(mainMod .. " + R + A", hl.dsp.layout("colresize all 0.5"))

-- Promote window to its own column
hl.bind(mainMod .. " + P", hl.dsp.layout("promote"))

-- Expel window to a dedicated column / consume into previous
hl.bind(mainMod .. " + O", hl.dsp.layout("expel"))
hl.bind(mainMod .. " + U", hl.dsp.layout("consume"))

-- Fit operations
hl.bind(mainMod .. " + Home", hl.dsp.layout("fit active"))
hl.bind(mainMod .. " + End",  hl.dsp.layout("fit visible"))

-- Toggle scroll inhibition
hl.bind(mainMod .. " + I", hl.dsp.layout("inhibit_scroll"))

-- ── Mouse window drag/resize ─────────────────────────────────
hl.bind("ALT + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })
