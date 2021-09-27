#!/bin/bash
set -euo pipefail
echo "** Installing packages..." 1>&2
sudo apt-get update
sudo apt-get install \
  apt-transport-https \
  curl \
  netcat \
  psmisc \
  sshpass \
  tree \
  vim-nox \
  zsh
