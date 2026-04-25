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
- `scripts/proxmox/create-build-vm`: parameterized Proxmox helper for a UEFI build/test VM.
- `share/raftix/packages`: package manifests.
- `share/raftix/config`: install-time config templates.

## Linux Build Host

The ISO build script must run on Linux with `buildiso`, `artools`, and `iso-profiles` available. The current macOS host can lint and edit the repo but cannot build the ISO directly.

`buildiso` needs its workspace on a normal writable Linux filesystem. Do not run it from the live ISO overlay filesystem. Install Artix into the VM disk first, or mount a real ext4/xfs/btrfs disk and set:

```sh
export ARTOOLS_WORKSPACE=/var/lib/artools
```

The wrapper defaults to `/var/lib/artools`.

## Proxmox Build VM Helper

`scripts/proxmox/create-build-vm` defaults to:

- `VMID=9000`
- `STORAGE=local-lvm`
- `ISO_STORAGE=local`
- `ISO_IMAGE=artix-base-openrc.iso`

Optional variables:

- `PVE_HOST`, default `root@pve`.
- `NAME`, default `raftix-build`.
- `MEMORY`, default `16384`.
- `CORES`, default `8`.
- `DISK_SIZE`, default `100` GiB. `100G` is accepted and normalized.
- `BRIDGE`, default `vmbr0`.
