cnf_20_qalc_math() {
  local cmd="$1"
  local math_regex="^[0-9]+[\+\-\*\/\^][0-9\+\-\*\/\^\(\)\.]+$"
  
  if [[ $cmd =~ $math_regex ]] && __cmd qalc; then
    echo -e "\e[1;34m❯\e[m \e[36mqalc\e[m \e[1;31m$cmd\e[m"
    qalc "$cmd"
    return 0
  fi
  return 1
}
