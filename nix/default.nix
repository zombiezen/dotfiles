rec {
  nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/cc68710784ffe0ee035ee7b726656c44566cac94.tar.gz") {
    overlays = [
      (self: super: {
        gohack = super.callPackage ./gohack.nix {};
        redo-zombiezen = super.callPackage ./redo-zombiezen.nix {};
      })
    ];
  };

  mypkgs = with nixpkgs; {
    inherit
      _1password
      age
      cargo
      colordiff
      crane
      delve
      gcrane
      gg-scm
      git
      gnupg
      go-font
      go_1_17
      gohack
      google-cloud-sdk
      gopls
      graphviz-nox
      heroku
      hugo
      ivy
      jq
      ledger
      mercurial
      netcat-gnu
      nix-prefetch-github
      nodejs-16_x
      redo-zombiezen
      rust-analyzer
      rustc
      rustfmt
      shellcheck
      subversionClient
      sqlite-interactive
      terraform
      tree
      vim_configurable
    ;
    inherit (nixpkgs.nodePackages) node2nix;
  } // lib.optionalAttrs (!builtins.isNull glibcLocales) {
    glibcLocales = glibcLocales.override {
      allLocales = false;
      locales = [ "C.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
    };
  };
}
