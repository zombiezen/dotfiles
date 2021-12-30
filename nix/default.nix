{
  nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/5c37ad87222cfc1ec36d6cd1364514a9efc2f7f2.tar.gz") {
    overlays = [
      (self: super: {
        gg-scm = super.callPackage ./gg {};
        redo-zombiezen = super.callPackage ./redo-zombiezen.nix {};

        lib = super.lib // {
          maintainers = {
            zombiezen = {
              name = "Ross Light";
              email = "ross@zombiezen.com";
              github = "zombiezen";
              githubId = 181535;
            };
          } // super.lib.maintainers;
        };
      })
    ];
  };
}
