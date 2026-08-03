cnf_110_domain_info() {
  local cmd="$1"
  
  local domain_regex="^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$"
  
  if [[ $cmd =~ $domain_regex ]]; then
    
    if [[ -e $cmd ]]; then return 1; fi

    if __cmd host; then
      echo -e "\e[1;34m❯\e[m \e[36mhost\e[m \e[1;31m$cmd\e[m"
      host "$cmd"
      return 0
      
    elif __cmd dig; then
      echo -e "\e[1;34m❯\e[m \e[36mdig ANY +short\e[m \e[1;31m$cmd\e[m"
      dig ANY +short "$cmd"
      return 0
    fi
  fi
  
  return 1
}
