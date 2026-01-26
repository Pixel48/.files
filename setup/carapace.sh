#!/usr/bin/env bash
set -euo pipefail

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
error() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2; exit 1; }

log "Installing Carapace completion system..."

if command -v carapace >/dev/null 2>&1; then
    log "Carapace already installed, skipping"
    exit 0
fi

if command -v zypper >/dev/null 2>&1; then
    log "Using zypper package manager..."
    if ! zypper ar --gpgcheck-allow-unsigned -f https://yum.fury.io/rsteube/ carapace; then
        error "Failed to add carapace repository"
    fi
    
    if ! zypper install -y carapace-bin; then
        error "Failed to install carapace-bin"
    fi
else
    error "Unsupported package manager. This script supports zypper."
fi

log "Configuring Carapace..."
carapace_config="
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format \$'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
"

if ! grep -q "carapace _carapace" ~/.profile 2>/dev/null; then
    echo "$carapace_config" >> ~/.profile
    log "Carapace configuration added to ~/.profile"
else
    log "Carapace configuration already exists in ~/.profile"
fi

log "Carapace installed successfully"
