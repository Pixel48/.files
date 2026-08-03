local plugin_dir="$HOME/.config/zsh/cnf/plugins"
typeset -a cnf_plugins=()

if [[ -d "$plugin_dir" ]]; then
  for plugin_file in "$plugin_dir"/*.zsh(N) "$plugin_dir"/*.sh(N); do
    source "$plugin_file"
  done
  
  for func in ${(onk)functions}; do
    if [[ "$func" == cnf_* ]]; then
      cnf_plugins+=("$func")
    fi
  done
fi

command_not_found_handler() {
  local cmd="$1"
  
  for plugin in "${cnf_plugins[@]}"; do
    if [[ -n "$plugin" ]] && type "$plugin" >/dev/null 2>&1; then
      if "$plugin" "$@"; then
        return 0
      fi
    fi
  done

  # Fallback systemowy
  echo "zsh: command not found: $cmd" >&2
  return 127
}
