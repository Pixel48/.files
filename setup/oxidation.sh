__cmd() {
  command -v $1 > /dev/null
}

__cmd cargo || ~/.files/setup/rust.sh

__cmd sccache || cargo install --locked sccache
[ -n "$RUSTC_WRAPPER" ] && echo export RUSTC_WRAPPER=sccache >> ~/.zprofile
RUSTC_WRAPPER=sccache cargo install --locked cargo-info nu ripgrep du-dust exa bat irust bacon porsmo speedtest-rs wiki-tui mrpocs rtx-cli zellij gitui ncspot hd xh zoxide
