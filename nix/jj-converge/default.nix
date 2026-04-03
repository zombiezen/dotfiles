{ lib
, writeTextFile
, runtimeShell
, jujutsu
}:

writeTextFile {
  name = "jj-converge";
  executable = true;
  destination = "/bin/jj-converge";
  text = ''
    #!${runtimeShell}
    PATH="$PATH":${jujutsu}/bin
    ${builtins.readFile ./jj-converge.sh}
  '';

  meta = {
    description = "Script to move descendants of a revision onto trunk()";
    license = lib.licenses.unlicense;
    maintainers = [ lib.maintainers.zombiezen ];
  };
}

