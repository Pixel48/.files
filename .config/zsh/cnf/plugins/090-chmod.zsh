cnf_90_chmod() {
  local cmd="$1"
  local chmod_regex="^[ugoa]*[-+=][rwxXst]+$"
  
  if [[ $cmd =~ $chmod_regex ]] && __cmd chmod; then
    local perms="$cmd"
    shift
    if [[ ${#@} -eq 0 ]]; then
      echo -e "\e[1;31mBłąd: podano uprawnienia ($perms), ale brakuje pliku.\e[0m"
      return 0
    fi
    echo -e "\e[1;34m❯\e[m \e[36mchmod\e[m \e[33m$perms\e[m \e[1;31m$@\e[m"
    chmod "$perms" "$@"
    return 0
  fi
  return 1
}
