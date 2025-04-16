{ lib
, writeTextFile
, runtimeShell
, moreutils
, binutils
}:

let
  inherit (lib.strings) makeBinPath;
in

writeTextFile {
  name = "fix-zsh-history";
  executable = true;
  destination = "/bin/fix-zsh-history";
  text = ''
    #!${runtimeShell}
    PATH='${makeBinPath [moreutils binutils]}':"$PATH"
    ${builtins.readFile ./fix-zsh-history.sh}
  '';

  meta = {
    description = "Script to attempt to restore a corrupted .zsh_history file.";
    license = lib.licenses.unlicense;
  };
}

