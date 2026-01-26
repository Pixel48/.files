#!/usr/bin/env bash
set -euo pipefail

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
error() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2; exit 1; }

log "Installing QMK firmware tools..."

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

cd "$temp_dir"
if ! curl -fsSL https://install.qmk.fm -o qmk_installer.sh; then
    error "Failed to download QMK installer"
fi

log "Note: QMK installer is dynamic and doesn't provide static checksums"
log "Downloaded $(wc -l < qmk_installer.sh) lines of installer code"

chmod +x qmk_installer.sh
if ! ./qmk_installer.sh; then
    error "QMK installation failed"
fi

log "QMK firmware tools installed successfully"
