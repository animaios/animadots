<div align="center">

# [Anima](https://github.com/animaios/animacore)Dots

<img width="256" height="384" alt="AnimAIOS mascot" src="https://github.com/user-attachments/assets/b87a9e6f-72a3-4103-9668-d1b6886f1b54" />

<h3>Base UI for AnimAIOS — Hyprland, hyprshell, nwg-dock, hyprlock</h3>

</div>

---

A carefully crafted dotfiles setup that transforms Hyprland into a modern, cohesive desktop experience. Built to serve as the visual foundation for [AnimAIOS](https://github.com/animaios/animacore) — the agentic AI desktop OS.

## ✨ Features

- **🐧 Hyprland 0.55+** — Lua config with scrolling layout, smooth animations, smart gaps
- **🪟 hyprshell** — GTK4 window switcher & overview on Super key (like GNOME Overview)
- **📋 nwg-dock** — Dash-to-Dock-style autohide dock with running app indicators
- **🔒 hyprlock** — Dark themed lockscreen matching the setup
- **🎨 Cohesive Dark Theme** — Deep dark transparency, blue accent (#33ccff), rounded corners everywhere
- **🧩 Scrolling Layout** — Modern window management with column-based navigation
- **🐾 Anima-ready** — Built to coexist with [AnimAIOS](https://github.com/animaios/animacore) desktop companion

## 🖥️ What's Inside

| Config | Purpose |
|---|---|
| `hyprland.lua` | Main Hyprland config — animations, layout, blur, input |
| `keybinds.lua` | All keybindings — workspace switching, apps, navigation |
| `window_rules.lua` | Window rules — smart gaps, transparency, event suppression |
| `layer_rules.lua` | Layer rules — blur for dock, panel, notifications |
| `hypridle.conf` | Idle timer template (hypridle) |
| `hyprshell/config.ron` | Window switcher & overview config |
| `hyprshell/styles.css` | Window switcher CSS theme |
| `nwg-dock-hyprland/hyprland-1.css` | Dash-to-Dock bottom dock CSS |
| `hyprlock.conf` | Lockscreen config |


## ⌨️ Keybindings

| Key | Action |
|---|---|
| **Super** (alone) | 🪟 hyprshell window overview |
| **Super + Tab** | ↔️ hyprshell window switch |
| **Alt + Shift** | 🔤 Switch keyboard layout (en/ru) |
| **Alt + 1–0, -, =** | Switch to workspace A–L |
| **Alt + Shift + 1–0, -, =** | Move window to workspace |
| **Alt + T** | Kitty terminal |
| **Alt + E** | Hyprlauncher |
| **Alt + B** | Floorp browser |
| **Alt + F** | Nautilus file manager |
| **Alt + L** | 🔒 Lock screen (hyprlock) |
| **Alt + Q** | Close window |
| **Print** | 📐 Area screenshot → clipboard |
| **Shift + Print** | Full screenshot → clipboard |
| **Ctrl + Print** | Active window screenshot → clipboard |


### 🌐 Keyboard Layouts

Two layouts are pre-configured: **English (US)** and **Russian**. Switch between them with:

| Key | Action |
|---|---|
| **Alt + Shift** | 🔄 Toggle between en/ru |

To add or remove layouts, edit `~/.config/hypr/hyprland.lua`:
```lua
input = {
    kb_layout  = "us,ru",   -- comma-separated list of layouts
    kb_options = "grp:alt_shift_toggle",  -- Alt+Shift to toggle
}
```

Common layout codes: `us`, `ru`, `de`, `fr`, `uk`, `jp`, `br`, `il`, `ara`.
Change `grp:alt_shift_toggle` to any [XKB group switch option](https://wiki.archlinux.org/title/X keyboard extension#Switching_between_keyboard_layouts)
(e.g. `grp:win_space_toggle` for Win+Space).


### Scrolling Layout Navigation

| Key | Action |
|---|---|
| **Alt + ←/→** | Focus column left/right |
| **Alt + Shift + ←/→** | Swap column |
| **Alt + , / .** | Move view by columns |
| **Alt + R + ←/→** | Resize column |
| **Alt + [ / ]** | Cycle column widths |
| **Alt + P** | Promote window to own column |
| **Alt + O** | Expel window |
| **Alt + U** | Consume into previous column |

### Mouse

| Action | Function |
|---|---|
| **Alt + left click** | Drag window |
| **Alt + right click** | Resize window |
| **Mouse to bottom edge** | Reveal dock |
| **Click dock icon** | Focus app |

## 🚀 Installation

```bash
# 1. Clone as a bare repo
git clone --bare https://github.com/animaios/animadots.git $HOME/dotfiles

# 2. Checkout to $HOME
alias config='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
config checkout

# 3. Hide untracked files
config config status.showUntrackedFiles no

# 4. Install tools
sudo pacman -S hyprland nwg-dock-hyprland hyprlock jq
yay -S hyprshell-bin

# 5. Start hyprshell
systemctl --user enable --now hyprshell.service
```

## 🎨 Theming

All configs use a consistent dark palette:

| Role | Color |
|---|---|
| Background | rgba(20, 22, 30, 0.85) |
| Card/Surface | rgba(26, 26, 36, 0.92) |
| Primary Text | #d9d9e6 |
| Accent (focus/active) | #33ccff |
| Accent (active item) | #00ff99 |
| Muted | #808080 |

## 🐾 Made for AnimAIOS

AnimaDots is the desktop UI layer for [AnimAIOS](https://github.com/animaios/animacore) — an agentic AI desktop OS built around your digital companion. The clean dark theme, smooth animations, and cohesive visual language provide the perfect stage for AI characters to live on your desktop.

---

<div align="center">
  <sub>✨ ✨ ✨</sub>
</div>
