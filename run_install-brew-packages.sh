#!/bin/bash
set -euo pipefail
if ! command -v brew > /dev/null; then
  echo "** warning: brew not installed" 1>&2
  exit 0
fi
packages=(\
  gg-scm/gg/gg \
  jq \
  tree \
  vim \
)
first=1
formulae_list="$(brew list -1 --formulae)"
for name in "${packages[@]}"; do
  if echo "$formulae_list" | grep -F "$( basename "$name" )" > /dev/null; then
    continue
  fi
  if [[ "$first" -eq 1 ]]; then
    echo "** Installing packages..." 1>&2
    first=0
  fi
  brew install "$name"
  formulae_list="$(brew list -1 --formulae)"
done
