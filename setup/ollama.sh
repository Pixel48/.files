#!/usr/bin/env bash
set -euo pipefail

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
error() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2; exit 1; }

log "Installing Ollama..."

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

cd "$temp_dir"
if ! curl -fsSL https://ollama.com/install.sh -o ollama_installer.sh; then
    error "Failed to download Ollama installer"
fi

log "Downloaded Ollama installer ($(wc -l < ollama_installer.sh) lines)"
log "Note: Ollama installer is dynamic and doesn't provide static checksums"

chmod +x ollama_installer.sh
if ! ./ollama_installer.sh; then
    error "Ollama installation failed"
fi

log "Ollama installed successfully"
