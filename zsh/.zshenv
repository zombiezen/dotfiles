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

# HGRCPATH reads in files sequentially to build up map, so later entries
# override earlier ones.  This is the reverse order of common UNIX paths.
typeset -T HGRCPATH hgrcpath
hgrcpath=( /usr/etc/mercurial/hgrc /etc/mercurial/hgrc /etc/mercurial/hgrc.d )
for (( idx=${#xdgconfigdirs[@]}; idx > 0; idx-- )); do
  hgrcpath+=( "${xdgconfigdirs[idx]}/mercurial/hgrc" )
done
hgrcpath+=( "${XDG_CONFIG_HOME:-$HOME/.config}/mercurial/hgrc" "$HOME/.hgrc" )
export HGRCPATH


path=(
  "$HOME/bin" \
  "$HOME/go/bin" \
  "$HOME/.cargo/bin" \
  "$HOME/.rvm/bin" \
  /opt/rkt/latest \
  /usr/local/sbin \
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

# Daisy-chain to local env
if [[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshenv" ]]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshenv"
fi
