# --- AUTO-DISCOVERY DLA COMMAND_NOT_FOUND ---
local plugin_dir="$HOME/.config/zsh/cnf/plugins"
typeset -a cnf_plugins=()

if [[ -d "$plugin_dir" ]]; then
  # 1. Wczytujemy pliki z obu rozszerzeń, nie przejmując się bałaganem
  for plugin_file in "$plugin_dir"/*.zsh(N) "$plugin_dir"/*.sh(N); do
    source "$plugin_file"
  done
  
  # 2. Bezpieczna introspekcja. 
  # MAGIA: (onk) oznacza Order Ascending, Numeric, Keys.
  # Dzięki literce 'n', funkcja cnf_100_... zawsze będzie po cnf_90_...
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
