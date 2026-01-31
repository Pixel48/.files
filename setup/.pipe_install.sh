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

curl -fsSL "$@" > installer.sh
command -v bat >/dev/null && bat installer.sh || cat installer.sh
read "install?Approve? [N/y] "
if [[ -z $install || $install != [yY]* ]]; then
  warn "Reverting"
  exit 0
fi

chmod +x installer.sh
if ./installer.sh; then
  final "INSTALLED!"
else
  fatal "INSTALLATION FAILED"
fi
