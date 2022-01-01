{
  nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/6f05cfdb1e78d36c0337516df674560e4b51c79b.tar.gz") {
    overlays = [
      (self: super: {
        redo-zombiezen = super.callPackage ./redo-zombiezen.nix {};
      })
    ];
  };
}
