{ lib
, writeTextFile
, runtimeShell
, mktemp
}:

let
  inherit (lib.strings) makeBinPath;
in

writeTextFile {
  name = "mktempdir";
  executable = true;
  destination = "/bin/mktempdir";
  text = ''
    #!${runtimeShell}
    PATH='${makeBinPath [mktemp]}':"$PATH"
    ${builtins.readFile ./mktempdir.sh}
  '';

  meta = {
    description = "Script to create a temporary directory.";
    license = lib.licenses.unlicense;
  };
}
