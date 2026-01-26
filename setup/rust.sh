#!/usr/bin/env bash
set -euo pipefail

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
error() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2; exit 1; }

log "Installing Rust..."

if command -v rustc >/dev/null 2>&1; then
    log "Rust already installed, skipping"
    exit 0
fi

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

cd "$temp_dir"
if ! curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup.sh; then
    error "Failed to download Rust installer"
fi

log "Downloaded rustup installer ($(wc -l < rustup.sh) lines)"

chmod +x rustup.sh
if ! ./rustup.sh -y; then
    error "Rust installation failed"
fi

log "Rust installed successfully"
log "Please run: source ~/.cargo/env or restart your shell"
