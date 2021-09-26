#!/bin/bash
set -euo pipefail
dst=vim-addon-manager
if [[ ! -d "$dst" ]]; then
  git clone https://github.com/MarcWeber/vim-addon-manager.git "$dst"
fi
