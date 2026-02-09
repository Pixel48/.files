# Setup zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git" # Setup zinit path
if [[ ! -d "${ZINIT_HOME}" ]]; then # Install Zinit
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh" # Load Zinit

autoload -U zmv

# Fundamental zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

bindkey '^[[Z' reverse-menu-complete

# kill-word per separator
WORDCHARS=''
#WORDCHARS='*?_-.[]~=/&;!#$%^(){}<> '

bindkey '^W' backward-kill-word
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# EMACS & QoL binds
bindkey -e
bindkey '^@' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -s '^[a' '^P^M'
bindkey -s '^[l' ' ls^J'
bindkey -s '^[k' ' ls -T^J'
bindkey -s '^[;' ' ls -lg^J'
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey -s '^[h' ' history^J'
bindkey -s '^[w' '""\C-b'
bindkey -s '^[W' "''\C-b"

# History up/down arrows
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

# History
HISTSIZE=25000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt append_history
setopt share_history
setopt extended_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_verify
setopt hist_expire_dups_first

# Dirs & cd
setopt auto_push_d
setopt auto_cd
setopt completeinword
setopt push_d_ignore_dups

# Dunoo, was in old one
setopt interactive
setopt monitor

__cmd() {
  command -v $1 > /dev/null
}

__cmd2() {
  command -v $1 2> /dev/null
}

# Setup file editor
EDITOR=$(
  __cmd2 nvim ||
  __cmd2 vim ||
  __cmd2 vi ||
  __cmd2 nano ||
  __cmd2 ed ||
  echo "No editor found")
export EDITOR=`basename $EDITOR`

# Setup reader
READER=$(
  __cmd2 bat ||
  __cmd2 less ||
  __cmd2 more ||
  echo "No reader found")
export READER=`basename $READER`

# Setup open
OPEN=$(
  __cmd2 xdg-open ||
  __cmd2 open ||
  echo "No open found")
export OPEN=`basename $OPEN`
alias open=$OPEN

# Load exports
if [ -f ~/.zsh_exports ]; then
  source ~/.zsh_exports
fi

# Load aliases, functions, etc.
if [ -f ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

if [ -f ~/.zsh_functions ]; then
  source ~/.zsh_functions
fi

# Create gitconfig if needed
if [ ! -f ~/.gitconfig ]; then
  source ~/.files/config/git.sh
fi

# Load cygwin workarounds if needed
if [[ `uname` == *CYGWIN* ]]; then
  if [ -f ~/.zsh_cygwin ]; then
    source ~/.zsh_cygwin
  fi
fi

# Zoxide
__cmd zoxide && eval "$(zoxide init --cmd cd zsh)"
if [ -f ~/.zsh_comp ]; then
  source ~/.zsh_comp
fi
alias compconfig="$EDITOR ~/.zsh_comp"

# Zinit caching
# zinit cdreplay -q

if [[ `uname` == *CYGWIN* ]]; then
  cd - > /dev/null
fi

zmodload zsh/zprof

# oh-my-posh
__cmd oh-my-posh || ~/.files/setup/ohmyposh.sh
if [ "$TERM_PROGRAM" != "Apple Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/dev.yml)"
  function set_poshcontext() {
    export JOBS=$(jobs | wc -l | xargs)
    export DIRS=$(dirs | sed -E 's|[^ ]*/||g; s/^[^ ]+( |$)//')
  }
fi

# setup Homebrew
__cmd brew && eval "$(brew shellenv)"

if [ -f ~/.zprofile ]; then
  alias zprofile="$EDITOR ~/.zprofile"
fi

# FZF binds
if command -v fzf 2>&1 >/dev/null; then
  source <(fzf --zsh)
  bindkey "^R" fzf-history-widget
  bindkey "^T" fzf-file-widget
  bindkey "^[c" fzf-cd-widget
fi

# profile
if [ ! -f ~/.profile ]; then
  echo 'alias profile="${EDITOR} ~/.profile"' > ~/.profile
fi
source ~/.profile
