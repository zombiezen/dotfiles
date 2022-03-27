let
  nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/e9545762b032559c27d8ec9141ed63ceca1aa1ac.tar.gz") {
    overlays = [
      (self: super: {
        gohack = super.callPackage ./gohack.nix {};
        redo-zombiezen = super.callPackage ./redo-zombiezen.nix {};
      })
    ];
  };

  inherit (nixpkgs) lib glibcLocales;
in
{
  inherit nixpkgs;

  mypkgs = {
    inherit (nixpkgs)
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

    gopls = nixpkgs.gopls.override {
      buildGoModule = nixpkgs.buildGo118Module;
    };
  } // lib.optionalAttrs (!builtins.isNull glibcLocales) {
    glibcLocales = glibcLocales.override {
      allLocales = false;
      locales = [ "C.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
    };
  };
}
