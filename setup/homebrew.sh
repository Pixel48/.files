#!/usr/bin/env bash
set -euo pipefail

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
error() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2; exit 1; }

log "Installing Homebrew..."

if command -v brew >/dev/null 2>&1; then
    log "Homebrew already installed, skipping"
    exit 0
fi

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

cd "$temp_dir"
if ! curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o homebrew_installer.sh; then
    error "Failed to download Homebrew installer"
fi

log "Downloaded Homebrew installer ($(wc -l < homebrew_installer.sh) lines)"
log "Note: Homebrew installer is dynamic and uses HTTPS verification via GitHub"

chmod +x homebrew_installer.sh
if ! ./homebrew_installer.sh; then
    error "Homebrew installation failed"
fi

log "Homebrew installed successfully"
log "Please run 'brew doctor' to verify installation"
