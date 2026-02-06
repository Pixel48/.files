${0%/*}/.pipe_install.sh https://sh.rustup.rs
if command -v cargo >/dev/null || echo ". ~/.cargo/env" >> $PROFILE
