let
  nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/a0b7e70db7a55088d3de0cc370a59f9fbcc906c3.tar.gz") {
    overlays = [
      (self: super: {
        gohack = super.callPackage ./gohack.nix {};
        redo-zombiezen = super.callPackage ./redo-zombiezen.nix {};
        gopls = super.gopls.override {
          buildGoModule = self.buildGo119Module;
        };
      })
    ];
  };

  inherit (nixpkgs) lib glibcLocales;
in
{ discord ? false, gui ? false }:
{
  inherit nixpkgs;

  mypkgs = {
    inherit (nixpkgs)
      _1password
      age
      bloaty
      chezmoi
      colordiff
      crane
      delve
      dig
      file
      gcrane
      gg-scm
      ghz
      git
      git-lfs
      gnupg
      go-font
      go-outline
      go_1_19
      gohack
      gopls
      graphviz-nox
      grpcurl
      htop
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
      unzip
      vim_configurable
      zip
    ;
    inherit (nixpkgs.nodePackages) node2nix;
  } // lib.optionalAttrs nixpkgs.targetPlatform.isLinux {
    inherit (nixpkgs)
      psmisc;
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
      direnv
      heroku
      hugo
      ledger
      lorri
    ;
  } // lib.optionalAttrs (gui && !discord) {
    inherit (nixpkgs)
      postman
      zotero
    ;
  } // lib.optionalAttrs (!builtins.isNull glibcLocales) {
    glibcLocales = glibcLocales.override {
      allLocales = false;
      locales = [ "C.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
    };
  };

  # Environment for ~/.local/bin/nixos-vscode.sh
  nixos-vscode-shell = nixpkgs.mkShell {
    packages = [
      nixpkgs.bash
      nixpkgs.coreutils
      nixpkgs.findutils
    ];
  };
  nixos-vscode-deps = nixpkgs.symlinkJoin {
    name = "nixos-vscode";
    paths = [
      nixpkgs.nodejs-16_x
      nixpkgs.ripgrep
    ];
  };
}
