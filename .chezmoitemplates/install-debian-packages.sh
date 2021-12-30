# shellcheck shell=bash

echo "** Installing packages..." 1>&2
run_as_root apt-get update
run_as_root apt-get install -y --no-install-recommends \
  apt-transport-https \
  curl \
  psmisc \
  sshpass \
  zsh
