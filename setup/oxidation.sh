#!/usr/bin/env bash
set -eo pipefail

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
error() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2; exit 1; }

show_help() {
    cat << EOF
Usage: $0 [-e]

Install Rust development tools.

Options:
    -e                  Install only essential tools
    -h, --help         Show this help message

Essential tools: ripgrep, dust, eza, bat, fd-find, zoxide, xh, hyperfine, 
                 tokei, just, tealdeer

Additional tools: ripgrep-all, irust, bacon, porsmo, speedtest-rs, 
                  wiki-tui, rtx-cli, hd, fselect, mask, presenterm, 
                  git-ignore-generator, mprocs, rusty-man, ncspot, open
EOF
}

ESSENTIAL_ONLY=false
while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--essential-only)
            ESSENTIAL_ONLY=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            error "Unknown option: $1"
            ;;
    esac
done

log "Setting up Rust development environment..."

check_cmd() {
    command -v "$1" >/dev/null 2>&1
}

if ! check_cmd rustc; then
    log "Rust not found, installing first..."
    if ! ~/.files/setup/rust.sh; then
        error "Failed to install Rust"
    fi
    source ~/.profile
fi

if ! check_cmd sccache; then
    log "Installing sccache..."
    if ! cargo install sccache; then
        error "Failed to install sccache"
    fi
fi

if [ -z "$RUSTC_WRAPPER" ]; then
    log "Setting RUSTC_WRAPPER..."
    echo 'export RUSTC_WRAPPER=sccache' >> ~/.profile
fi

log "Installing essential Rust tools..."
if ! RUSTC_WRAPPER=sccache cargo install --locked \
    ripgrep du-dust eza bat fd-find zoxide xh hyperfine tokei just tealdeer mcdu; then
    error "Failed to install essential Rust tools"
fi

if [ "$ESSENTIAL_ONLY" = false ]; then
    log "Installing additional Rust tools..."
    if ! RUSTC_WRAPPER=sccache cargo install --locked \
        ripgrep-all irust bacon porsmo speedtest-rs wiki-tui rtx-cli \
        hd fselect mask presenterm git-ignore-generator mprocs open \
        rusty-man ncspot; then
        log "WARNING: Some additional tools failed to install"
    fi
fi

log "Rust development environment setup complete"
