#!/usr/bin/env bash
set -euo pipefail

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
error() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2; exit 1; }

log "Installing OpenCode..."

mkdir -p ~/.config/opencode/

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

cd "$temp_dir"
if ! curl -fsSL https://opencode.ai/install -o opencode_installer.sh; then
    error "Failed to download OpenCode installer"
fi

log "Downloaded OpenCode installer ($(wc -l < opencode_installer.sh) lines)"
log "Note: OpenCode installer is dynamic and doesn't provide static checksums"

chmod +x opencode_installer.sh
if ! ./opencode_installer.sh; then
    error "OpenCode installation failed"
fi

log "OpenCode installed successfully"
