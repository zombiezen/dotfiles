#!/usr/bin/env bash

# This is based on the steps that the Nix interpreter takes to establish a build environment.

set -euo pipefail

usage='usage: chroot-init [--uid UID] [--user NAME] [--gid GID] [--group NAME] [--home PATH] [--remove] DIR'
uid="$(id -u)"
username="$(id -un)"
gid="$(id -g)"
groupname="$(id -gn)"
home="/"
remove=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --uid)
      uid="$2"
      shift 2
      ;;
    --user)
      username="$2"
      shift 2
      ;;
    --gid)
      gid="$2"
      shift 2
      ;;
    --group)
      groupname="$2"
      shift 2
      ;;
    --home)
      home="$2"
      shift 2
      ;;
    --remove)
      remove=1
      shift
      ;;
    --)
      shift
      break
      ;;
    --*)
      # Unrecognized option
      echo "$usage" 1>&2
      if [[ "$1" = '--help' ]]; then
        exit 0
      else
        exit 64
      fi
      ;;
    *)
      # Positional arguments
      break
      ;;
  esac
done

if [[ $# -ne 1 ]]; then
  echo "$usage" 1>&2
  exit 64
fi

rootdir="$1"
devices=( full null random tty urandom zero )

if [[ $remove -eq 1 ]]; then
  mountpoints=( dev/shm dev/pts proc )
  for i in "${devices[@]}"; do
    mountpoints+=( "dev/$i" )
  done
  for i in "${mountpoints[@]}"; do
    if mountpoint --quiet "$rootdir/$i"; then
      umount "$rootdir/$i"
    fi
  done
  rm -rf "$rootdir"
  exit 0
fi

mkdir -p "$rootdir/tmp"
chmod 1777 "$rootdir/tmp"

mkdir -p "$rootdir/etc"

cat > "$rootdir/etc/passwd" <<EOF
root:x:0:0:Build user:${home}:/noshell
${username}:x:${uid}:${gid}:Build user:${home}:/noshell
nobody:x:65534:65534:Nobody:/:/noshell
EOF

cat > "$rootdir/etc/group" <<EOF
root:x:0:
${groupname}:!:${gid}:
nogroup:x:65534:
EOF

cat > "$rootdir/etc/hosts" <<EOF
127.0.0.1 localhost
::1 localhost
EOF

chmod 555 "$rootdir/etc"

mkdir -p "$rootdir/dev/shm"
mount -t tmpfs -o size=50% none "$rootdir/dev/shm"

mkdir -p "$rootdir/dev/pts"
if [[ -e /dev/pts/ptmx ]]; then
  mount -t devpts -o newinstance,mode=0620 none "$rootdir/dev/pts"
  ln -s /dev/pts/ptmx "$rootdir/dev/ptmx"
  chmod 666  "$rootdir/dev/pts/ptmx"
fi

for i in "${devices[@]}"; do
  touch "$rootdir/dev/$i"
  mount --rbind "/dev/$i" "$rootdir/dev/$i"
done
ln -s /proc/self/fd "$rootdir/dev/fd"
ln -s /proc/self/fd/0 "$rootdir/dev/stdin"
ln -s /proc/self/fd/1 "$rootdir/dev/stdout"
ln -s /proc/self/fd/2 "$rootdir/dev/stderr"

mkdir -p "$rootdir/proc"
mount -t proc none "$rootdir/proc"
