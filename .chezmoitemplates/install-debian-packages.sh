# shellcheck shell=bash
gg_source_list=/etc/apt/sources.list.d/gg.list
gg_keyring_dest=/usr/share/keyrings/gg.asc

echo "** Adding APT repositories..." 1>&2
if ! run_as_root test -e "$gg_keyring_dest"; then
  run_as_root curl -fsSLo "$gg_keyring_dest" https://gg-scm.io/apt-key.gpg
fi
if ! run_as_root test -e "$gg_source_list"; then
  echo "deb [signed-by=${gg_keyring_dest}] https://apt.gg-scm.io gg main" | \
    run_as_root tee "$gg_source_list" > /dev/null
  echo "deb-src [signed-by=${gg_keyring_dest}] https://apt.gg-scm.io gg main" | \
    run_as_root tee -a "$gg_source_list" > /dev/null
fi

echo "** Installing packages..." 1>&2
run_as_root apt-get update
run_as_root apt-get install -y --no-install-recommends \
  apt-transport-https \
  curl \
  gg \
  git-core \
  netcat \
  psmisc \
  sshpass \
  tree \
  vim-nox \
  zsh
