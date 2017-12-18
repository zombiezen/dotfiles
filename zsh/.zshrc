#!/bin/zsh
# .zshrc
# By Ross Light

## PROMPT ##

precmd() {
  vcs_info
}

# Left prompt:
# exit code 1
#
# user@host:cwd
# vcs_info (line disappears if no VCS is in use
# Z
PROMPT=\
$'%(?..%F{red}exit code %?%f\n)'\
$'\n%F{cyan}%n@%m%f:%F{magenta}%~%f\n'\
$'${vcs_info_msg_0_}'\
$'%(!.#.Z) '

setopt promptsubst

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' get-mq false
zstyle ':vcs_info:*' get-bookmarks false
zstyle ':vcs_info:*' use-prompt-escapes true

zstyle ':vcs_info:*' unstagedstr '+'
zstyle ':vcs_info:*' branchformat '%b'
zstyle ':vcs_info:*' hgrevformat '%r'
zstyle ':vcs_info:*' patch-format ' [%p]'
zstyle ':vcs_info:*' nopatch-format ''
zstyle ':vcs_info:*' formats $'%F{cyan}%s%f:%b/%F{magenta}%S%f%m %u\n'
zstyle ':vcs_info:*' actionformats $'%F{cyan}%s%f:%b/%F{magenta}%S%f%m [%a]%u\n'

## SHELL VARIABLES ##

# Use Vim key bindings
bindkey -v
# Make cd implicit
setopt autocd
# Add warning for redirecting to existing files
setopt noclobber
# Add a couple more interesting globs
setopt extendedglob
# Allow comments on the command line
setopt interactivecomments

# History
# Makes multiple terminals share history nicely
setopt sharehistory
if ! [[ -d "${XDG_DATA_HOME:-$HOME/.local/share}/zsh" ]]; then
  mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
fi
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
HISTSIZE=1000
SAVEHIST=1000

## ALIASES ##

alias ls="ls --color"
alias GRP="grep -Hn --color"
alias bzip2="bzip2 -k"
alias bunzip2="bunzip2 -k"

alias -g pgd="| ${PAGER-less}"
alias -g cdf="| colordiff"

ll() { ls -l -h "$@" }
pdb() { python -m pdb "$@" }
mkcd() { mkdir "$@" && cd "${@[-1]}" }

open() {
  for arg in "$@"; do
    xdg-open "$arg"
  done
}

# tmux

findxdgconfig() {
  if [[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/$1" ]]; then
    echo "${XDG_CONFIG_HOME:-$HOME/.config}/$1"
    return 0
  fi
  for p in ${(s.:.)${XDG_CONFIG_DIRS}}; do
    if [[ -e "${p}/$1" ]]; then
      echo "${p}/$1"
      return 0
    fi
  done
  return 1
}

tmux() {
  local tmuxconf="$(findxdgconfig tmux.conf || echo 'XXX')"
  if [[ "$tmuxconf" = 'XXX' ]]; then
    /usr/bin/tmux "$@"
    return $?
  fi
  /usr/bin/tmux -f "$tmuxconf" "$@"
}

__tmux_split_complete() {
  _arguments '*::arguments:_normal'
}

VS() { tmux split-window -h "$*" }
SP() { tmux split-window -v "$*" }
NEWT() { tmux new-window "$*" }

CLR() { clear && tmux clear-history }

GOWEB() {
  GOMAXPROCS=8 nice godoc -http=localhost:6060 "$@"
}

## EXTENSIONS ##

# Load zmv: The multi-file move
autoload -U zmv

# Load completion
autoload -U compinit
compinit

compdef __tmux_split_complete VS SP NEWT

# The next line enables zsh completion for gcloud.
if [[ -e "$HOME/google-cloud-sdk/completion.zsh.inc" ]]; then
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# Daisy-chain to local env
if [[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshrc" ]]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshrc"
fi
