#!/bin/bash
set -euo pipefail
mkdir -p "$HOME/vim-addons"
if [[ ! -d "$HOME/vim-addons/vim-addon-manager" ]]; then
  git clone https://github.com/MarcWeber/vim-addon-manager.git "$HOME/vim-addons/vim-addon-manager"
fi
