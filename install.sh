#!/bin/bash
set -e

appendcfg() {
  local myfile="$1"
  local pat="$2"
  if /bin/grep -F "$pat" "$myfile" >& /dev/null; then
    return 0
  fi
  cat >> "$myfile"
}

# Set XDG_CONFIG_DIRS environment variable in desktop environment.
# Stupidly, it seems that some part of XFCE auto-appends /etc/xdg, even
# though we add it.
cat > ~/.xsessionrc <<'EOF'
#!/bin/bash
# Used to populate environment variables for X session
export XDG_CONFIG_DIRS="$HOME/dotfiles:${XDG_CONFIG_DIRS:-/etc/xdg}"
EOF

# Forward zsh over to dotfiles/zsh
cat > ~/.zshenv <<'EOF'
function addDotfiles() {
  for p in ${(s.:.)${XDG_CONFIG_DIRS}}; do
    if [[ "$p" == "$HOME/dotfiles" ]]; then
      return 0
    fi
  done
  export XDG_CONFIG_DIRS="$HOME/dotfiles:${XDG_CONFIG_DIRS:-/etc/xdg}"
}
addDotfiles
unset -f addDotfiles

ZDOTDIR="$HOME/dotfiles/zsh"
. "$ZDOTDIR/.zshenv"
EOF

appendcfg "$HOME/.bazelrc" "$HOME/dotfiles/bazelrc" <<EOF
# Import configuration from dotfiles
import $HOME/dotfiles/bazelrc
EOF

mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/vim/{undo,swap,backup}"

# TODO(light): ln -f -s "$HOME/dotfiles/git" "${XDG_CONFIG_HOME:-$HOME/.config}/git"
