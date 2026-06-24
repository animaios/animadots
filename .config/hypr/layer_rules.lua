-- Layer rules module for Hyprland Lua config

-- Blur for vibepanel
hl.layer_rule({
    match = { namespace = "vibepanel" },
    blur = true,
})

-- Blur for nwg-dock
hl.layer_rule({
    match = { namespace = "nwg-dock-hyprland" },
    blur = true,
})

-- Blur for swaync notifications
hl.layer_rule({
    match = { namespace = "swaync" },
    blur = true,
})

-- No animations for overlay layers
hl.layer_rule({
    match = { namespace = "nwg-drawer" },
    no_anim = false,
})
