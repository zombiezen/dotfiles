let
  nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/85deee6d6c8127d360096a5caa0aeb876b976496.tar.gz") {
    overlays = [
      (self: super: {
        ghz = super.callPackage ./ghz.nix {};
        gohack = super.callPackage ./gohack.nix {};
        redo-zombiezen = super.callPackage ./redo-zombiezen.nix {};
      })
    ];
  };

  inherit (nixpkgs) lib glibcLocales;
in
{ discord ? false }:
{
  inherit nixpkgs;

  mypkgs = {
    inherit (nixpkgs)
      _1password
      age
      bloaty
      colordiff
      crane
      delve
      gcrane
      gg-scm
      ghz
      git
      git-lfs
      gnupg
      go-font
      go-outline
      go_1_18
      gohack
      gopls
      graphviz-nox
      grpcurl
      ivy
      jq
      mercurial
      netcat-gnu
      nix-prefetch-github
      shellcheck
      subversionClient
      sqlite-interactive
      terraform
      tree
      vim_configurable
    ;
    inherit (nixpkgs.nodePackages) node2nix;
  } // lib.optionalAttrs (!discord) {
    # Install these in non-work environments.
    # Use managed versions at work.
    inherit (nixpkgs)
      cargo
      google-cloud-sdk
      nodejs-16_x
      rust-analyzer
      rustc
      rustfmt
      yarn
    ;

    # These packages are only useful outside of work.
    inherit (nixpkgs)
      heroku
      hugo
      ledger
      postman
      redo-zombiezen
    ;
  } // lib.optionalAttrs (!builtins.isNull glibcLocales) {
    glibcLocales = glibcLocales.override {
      allLocales = false;
      locales = [ "C.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
    };
  };
}
