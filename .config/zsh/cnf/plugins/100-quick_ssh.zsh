cnf_100_quick_ssh() {
  local cmd="$1"
  local is_target=false
  
  local ssh_regex="^[a-zA-Z0-9_.-]+@[a-zA-Z0-9_.-]+$"
  if [[ $cmd =~ $ssh_regex ]]; then
    is_target=true
  fi
  
  if ! $is_target && [[ -f ~/.ssh/config ]]; then
    if awk -v tgt="$cmd" 'tolower($1) == "host" { for(i=2; i<=NF; i++) if($i == tgt) { found=1; exit } } END { exit !found }' ~/.ssh/config; then
      is_target=true
    fi
  fi
  
  if $is_target && __cmd ssh; then
    shift
    echo -e "\e[1;34m❯\e[m \e[36mssh\e[m \e[1;31m$cmd\e[m \e[33m$@\e[m"
    ssh "$cmd" "$@"
    return 0
  fi
  
  return 1
}
