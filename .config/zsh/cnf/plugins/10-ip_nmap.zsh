cnf_10_ip_nmap() {
  local ip="$1"
  local ip_regex="^[0-9]{1,3}(\.[0-9]{1,3}){3}(/[0-9]{1,2})?$"
  
  if [[ $ip =~ $ip_regex ]]; then
    if [[ -e $ip ]]; then return 1; fi
    shift 
    
    if __cmd ipcalc; then
      echo -e "\e[1;34m❯\e[m \e[36mipcalc\e[m \e[1;31m$ip\e[m"
      ipcalc "$ip"
    fi

    if __cmd nmap; then
      echo -e "\e[1;34m❯\e[m \e[36mnmap\e[m \e[33m$@\e[m \e[1;31m$ip\e[m"
      nmap "$@" "$ip"
      return 0
    fi
  fi
  return 1
}
