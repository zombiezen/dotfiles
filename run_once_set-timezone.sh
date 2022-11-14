#!/usr/bin/env bash

set -euo pipefail

if ! command -v dpkg-reconfigure >& /dev/null; then
  exit 1
fi

sudo --non-interactive sh -c 'ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata'
