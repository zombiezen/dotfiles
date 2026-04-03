#!/usr/bin/env bash
# Move descendants of a revision onto trunk().
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo 'usage: jj-converge REVSET' >&2
  exit 64
elif [[ "$1" = --help ]]; then
  echo 'usage: jj-converge REVSET' >&2
  exit
fi

old_commit="$(jj show --no-patch --template=commit_id "heads($1)")"
jj new --quiet --no-edit --insert-after="commit_id($old_commit)"
temp_change="$(jj show --no-patch --template=change_id "commit_id($old_commit)+")"
jj rebase --source="change_id($temp_change)" --onto='trunk()'
jj abandon --quiet "change_id($temp_change)" "trunk()..commit_id($old_commit)"
