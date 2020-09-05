#!/bin/zsh

typeset -T XDG_CONFIG_DIRS xdgconfigdirs

export EDITOR=vim
export VIMINIT=":source $HOME/dotfiles/vim/init.vim"

export PAGER=less
export LESS=R
export LESSHISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/lesshst"

export GOPATH="$HOME"
export NPM_CONFIG_PREFIX="$HOME"

export LEDGER_PEDANTIC=1
export LEDGER_EXPLICIT=1
export LEDGER_DATE_FORMAT='%Y-%m-%d'

export DEBFULLNAME='Ross Light'
export DEBEMAIL='ross@zombiezen.com'

export GPG_TTY="$(tty)"

# HGRCPATH reads in files sequentially to build up map, so later entries
# override earlier ones.  This is the reverse order of common UNIX paths.
typeset -T HGRCPATH hgrcpath
hgrcpath=( /usr/etc/mercurial/hgrc /etc/mercurial/hgrc /etc/mercurial/hgrc.d )
for (( idx=${#xdgconfigdirs[@]}; idx > 0; idx-- )); do
  hgrcpath+=( "${xdgconfigdirs[idx]}/mercurial/hgrc" )
done
hgrcpath+=( "${XDG_CONFIG_HOME:-$HOME/.config}/mercurial/hgrc" "$HOME/.hgrc" )
export HGRCPATH


oldpath=( "${path[@]}" )
path=(
  "$HOME/bin" \
  "$HOME/go/bin" \
  "$HOME/.cargo/bin" \
  /usr/local/sbin \
  /usr/local/go/bin \
  /usr/local/bin \
  /usr/sbin \
  /usr/bin \
  /sbin \
  /bin \
  /usr/games \
  /usr/local/games \
)

# The next line updates PATH for the Google Cloud SDK.
if [[ -e "$HOME/google-cloud-sdk/path.zsh.inc" ]]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

# Load RVM if present.
if [[ -e "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
fi

# Add any elements that were present in the PATH before to the end of PATH.
for p1 in "${oldpath[@]}"; do
  for p2 in "${path[@]}"; do
    if [[ "$p1" = "$p2" ]]; then
      # Continue `p1 in oldpath`.
      continue 2
    fi
  done
  path+=( "$p1" )
done
unset p1 p2 oldpath

# Use VSCode as EDITOR if available.
if whence -p code 2>&1 > /dev/null; then
  EDITOR='code --wait'
fi

# Daisy-chain to local env
if [[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshenv" ]]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshenv"
fi
