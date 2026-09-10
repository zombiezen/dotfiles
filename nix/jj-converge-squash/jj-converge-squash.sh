#!/usr/bin/env bash
# Move descendants of a revision onto trunk().
set -euo pipefail

if [[ $# -eq 0 ]]; then
  echo 'usage: jj-converge-squash REVSET [...]' >&2
  exit 64
elif [[ $# -eq 1 && "$1" = --help ]]; then
  echo 'usage: jj-converge-squash REVSET [...]' >&2
  exit
fi

expand_revset() {
  local idfunc="$1"
  shift
  echo -n '('
  jj show --no-patch --template="'${idfunc}('++${idfunc}++')|'" -- "$@"
  echo -n 'none())'
}

curr_op="$(jj operation show --no-graph --no-op-diff --template 'id.short()' @)"
{ echo "To undo: jj operation restore $curr_op"; echo; } >&2

union_args="($(printf '(%s)|' "$@")none())"
old_commits="$(expand_revset commit_id "heads($union_args)")"
jj new --quiet --no-edit --insert-after="$old_commits"
temp_change="$(expand_revset change_id "${old_commits}+")"
jj rebase --source="$temp_change" --onto='trunk()'
jj abandon --quiet "$temp_change" "trunk()..$old_commits"
