if (Get-Command jj 2>$null) {
  Invoke-Expression (& { (jj util completion power-shell | Out-String) })
}
