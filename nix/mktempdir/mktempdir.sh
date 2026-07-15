#!/bin/sh
if [ $# -ne 0 ]; then
  echo "usage: $(basename "$0")" >&2
  exit 64
fi
# This relies on a GNU Coreutils-compatible package.
# The Nix derivation ensures we have one.
mktemp -d
