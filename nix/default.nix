{ system ? builtins.currentSystem
, gui ? false
, rev ? null
}:

let
  flake = if builtins.isNull rev
    then builtins.getFlake "path:${builtins.toString ./.}"
    else builtins.getFlake "git+file:${builtins.toString ./..}?dir=nix&rev=${rev}";
in {
  nixpkgs = flake.lib.nixpkgs system;

  mypkgs = flake.lib.mypkgs { inherit system gui; };
  mypkgsList = flake.lib.mypkgsList { inherit system gui; };
  profile = flake.lib.mkProfile { inherit system gui; };
}
