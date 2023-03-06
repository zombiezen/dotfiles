{ lib
, writeTextFile
, runtimeShell
, gnused
, nix
}:

writeTextFile {
  name = "nix-rebuild-profile";
  executable = true;
  destination = "/bin/nix-rebuild-profile";
  text = ''
    #!${runtimeShell}
    PATH=${gnused}/bin:"$PATH":${nix}/bin
    ${builtins.readFile ./nix-rebuild-profile.sh}
  '';

  meta = {
    description = "Script to rebuild a profile";
    license = lib.licenses.unlicense;
    maintainers = [ lib.maintainers.zombiezen ];
  };
}
