{ lib
, writeTextFile
, runtimeShell
, coreutils
, util-linux
}:

let
  path = lib.strings.makeBinPath [
    coreutils
    util-linux
  ];
in

writeTextFile {
  name = "chroot-init";
  executable = true;
  destination = "/bin/chroot-init";
  text = ''
    #!${runtimeShell}
    PATH=${path}
    ${builtins.readFile ./chroot-init.sh}
  '';

  meta = {
    description = "Script to place basic files in a chroot directory";
    license = lib.licenses.unlicense;
    platforms = lib.platforms.linux;
  };
}

