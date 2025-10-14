__cmd() {
  command -v $1 > /dev/null
}

__cmd cargo || ~/.files/setup/rust.sh
. ~/.profile
__cmd sccache || cargo install --locked sccache
[ -n "$RUSTC_WRAPPER" ] && echo 'export RUSTC_WRAPPER=sccache' >> ~/.profile

RUSTC_WRAPPER=sccache cargo install --locked cargo-info ripgrep ripgrep-all du-dust eza bat irust bacon porsmo speedtest-rs wiki-tui rtx-cli hd xh zoxide hyperfine fselect tokei just mask presenterm tealdeer open git-ignore-generator fd-find mprocs rusty-man ncspot
