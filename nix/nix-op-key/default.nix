{ lib
, writeTextFile
, runtimeShell
, _1password
, coreutils
, jq
, nix
}:

writeTextFile {
  name = "nix-op-key";
  executable = true;
  destination = "/bin/nix-op-key";
  text = ''
    #!${runtimeShell}
    PATH=${coreutils}/bin:${jq}/bin:"$PATH":${nix}/bin:${_1password}/bin
    ${builtins.readFile ./nix-op-key.sh}
  '';

  meta = {
    description = "Script to generate a new Nix store key and save it to 1Password";
    license = lib.licenses.unlicense;
    maintainers = [ lib.maintainers.zombiezen ];
  };
}

