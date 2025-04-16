#shellcheck shell=bash
# Script to attempt to restore a corrupted .zsh_history file.
# Based on https://shapeshed.com/zsh-corrupt-history-file/

set -euo pipefail

file="${1:-$HOME/.zsh_history}"
strings "$file" | sponge "$file"
zsh -c "fc -R '$file'"
