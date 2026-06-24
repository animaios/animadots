source /usr/share/cachyos-fish-config/cachyos-config.fish

# Qt GTK theme integration
set -Ux QT_QPA_PLATFORMTHEME qt6ct

export CFLAGS="-march=x86-64-v3 -mtune=znver4 -O2 -pipe"
export CXXFLAGS="$CFLAGS"
#xport RUSTFLAGS="-C target-cpu=x86-64-v3"
export GOAMD64=v4

# Auto-start Hyprland on tty1 boot (no display manager)
if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = "1"
    exec Hyprland
end
