cnf_70_container_logs() {
  local cmd="$1"
  local id_regex="^[0-9a-fA-F]{12}$"
  
  if [[ $cmd =~ $id_regex ]]; then
    local engine=""
    
    if __cmd podman && podman inspect "$cmd" >/dev/null 2>&1; then
      engine="podman"
    elif __cmd docker && docker inspect "$cmd" >/dev/null 2>&1; then
      engine="docker"
    fi

    if [[ -n "$engine" ]]; then
      echo -e "\e[1;34m❯\e[m \e[36m$engine logs -f --tail 50\e[m \e[1;31m$cmd\e[m"
      "$engine" logs -f --tail 50 "$cmd"
      return 0
    fi
  fi
  
  return 1
}
