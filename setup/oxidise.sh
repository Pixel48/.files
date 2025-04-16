__cmd() {
  command -v $1 > /dev/null
}

__cmd cargo || ~/.files/setup/rust.sh

cargo install sccache
echo export RUSTC_WRAPPER=sccache >> ~/.zprofile
RUSTC_WRAPPER=sccache cargo install \
  cargo-info \ # better cargo info
  cargo-watch \ # ???
  nu \ # modern shell /w structured pipelines
  ripgrep \ # better grep
  du-dust \ # better du
  exa \ # better ls
  bat \ # better cat
  irust \ # rust interpreter
  bacon \ # rust background compiler
  porsmo \ # pomodoro
  speedtest-rs \ # speedtest
  wiki-tui \ # wikipedia terminal ui
  mrpocs \ # single proc monitor
  rtx-cli \ # env-ver final manager
  # zellij \ # terminal muxer
  # gitui \ # git terminal ui (seems broken on mac)
  # ncspot \ # spotify terminal ui
