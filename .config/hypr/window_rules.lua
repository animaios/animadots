-- Window rules module for Hyprland Lua config

-- VSCodium transparency (background only)
hl.window_rule({
    match = { class = "codium" },
    opacity = "0.85 override 0.85 override",
})

hl.window_rule({
    match = { class = "VSCodium" },
    opacity = "0.85 override 0.85 override",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Ignore maximize requests from all apps
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Smart gaps: remove borders and rounding when single window
hl.window_rule({
    match = { float = false, workspace = "w[tv1]s[false]" },
    border_size = 0,
})

hl.window_rule({
    match = { float = false, workspace = "w[tv1]s[false]" },
    rounding = 0,
})

hl.window_rule({
    match = { float = false, workspace = "f[1]s[false]" },
    border_size = 0,
})

hl.window_rule({
    match = { float = false, workspace = "f[1]s[false]" },
    rounding = 0,
})
