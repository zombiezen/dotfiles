#!/usr/bin/env bash
# Move ~/.zsh_history to $XDG_STATE_HOME/zsh_history.
# This is to migrate existing machines to my new preferred location.
set -euo pipefail
if [[ -f .zsh_history ]]; then
  cat .zsh_history >> .local/state/zsh_history
  rm .zsh_history
fi
