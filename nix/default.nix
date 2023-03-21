{ system ? builtins.currentSystem
, discord ? false
, gui ? false
, rev ? null
}:

let
  flake = if builtins.isNull rev
    then builtins.getFlake "path:${builtins.toString ./.}"
    else builtins.getFlake "git+file:${builtins.toString ./..}?dir=nix&rev=${rev}";
in {
  nixpkgs = flake.lib.nixpkgs system;

  mypkgs = flake.lib.mypkgs { inherit system discord gui; };
  mypkgsList = flake.lib.mypkgsList { inherit system discord gui; };
  profile = flake.lib.mkProfile { inherit system discord gui; };
}
