cnf_50_port_check() {
  local cmd="$1"
  local port_regex="^:([0-9]{1,5})$"
  
  if [[ $cmd =~ $port_regex ]] && __cmd ss; then
    local port="${cmd#:}"
    if (( port > 0 && port <= 65535 )); then
      local elev=""
      if __cmd doas; then
        elev="doas "
      elif __cmd sudo; then
        elev="sudo "
      fi
      local finder=""
      if __cmd rg; then
        finder="rg"
      elif __cmd grep; then
        finder="grep"
      fi
      echo -e "\e[1;34m❯\e[m \e[36m${elev}ss -tulnp | $finder\e[m \e[1;31m:$port\e[m"
      ${=elev}ss -tulnp | grep ":$port"
      return 0
    fi
  fi
  return 1
}
