#!/usr/bin/env bash
set -eo pipefail

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
error() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2; exit 1; }

reload_rust_env() {
    if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
    elif [ -f "$HOME/.rustup/env" ]; then
        source "$HOME/.rustup/env"
    fi
    
    export PATH="$HOME/.cargo/bin:$PATH"
}

show_help() {
    cat << EOF
Usage: $0 [-e|-h]

Install Rust and Rust development tools.

This script handles:
  1. Installing Rust (via rustup) if not present
  2. Setting up sccache for faster builds
  3. Installing essential and optional Rust tools

Options:
    -e, --essential-only   Install only essential tools (faster)
    -h, --help            Show this help message

Essential tools: ripgrep, dust, eza, bat, fd-find, zoxide, xh,
                 hyperfine, tokei, just, tealdeer, mcdu

Additional tools: ripgrep-all, irust, bacon, porsmo, speedtest-rs, 
                  wiki-tui, rtx-cli, hd, fselect, mask, presenterm, 
                  git-ignore-generator, mprocs, open, rusty-man, ncspot
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

reload_rust_env

if ! check_cmd rustc; then
    log "Rust not found, installing..."
    if command -v curl &>/dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        reload_rust_env
    else
        error "curl not found, cannot install Rust"
    fi
fi

reload_rust_env

if ! check_cmd cargo; then
    error "Cargo not found after Rust installation"
fi

if ! check_cmd sccache; then
    log "Installing sccache..."
    if ! cargo install sccache; then
        error "Failed to install sccache"
    fi
fi

if [ -z "$RUSTC_WRAPPER" ]; then
    log "Setting RUSTC_WRAPPER..."
    if [ -f "$HOME/.profile" ]; then
        if ! grep -q "RUSTC_WRAPPER=sccache" "$HOME/.profile"; then
            echo 'export RUSTC_WRAPPER=sccache' >> "$HOME/.profile"
        fi
    fi
    export RUSTC_WRAPPER=sccache
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
log "Run 'source ~/.cargo/env' or restart your shell to use installed tools"
