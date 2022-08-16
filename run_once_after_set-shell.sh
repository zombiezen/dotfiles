#!/usr/bin/env bash
set -euo pipefail
want=/bin/zsh
if [[ -x "$want" && "$( basename "$SHELL" )" != "$( basename "$want" )" ]]; then
  echo "** Setting shell..." 1>&2
  chsh -s "$want"
fi
