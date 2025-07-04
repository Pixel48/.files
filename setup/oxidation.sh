__cmd() {
  command -v $1 > /dev/null
}

__cmd cargo || ~/.files/setup/rust.sh

__cmd sccache || cargo install sccache
[ -n "$RUSTC_WRAPPER" ] && echo 'export RUSTC_WRAPPER=sccache' >> ~/.profile

RUSTC_WRAPPER=sccache cargo install --locked cargo-info nu ripgrep du-dust eza bat irust bacon porsmo speedtest-rs wiki-tui rtx-cli hd xh zoxide hyperfine fselect ncspot tokei just mask presenterm
