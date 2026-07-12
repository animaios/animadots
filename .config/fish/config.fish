# Qt GTK theme integration
set -Ux QT_QPA_PLATFORMTHEME qt6ct

# Auto-start Hyprland on tty1 boot (no display manager)
if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = "1"
    exec ~/.config/hypr/start-hyprland
end

set -g fish_greeting
fastfetch
