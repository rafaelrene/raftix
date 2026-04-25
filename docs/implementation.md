# Implementation Notes

## Commands

- `mise run fmt`: format repo files.
- `mise run lint`: lint repo files.
- `mise run test`: shell syntax checks and Bats tests when present.
- `mise run build:iso`: build the ISO on Linux with Artix `buildiso`.

## Current Shape

- `scripts/raftix-install`: live ISO TUI installer.
- `scripts/raftix`: installed-system maintenance command.
- `scripts/build-iso`: Artix `buildiso` wrapper.
- `share/raftix/packages`: package manifests.
- `share/raftix/config`: install-time config templates.

## Linux Build Host

The ISO build script must run on Linux with `buildiso`, `artools`, and `iso-profiles` available. The current macOS host can lint and edit the repo but cannot build the ISO directly.
