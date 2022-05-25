let
  nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/41cc1d5d9584103be4108c1815c350e07c807036.tar.gz") {
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
      git-lfs
      gnupg
      go-font
      go-outline
      go_1_18
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
