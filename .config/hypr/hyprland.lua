-- Hyprland Lua config — Hyprland 0.55+
-- Main entry point. Splits config into modules via require().

-- ── Environment ──────────────────────────────────────────────
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- ── General Settings ─────────────────────────────────────────
hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 6,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        layout = "scrolling",

        extend_border_grab_area = true,
        hover_icon_on_border   = true,

        -- HyprMod GUI settings (from hyprland-gui.conf)
        allow_tearing = true,
        resize_on_border = true,
        snap = {
            enabled      = true,
            respect_gaps = true,
        },
    },
})

-- ── Decoration: Blur + Rounding + Shadows + Opacity ──────────
hl.config({
    decoration = {
        rounding       = 8,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 8,
            render_power = 3,
            color        = 0xaa1a1a1a,
            offset       = { 0, 0 },
            scale        = 1.0,
            sharp        = false,
        },

        blur = {
            enabled            = true,
            size               = 8,
            passes             = 3,
            new_optimizations  = true,
            xray               = false,
            vibrancy           = 0.1696,
        },
    },
})

-- ── Animations ────────────────────────────────────────────────
-- Custom bezier curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Custom spring
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

-- Animation tree
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "borderangle",   enabled = true,  speed = 5.39, bezier = "easeOutQuint", style = "loop" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "fadeSwitch",    enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "fadeShadow",    enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "fadeDim",       enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 6,    bezier = "easeOutQuint", style = "slidefade 20%" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 6,    bezier = "easeOutQuint", style = "slidefade 20%" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 6,    bezier = "easeOutQuint", style = "slidefade 20%" })
hl.animation({ leaf = "specialWorkspace",    enabled = true, speed = 6, bezier = "easeOutQuint", style = "slidevert 20%" })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 6, bezier = "easeOutQuint", style = "slidevert 20%" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 6, bezier = "easeOutQuint", style = "slidevert 20%" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- ── Layouts ──────────────────────────────────────────────────
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
        column_width             = 0.5,
        focus_fit_method         = 1,
        follow_focus             = true,
        follow_min_visible       = 0.4,
        explicit_column_widths   = "0.333, 0.5, 0.667, 1.0",
        wrap_focus               = true,
        wrap_swapcol             = true,
        direction                = "right",
    },
})

hl.config({
    dwindle = {
        force_split          = 0,
        preserve_split       = true,
        smart_split          = false,
        smart_resizing       = true,
        special_scale_factor = 0.8,
        split_width_multiplier = 1.0,
        use_active_for_splits  = true,
        default_split_ratio    = 1.0,
    },
})

hl.config({
    master = {
        allow_small_split          = false,
        special_scale_factor       = 0.8,
        mfact                      = 0.55,
        new_on_top                 = false,
        orientation                = "left",
        slave_count_for_center_master = 2,
    },
})

-- ── Misc ─────────────────────────────────────────────────────
hl.config({
    misc = {
        disable_hyprland_logo     = true,
        disable_splash_rendering  = true,
        vrr                       = 0,
        mouse_move_enables_dpms   = false,
        key_press_enables_dpms    = false,
        layers_hog_keyboard_focus = true,
        focus_on_activate         = false,
        mouse_move_focuses_monitor = true,
        animate_manual_resizes    = true,
        animate_mouse_windowdragging = true,
    },
})

-- ── Ecosystem ─────────────────────────────────────────────────
hl.config({
    ecosystem = {
        no_donation_nag = true,
    },
})

-- ── Input ────────────────────────────────────────────────────
hl.config({
    input = {
        kb_layout  = "us,ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:alt_shift_toggle",

        repeat_rate = 25,
        repeat_delay = 600,

        follow_mouse            = 1,
        mouse_refocus           = true,
        float_switch_override_focus = 1,

        sensitivity = 0,

        -- HyprMod GUI settings
        accel_profile = "adaptive",

        touchpad = {
            disable_while_typing = true,
            scroll_factor        = 1.0,
            tap_to_click         = true,
            natural_scroll       = false,
        },
    },
})

-- ── Binds config ─────────────────────────────────────────────
hl.config({
    binds = {
        drag_threshold = 10,
    },
})

-- ── Smart Gaps ───────────────────────────────────────────────
-- Remove gaps and borders when only one window is visible
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]",    gaps_out = 0, gaps_in = 0 })

-- ── Autostart ────────────────────────────────────────────────
hl.on("hyprland.start", function()
    hl.exec_cmd("wlsunset -t 4500 -T 6500 -l 55.6256 -L 37.6064 -g 1.0")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("vibepanel")
    hl.exec_cmd("nwg-dock-hyprland -d -p bottom -l overlay -a center -i 48 -hd 0 -x -s hyprland-1.css")
    hl.exec_cmd("swaync -c /home/vi/.config/swaync/hyprland.json -s /home/vi/.config/swaync/hyprland-1.css")
    hl.exec_cmd("systemctl --user start glpaper")
    hl.exec_cmd("clipboard-tray")
    hl.exec_cmd("hyprshell run")
end)

-- ── Load modules ─────────────────────────────────────────────
require("keybinds")
require("window_rules")
require("layer_rules")
