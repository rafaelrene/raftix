#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/../.." && pwd)"
SHARE_DIR="${RAFTIX_SHARE_DIR:-$REPO_ROOT/share/raftix}"
export REPO_ROOT SHARE_DIR

die() {
	printf 'error: %s\n' "$*" >&2
	exit 1
}

log() {
	printf '==> %s\n' "$*"
}

require_cmd() {
	command -v "$1" >/dev/null 2>&1 || die "missing command: $1"
}

require_root() {
	[[ "${EUID:-$(id -u)}" -eq 0 ]] || die "run as root"
}

run() {
	log "$*"
	"$@"
}

read_list() {
	local file="$1"
	[[ -f "$file" ]] || die "missing list: $file"
	sed '/^[[:space:]]*$/d' "$file"
}

copy_file() {
	local src="$1"
	local dst="$2"
	install -Dm644 "$src" "$dst"
}

copy_exec() {
	local src="$1"
	local dst="$2"
	install -Dm755 "$src" "$dst"
}

append_once() {
	local line="$1"
	local file="$2"
	touch "$file"
	grep -Fxq "$line" "$file" || printf '%s\n' "$line" >>"$file"
}

chroot_run() {
	local target="$1"
	shift
	artix-chroot "$target" "$@"
}

dialog_input() {
	local title="$1"
	local prompt="$2"
	local default="${3:-}"
	dialog --clear --title "$title" --inputbox "$prompt" 10 70 "$default" 3>&1 1>&2 2>&3
}

dialog_password() {
	local title="$1"
	local prompt="$2"
	dialog --clear --title "$title" --passwordbox "$prompt" 10 70 3>&1 1>&2 2>&3
}

dialog_yesno() {
	local title="$1"
	local prompt="$2"
	dialog --clear --title "$title" --yesno "$prompt" 10 70
}

dialog_menu() {
	local title="$1"
	local prompt="$2"
	shift 2
	dialog --clear --title "$title" --menu "$prompt" 20 80 10 "$@" 3>&1 1>&2 2>&3
}

dialog_msg() {
	local title="$1"
	local prompt="$2"
	dialog --clear --title "$title" --msgbox "$prompt" 12 80
}
