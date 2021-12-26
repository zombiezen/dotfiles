#!/bin/bash
set -euo pipefail
if [[ -f credentials && "$(stat -c %a credentials)" != "600" ]]; then
  chmod 600 credentials
fi
