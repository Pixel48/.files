# Enable Powerlevel10k instant promptsource Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Setup zinit path
ZINIT_HOME="${XDG_CACHE_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Install Zinit
if [ ! -d "${ZINIT_HOME}" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Install PowerLevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Fundamental zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load and style completion
autoload -U compinit && compinit # Load completions
eval "$(dircolors -b)" # setup LS_COLORS
zmodload zsh/complist # Load complist
autoload -U colors && colors # Colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # Highlight files like ls --colors
zstyle ':completion:*' menu select # Highlight selected
zstyle ':completion:*' rehash true # To get new binaries into PATH
bindkey '^[[Z' reverse-menu-complete

# Word killing per separator
WORDCHARS=''
#WORDCHARS='*?_-.[]~=/&;!#$%^(){}<> '
bindkey '^W' backward-kill-word
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# EMACS & quality-of-life binds
bindkey -e
bindkey '^@' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -s '^[a' '^P^M'
bindkey -s '^[l' ' ls^J'
bindkey -s '^[L' ' ls -T^J'
bindkey -s '^[:' 'ls -TA^J'
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey -s '^[t' 'tmux^J'

# FZF binds
if command -v fzf 2>&1 >/dev/null && [[ `uname` != *CYGWIN* ]]; then
  source <(fzf --zsh)
  bindkey "^R" fzf-history-widget
  bindkey "^T" fzf-file-widget
  bindkey "^[c" fzf-cd-widget
fi

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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Fundamental aliases
alias reload='source ~/.zshrc'
alias now='date +"%d.%m.%Y %H:%M:%S"'
alias d='dirs -p'
alias .,='popd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -p'
alias ls='ls -C --color' # ls-es
alias lsa='ls -A'
alias lsd='ls -d'
alias lss='ls -sh'
alias l='ls -1'
alias la='l -A'
alias ll='ls -lh'
alias llg='ll -g'
alias lla='ll -A'
alias llag='lla -g'
alias lld='ll -d'
alias lldg='lld -g'

# Setup file editor
EDITOR=$(
	command -v nvim 2>/dev/null ||
	command -v vim 2>/dev/null ||
	command -v vi 2>/dev/null ||
	command -v nano 2>/dev/null ||
	command -v ed 2>/dev/null ||
	 echo "echo No editor found")
EDITOR=`basename $EDITOR`

alias ${EDITOR}rc="${EDITOR} ~/.${EDITOR}rc"

# Aliases for editing config files
alias zshrc="${EDITOR} ~/.zshrc"

# Load aliases, functions, exports, etc.
if [ -f ~/.zsh_functions ]; then
  source ~/.zsh_functions
  alias functions="${EDITOR} ~/.zsh_functions"
fi

if [ -f ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
  alias aliases="${EDITOR} ~/.zsh_aliases"
fi

if [ -f ~/.zsh_exports ]; then
  source ~/.zsh_exports
  alias exports="${EDITOR} ~/.zsh_exports"
fi

# Load gitconfig if needed
if [ ! -f ~/.gitconfig ]; then
  source ~/.files/gitconfig.sh
fi
alias gitconfig="${EDITOR} ~/.files/gitconfig.sh"

# Load cygwin workarounds if needed
if [[ `uname` == *CYGWIN* ]]; then
  if [ -f ~/.zsh_cygwin ]; then
    source ~/.zsh_cygwin
    alias cygwin="${EDITOR} ~/.zsh_cygwin"
  fi
fi

# Zoxide
export PATH=$PATH:${HOME}/.local/bin
eval "$(zoxide init --cmd cd zsh)"

# Zinit caching
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ `uname` == *CYGWIN* ]]; then
  cd - > /dev/null
fi
