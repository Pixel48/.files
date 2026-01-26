#!/usr/bin/env bash
set -euo pipefail

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
error() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2; exit 1; }

log "Installing UV..."

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

cd "$temp_dir"
if ! curl -LsSf https://astral.sh/uv/install.sh -o uv_installer.sh; then
    error "Failed to download UV installer"
fi

log "Downloaded UV installer ($(wc -l < uv_installer.sh) lines)"
log "Note: UV installer is dynamic and doesn't provide static checksums"

chmod +x uv_installer.sh
if ! ./uv_installer.sh; then
    error "UV installation failed"
fi

log "UV installed successfully"
