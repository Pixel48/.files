cnf_60_auto_editor() {
  local cmd="$1"
  if [[ -f "$cmd" ]]; then
    if [[ -x "$cmd" ]]; then
      return 1
    fi
    if ! file -b --mime-encoding "$cmd" | grep -q "binary"; then
      local editor="${EDITOR:-nvim}"
      echo -e "\e[1;34m❯\e[m \e[36m$editor\e[m \e[1;31m$cmd\e[m"
      "$editor" "$cmd"
      return 0
    fi
  fi
  return 1
}
