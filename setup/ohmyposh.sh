#!/usr/bin/env bash
set -euo pipefail

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
error() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2; exit 1; }

log "Installing Oh My Posh..."

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

cd "$temp_dir"
if ! curl -s https://ohmyposh.dev/install.sh -o ohmyposh_installer.sh; then
    error "Failed to download Oh My Posh installer"
fi

log "Downloaded Oh My Posh installer ($(wc -l < ohmyposh_installer.sh) lines)"
log "Note: Oh My Posh installer is dynamic and doesn't provide static checksums"

chmod +x ohmyposh_installer.sh
if ! ./ohmyposh_installer.sh; then
    error "Oh My Posh installation failed"
fi

log "Oh My Posh installed successfully"
