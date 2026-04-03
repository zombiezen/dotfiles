# Move descendants of a revision onto trunk().

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 3.0

if ($args.Length -ne 1) {
  throw "usage: jj-converge REVSET"
} elseif ($args[0] -eq "--help") {
  Write-Error "usage: jj-converge REVSET"
  return
}

$old_commit = jj show --no-patch --template=commit_id "heads($($args[0]))"
jj new --quiet --no-edit --insert-after="commit_id($old_commit)"
$temp_change = jj show --no-patch --template=change_id "commit_id($old_commit)+"
jj rebase --source="change_id($temp_change)" --onto='trunk()'
jj abandon --quiet "change_id($temp_change)" "trunk()..commit_id($old_commit)"
