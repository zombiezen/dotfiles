let
  flake = builtins.getFlake "path:${builtins.toString ./.}";
in
{ system ? builtins.currentSystem, discord ? false, gui ? false }: {
  nixpkgs = flake.lib.nixpkgs system;

  mypkgs = flake.lib.mypkgs { inherit system discord gui; };
  mypkgsList = flake.lib.mypkgsList { inherit system discord gui; };

  nixos-vscode-shell = flake.devShells.${system}.nixos-vscode;

  inherit (flake.packages.${system}) nixos-vscode-deps;
}
