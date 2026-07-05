source /usr/share/cachyos-fish-config/cachyos-config.fish

# Qt GTK theme integration
set -Ux QT_QPA_PLATFORMTHEME qt6ct

export CFLAGS="-march=x86-64-v3 -mtune=znver4 -O2 -pipe"
export CXXFLAGS="$CFLAGS"
#xport RUSTFLAGS="-C target-cpu=x86-64-v3"
export GOAMD64=v4

# Auto-start Hyprland on tty1 boot (no display manager)
if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = "1"
    exec ~/.config/hypr/start-hyprland
end

# Local sccache shared by normal Cargo builds and makepkg builds.
set -gx SCCACHE_DIR "$HOME/.cache/sccache"
set -gx SCCACHE_CACHE_SIZE 50G
set -gx RUSTC_WRAPPER /usr/bin/sccache
test -d "$SCCACHE_DIR"; or mkdir -p "$SCCACHE_DIR"

# Do not use the old remote Backblaze B2 cache; quota/cap failures there make
# Cargo fail before rustc starts.
set -e SCCACHE_PROVIDER
set -e SCCACHE_BUCKET
set -e SCCACHE_ENDPOINT
set -e SCCACHE_REGION
set -e AWS_ACCESS_KEY_ID
set -e AWS_SECRET_ACCESS_KEY
set -gx VSSCRIPT_PATH /usr/lib/python3.14/site-packages/vapoursynth/libvsscript.so
