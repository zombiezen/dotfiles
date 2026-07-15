#shellcheck shell=bash
# Script to attempt to restore a corrupted zsh history file.
# Based on https://shapeshed.com/zsh-corrupt-history-file/

set -euo pipefail

file="${1:-${XDG_STATE_HOME:-$HOME/.local/state}/.zsh_history}"
strings "$file" | sponge "$file"
zsh -c "fc -R '$file'"
