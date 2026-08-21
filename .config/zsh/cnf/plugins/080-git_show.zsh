cnf_80_git_show() {
  local cmd="$1"
  local hash_regex="^[0-9a-fA-F]{7,40}$"
  
  if [[ $cmd =~ $hash_regex ]] && __cmd git; then
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      if git cat-file -t "$cmd" >/dev/null 2>&1; then
        echo -e "\e[1;34m❯\e[m \e[36mgit show\e[m \e[1;31m$cmd\e[m"
        git show "$cmd"
        return 0
      fi
    fi
  fi
  return 1
}
