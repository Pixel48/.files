cnf_40_pastel_color() {
  local cmd="$1"
  local hex_regex="^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
  
  if [[ $cmd =~ $hex_regex ]] && __cmd pastel; then
    local hex="$cmd"
    [[ $hex != \#* ]] && hex="#$hex"

    echo -e "\e[1;34m❯\e[m \e[36mpastel color\e[m \e[1;31m$hex\e[m"
    pastel color "$hex"
    return 0
  fi
  return 1
}
