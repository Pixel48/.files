cnf_999_pkg_suggest() {
  local cmd="$1"
  local pkg_manager=""
  local suggestion=""

  if [[ "$cmd" == */* ]] || [[ ${#cmd} -lt 2 ]] || [[ "$cmd" == .* ]] || [[ "$cmd" == :* ]]; then
    return 1
  fi

  if __cmd apt-file; then
    pkg_manager="apt"
    suggestion=$(apt-file search --regex "/[s]?bin/${cmd}$" | head -n 1 | cut -d: -f1)
  elif __cmd dnf; then
    pkg_manager="dnf"
    suggestion=$(dnf provides "*/bin/$cmd" | head -n 1 | awk '{print $1}')
  elif __cmd paru; then
    pkg_manager="paru"
    suggestion=$(paru -Ssq "^$cmd$" | head -n 1 | sed 's,^.*/,,')
  elif __cmd yay; then
    pkg_manager="yay"
    suggestion=$(yay -Ssq "^$cmd$" | head -n 1 | sed 's,^.*/,,')
  elif __cmd pkgfile; then
    pkg_manager="pacman"
    suggestion=$(pkgfile "$cmd" | head -n 1 | awk '{print $1}' | sed 's,^.*/,,')
  elif __cmd brew; then
    pkg_manager="brew"
    suggestion=$(brew search --formulae "/^${cmd}$/" | head -n 1)
  fi

  if [[ -n "$suggestion" ]]; then
    local install_cmd=""
    local elev=""

    if __cmd doas; then
      elev="doas "
    elif __cmd sudo; then
      elev="sudo "
    fi

    case "$pkg_manager" in
      apt)      install_cmd="${elev}apt install $suggestion" ;;
      dnf)      install_cmd="${elev}dnf install $suggestion" ;;
      paru)     install_cmd="paru -S $suggestion" ;;
      yay)      install_cmd="yay -S $suggestion" ;;
      pacman)   install_cmd="${elev}pacman -S $suggestion" ;;
      brew)     install_cmd="brew install $suggestion" ;;
      *)        return 1 ;;
    esac

    echo "zsh: command not found: $cmd"
    echo -e "  You can install it with: \e[36m$install_cmd\e[m"
    return 0
  fi

  return 1
}
