# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Setup zinit path
ZINIT_HOME="${HOME}/.local/zinit/zinit.git"

# Install Zinit
if [ ! -d "${ZINIT_HOME}" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
. "${ZINIT_HOME}/zinit.zsh"

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
#export ZLS_COLORS=':hl=0;30:hl=37;40' # Selected with white bg black fg
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # Highlight files like ls --colors
zstyle ':completion:*' menu select # Highlight selected
zstyle ':completion:*' rehash true # To get new binaries into PATH
bindkey '^[[Z' reverse-menu-complete

# Word killing per separator
WORDCHARS=''
#WORDCHARS='*?_-.[]~=/&;!#$%^(){}<> '
bindkey '^W' backward-kill-word

# EMACS & quality-of-life binds
bindkey -e
bindkey '^@' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -s '^[a' '^P^M'
bindkey -s '^[l' ' ls^J'
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

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
alias ls='ls -C --color'
alias lsa='ls -A'
alias ll='ls -l'
alias lla='lsa -l'
alias l='ls -1'
alias lsd='ls -d'

# Config files
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi

if [ -f ~/.zsh_functions ]; then
  . ~/.zsh_functions
fi

if [ -f ~/.zsh_exports ]; then
  . ~/.zsh_exports
fi

# Cygwin workarounds
case `uname` in
  *CYGWIN*|*MINGW*|*MSYS*)
#    basedir=`cygpath -w "$basedir"`
    here=/cygdrive/c/Users/`whoami`;;
esac

# Zoxide
export PATH=$PATH:${HOME}/.local/bin
eval "$(zoxide init --cmd cd zsh)"

# Zinit caching
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
