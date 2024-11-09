{ lib
, stdenv
, writeTextFile
, coreutils
, findutils
, symlinkJoin
, nodejs_20
, ripgrep
, runtimeShell
}:

let
  binPath = lib.strings.makeBinPath [
    coreutils
    findutils
  ];

  deps = symlinkJoin {
    name = "nixos-vscode-deps";
    paths = [
      nodejs_20
      ripgrep
    ];
  };
in

writeTextFile {
  name = "nixos-vscode";
  executable = true;
  destination = "/bin/nixos-vscode";

  text = ''
    #!${runtimeShell}
    set -euo pipefail
    export PATH=${binPath}

    serverbin="$HOME/.vscode-server/bin"
    wantbin=${deps}/bin
    find "$serverbin" -mindepth 2 -maxdepth 2 -name node -exec ln -sfT "$wantbin/node" {} \;
    find "$serverbin" -path '*/@vscode/ripgrep/bin/rg' -exec ln -sfT "$wantbin/rg" {} \;
  '';

  checkPhase = ''
    ${stdenv.shellDryRun} "$target"
  '';

  meta = {
    mainProgram = "nixos-vscode";
    passthru.deps = deps;
  };
}
