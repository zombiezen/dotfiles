{ system ? builtins.currentSystem
, ngrok ? false
, gui ? false
, rev ? null
}:

let
  flake = if builtins.isNull rev
    then builtins.getFlake "path:${builtins.toString ./.}"
    else builtins.getFlake "git+file:${builtins.toString ./..}?dir=nix&rev=${rev}";
in {
  nixpkgs = flake.lib.nixpkgs system;

  mypkgs = flake.lib.mypkgs { inherit system ngrok gui; };
  mypkgsList = flake.lib.mypkgsList { inherit system ngrok gui; };
  profile = flake.lib.mkProfile { inherit system ngrok gui; };
}
