#!/bin/zsh

if [[ -x /opt/neovim/bin/nvim ]]; then
  export EDITOR=/opt/neovim/bin/nvim
else
  export EDITOR=vim
fi

export PAGER=less
export LESS=R
export LESSHISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/lesshst"
export GOPATH="$HOME"

export HGRCPATH="$HOME/.hgrc:${XDG_CONFIG_HOME:-$HOME/.config}/mercurial/hgrc"
for p in ${(s.:.)${XDG_CONFIG_DIRS}}; do
  HGRCPATH="${HGRCPATH}:$p/mercurial/hgrc"
done
HGRCPATH="${HGRCPATH}:/etc/mercurial/hgrc:/etc/mercurial/hgrc.d:/usr/etc/mercurial/hgrc"


path=(
  "$HOME/bin" \
  "$HOME/go/bin" \
  /opt/neovim/bin \
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
