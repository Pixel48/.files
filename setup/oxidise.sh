__cmd() {
  command -v $1 > /dev/null
}

__cmd cargo || ~/.files/setup/rust.sh

cargo install sccache
[ -n "$RUSTC_WRAPPER" ] && echo export RUSTC_WRAPPER=sccache >> ~/.zprofile
RUSTC_WRAPPER=sccache cargo install cargo-info cargo-watch nu ripgrep \
  du-dust exa bat irust bacon porsmo speedtest-rs wiki-tui mrpocs rtx-cli \
  zellij gitui ncspot
