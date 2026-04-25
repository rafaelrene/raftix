# Good Distribution Plan

Goal: build Raftix as a personal Artix-based distribution that boots into a fully pre-configured system matching Rafael's preferences.

## Status

Current focus: smoke tests.

## Decisions

- Raftix targets multiple personal machines, not one fixed model.
- First validation target is a Proxmox VM on `ssh root@pve`.
- Boot mode: UEFI.
- Hostname must be configurable during installation.
- Username must be configurable during installation.
- Locale: `en_US.UTF-8`.
- Keyboard layouts: English QWERTY and Slovak QWERTY.
- Timezone: `Europe/Bratislava`.
- Laptop-specific behavior must be configurable during installation.
- First Proxmox VM test profile: 8 CPU cores, 16 GB RAM, 100 GB disk.
- Bluetooth enabled by default.
- Prefer Wayland.
- Audio stack: modern default, with Bluetooth audio codec support.
- Input defaults: touchpad gestures and keyboard layout switching enabled.
- Networking: NetworkManager.
- Firmware policy: install broad firmware set.
- Audio stack: PipeWire + WirePlumber.
- Kernel: `linux`.
- CPU microcode: ask during installation.
- Filesystem: Btrfs.
- Encryption: full disk encryption by default.
- Init system: OpenRC.
- Bootloader: GRUB.
- Swap: zram by default; optional encrypted swap partition when hibernate is selected.
- Encryption unlock: passphrase only.
- Snapshots: automatic, with retention limits so they do not consume excessive disk space.
- Btrfs layout: `@`, `@home`, `@snapshots`, `@var_log`, `@cache`.
- Snapshot tool: Snapper with timeline and package snapshots.
- Snapshot retention: hourly 3, daily 3, weekly 2, monthly 0, yearly 0.
- Snapshot cleanup: snapshots max 20% of root filesystem; keep at least 50% free.
- Installer artifact: custom bootable ISO.
- Installer UI: TUI.
- TUI implementation: `dialog`.
- Disk setup: interactive partition choices.
- Installer scope: Proxmox VM first, real hardware later.
- Internet: required during installation.
- Package installation: repo and AUR packages are installed/built live during installation.
- AUR packages: allowed.
- AUR strategy: build selected AUR packages live during installation.
- Firewall: UFW enabled by default.
- Printing/scanning: CUPS and SANE installed/enabled by default.
- Fonts: Nerd Fonts, especially JetBrainsMono Nerd Font, with ligature support.
- SSH server: enabled by default.
- Bluetooth GUI: blueman.
- Audio compatibility: pipewire-pulse enabled for PulseAudio clients.
- Power management: ask during installation.
- Time synchronization: chrony.
- Desktop/session: Niri.
- Terminal: Ghostty.
- Launcher: Vicinae.
- Theme: Catppuccin Mocha.
- Login: greetd + tuigreet.
- Bar: Waybar.
- Notifications: mako.
- Lock/idle: swaylock-effects + swayidle.
- Portals: xdg-desktop-portal-gnome for Niri screencasting.
- Screenshot workflow: hotkey captures screenshot, opens editor for annotation/light edits, then copies final image to clipboard without saving to disk by default.
- Wallpaper: install swaybg and mpvpaper; use swaybg by default.
- Screenshot stack: grim + slurp + swappy + wl-clipboard.
- Clipboard: wl-clipboard plus Vicinae clipboard first; do not add cliphist initially.
- X11 compatibility: xwayland-satellite enabled by default.
- Wallpaper asset: `wallpapers/akame-ga-kill.png`.
- Screenshot keybindings: `Ctrl+1` fullscreen screenshot into editor/clipboard workflow; `Ctrl+2` area selection screenshot into editor/clipboard workflow.
- Niri keybindings:
  - `Super+Enter`: Ghostty.
  - `Super+Space`: Vicinae.
  - `Super+Q`: close window.
  - `Super+F`: fullscreen window.
  - `Super+Shift+F`: toggle floating.
  - `Super+H/J/K/L` and `Super+Arrow`: focus.
  - `Super+Shift+H/J/K/L`: move window.
  - `Super+Ctrl+H/L`: move column left/right.
  - `Super+Tab`: overview.
  - `Super+1..9`: switch workspace.
  - `Super+Shift+1..9`: move window to workspace.
  - `Super+Minus/Equal`: decrease/increase column width.
  - `Super+R`: reload Niri config.
  - `Super+Shift+E`: exit/logout.
  - `Super+L`: lock screen.
- Config source: remote repository, latest version pulled during installation.
- Reference/prototype repo: `https://github.com/rafaelrene/ansible-starter`.
- Initial config scope: configs first; packages and SSH key provisioning later.
- Secret encryption: age.
- Secret unlock: installer asks for a single passphrase.
- Temporary development passphrase: `agepass`; must be changed before real use.
- Config repo: new dedicated Raftix config repository.
- Config repo URL: `https://github.com/rafaelrene/dotforge`.
- Config deployment: pull latest remote during installation; no frozen ISO fallback.
- Config management style: plain files plus install scripts, not Ansible as core config system.
- Secret restore scope: SSH keys only for v1.
- Installer behavior: fail installation if config repo cannot be pulled.
- SSH secret layout: `secrets/ssh/id_ed25519.age` plus `secrets/ssh/id_ed25519.pub`.
- SSH restore permissions: `~/.ssh` 700, private key 600, public key 644.
- Shell: nushell.
- Editors: Neovim and Cursor.
- Browsers: Zen, Helium, Chromium.
- Dev tools: git, podman, mise, Taskfile.
- Programming languages: installed through mise, not system packages.
- Mise languages: `node@lts`, `python@3`, `go`, `rust`, `zig`.
- CLI tools: ripgrep, fd, fzf, bat, eza, zoxide, jq, tmux, btop.
- Media: mpv.
- Shell/project environment: direnv integrated with nushell and mise.
- YAML CLI: yq.
- File managers: nautilus and yazi.
- Image viewer: loupe.
- Archive manager: file-roller.
- Package sources:
  - Zen: AUR `zen-browser-bin`.
  - Helium: AUR `helium-browser-bin`.
  - Cursor: AUR `cursor-bin`.
  - Taskfile: Arch package `go-task`.
- Taskfile is installed as a system package/local repo package, not mise-managed.
- Default browser: Zen.
- Default CLI editor: Neovim.
- Default terminal: Ghostty.
- Default user shell: nushell.
- Root shell: bash.
- Default file manager: Nautilus.
- Default image viewer: Loupe.
- Default video/audio player: mpv.
- Default archive manager: File Roller.
- XDG dirs: mostly standard; configs under `~/.config/`.
- Environment defaults: `EDITOR=nvim`, `VISUAL=cursor`, `TERMINAL=ghostty`, `BROWSER=zen-browser`.
- MIME defaults: web/html/http/https/PDF to Zen; images to Loupe; video/audio to mpv; archives to File Roller; directories to Nautilus; text/code to Cursor where applicable.
- Snapshots before updates: yes.
- Backups: out of scope for v1.
- Package cache cleanup: enabled.
- Update policy: manual only through `raftix update`.
- Package manager UX: use paru as the pacman wrapper for repo and AUR packages.
- AUR helper: paru.
- Mirrors: rank mirrors during installation.
- Maintenance commands: `raftix update`, `raftix clean`, `raftix doctor`.
- Mirror ranking: rank Artix mirrors; also rank Arch mirrors if Arch repos are enabled.
- Cache cleanup: keep latest 2 versions of installed packages, 0 versions of uninstalled packages; remove paru build cache during `raftix clean`.
- ISO artifact naming: `raftix-YYYY.MM.DD-x86_64.iso`.
- Versioning: date-based.
- ISO build tool: Artix `buildiso`/`artools`.
- Build host: current host machine.
- Release verification: SHA256 checksum for v1.
- AUR package build timing: during installation.
- Smoke tests: run automatically after install.
- Proxmox test automation: out of scope; user will test ISO manually.
- ISO acceptance checks: boot, network, disk encryption, GRUB, user login, Niri, Ghostty, Vicinae, Waybar, audio, Bluetooth, SSH, Zen, snapshots, `raftix update`, screenshot clipboard workflow.

## Plan

1. Target machine/profile
2. Base system
3. Installer flow
4. System defaults
5. Desktop/session
6. User config source
7. Package set
8. Opinionated defaults
9. Update/maintenance
10. Build/release
11. Smoke tests

## Open Questions

### 1. Target machine/profile

- Hardware support policy for real machines:
  - CPU: ask during installation.
  - GPU: ask during installation.
  - Wi-Fi: NetworkManager with broad firmware support.
  - Bluetooth: service enabled by default or optional.
  - Displays: auto-detect during installation where possible.

### 2. Base System

- No open questions.

### 3. Installer Flow

- Exact live package installation flow.

### 4. System Defaults

- No open questions.

### 5. Desktop/Session

- No open questions.

### 6. User Config Source

- No open questions.

### 7. Package Set

- No open questions.

### 8. Opinionated Defaults

- No open questions.

### 9. Update/Maintenance

- No open questions.

### 10. Build/Release

- No open questions.

### 11. Smoke Tests

- No open questions.
