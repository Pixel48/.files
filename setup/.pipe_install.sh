#!/usr/bin/env bash
set -euo pipefail

tmpdir=$(mktemp -d)
pushd "$tmpdir"
trap 'popd; rm -rf "$tmpdir"' EXIT

final() { echo -e "\e[07;92m$*\e[m"; }
good() { echo -e "\e[32m$*\e[m"; }
debug() { echo -e "\e[35m$*\e[m"; }
log() { echo -e "\e[97m$*\e[m"; }
warn() { echo -e "\e[33m$*\e[m"; }
error() { echo -e "\e[31m$*\e[m" >&2; exit 1; }
fatal() { echo -e "\e[07;91m$*\e[m"; }

if ! curl -fsSL "$@" > installer.sh; then
  error "Failed to download installer from: $@"
fi

if [ ! -s installer.sh ]; then
  error "Downloaded installer is empty"
fi

command -v bat >/dev/null && bat installer.sh || cat installer.sh

auto_approve=false
for arg in "$@"; do
  case $arg in
    -y|--yes|--assume-yes) auto_approve=true ;;
  esac
done

if [ "$auto_approve" = false ]; then
  read -p "Approve? [N/y] " install
  if [[ -z $install || $install != [yY]* ]]; then
    warn "Reverting"
    exit 0
  fi
fi

chmod +x installer.sh
if ./installer.sh; then
  final "INSTALLED!"
else
  fatal "INSTALLATION FAILED"
fi
