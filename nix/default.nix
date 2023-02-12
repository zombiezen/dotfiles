let
  nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/6ccc4a59c3f1b56d039d93da52696633e641bc71.tar.gz") {
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

{ discord ? false, gui ? false }: let
  mypkgs = {
    inherit (nixpkgs)
      _1password
      age
      bloaty
      chezmoi
      colordiff
      crane
      curl
      delve
      dig
      file
      gcrane
      gg-scm
      ghz
      git
      git-lfs
      gnupg
      go-outline
      go_1_20
      gohack
      gopls
      graphviz-nox
      grpcurl
      htop
      ivy
      jq
      mercurial
      moreutils  # sponge
      netcat-openbsd
      nix-prefetch-github
      shellcheck
      strace
      subversionClient
      sqlite-interactive
      tree
      unzip
      vim_configurable
      zip
    ;
    inherit (nixpkgs.nodePackages) node2nix;
  } // lib.optionalAttrs nixpkgs.targetPlatform.isLinux {
    inherit (nixpkgs) psmisc;
  } // lib.optionalAttrs gui {
    inherit (nixpkgs) go-font;
  } // lib.optionalAttrs (gui && !discord) {
    inherit (nixpkgs) wireshark;
  } // lib.optionalAttrs (!discord) {
    # Use managed versions at work.
    inherit (nixpkgs)
      binutils
      google-cloud-sdk
    ;

    # These packages are only useful outside of work.
    inherit (nixpkgs)
      direnv
      lorri
    ;
  } // lib.optionalAttrs (!builtins.isNull glibcLocales) {
    glibcLocales = glibcLocales.override {
      allLocales = false;
      locales = [ "C.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
    };
  };
in
{
  inherit nixpkgs mypkgs;

  mypkgsList = builtins.attrValues mypkgs;

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
