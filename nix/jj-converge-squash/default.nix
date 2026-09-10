{ lib
, writeTextFile
, runtimeShell
, jujutsu
}:

writeTextFile {
  name = "jj-converge-squash";
  executable = true;
  destination = "/bin/jj-converge-squash";
  text = ''
    #!${runtimeShell}
    PATH="$PATH":${jujutsu}/bin
    ${builtins.readFile ./jj-converge-squash.sh}
  '';

  meta = {
    description = "Script to move descendants of a revision onto trunk()";
    license = lib.licenses.unlicense;
    maintainers = [ lib.maintainers.zombiezen ];
  };
}

