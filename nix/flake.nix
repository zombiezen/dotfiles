{
  description = "zombiezen/dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
  let
    supportedSystems = [
      flake-utils.lib.system.x86_64-linux
      flake-utils.lib.system.aarch64-linux
      flake-utils.lib.system.x86_64-darwin
      flake-utils.lib.system.aarch64-darwin
    ];
  in
    {
      lib = {
        nixpkgs = system: import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };

        basePackages = system:
          let
            pkgs = self.lib.nixpkgs system;
            inherit (pkgs) lib;
          in
          {
            inherit (pkgs)
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
            inherit (pkgs.nodePackages) node2nix;
          } // lib.optionalAttrs pkgs.targetPlatform.isLinux {
            inherit (pkgs) psmisc;
          } // lib.optionalAttrs (!builtins.isNull pkgs.glibcLocales) {
            glibcLocales = pkgs.glibcLocales.override {
              allLocales = false;
              locales = [ "C.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
            };
          };

        baseGUIPackages = system:
          let
            pkgs = self.lib.nixpkgs system;
            inherit (pkgs) lib;
          in
          {
            inherit (pkgs) go-font;
          };

        personalPackages = system:
          let
            pkgs = self.lib.nixpkgs system;
            inherit (pkgs) lib;
          in
          {
            # Use managed versions at work.
            inherit (pkgs)
              binutils
              google-cloud-sdk
            ;

            # These packages are only useful outside of work.
            inherit (pkgs)
              direnv
              lorri
            ;
          };

        personalGUIPackages = system:
          let
            pkgs = self.lib.nixpkgs system;
            inherit (pkgs) lib;
          in
          {
            inherit (pkgs) wireshark;
          };

        mypkgs = { system, discord ? false, gui ? false }:
          self.lib.basePackages system //
          nixpkgs.lib.optionalAttrs gui (self.lib.baseGUIPackages system) //
          nixpkgs.lib.optionalAttrs (!discord) (self.lib.personalPackages system) //
          nixpkgs.lib.optionalAttrs (gui && !discord) (self.lib.personalGUIPackages system);

        mypkgsList = args: builtins.attrValues (self.lib.mypkgs args);
      };

      overlays.default = self: super: {
        gohack = super.callPackage ./gohack.nix {};
        redo-zombiezen = super.callPackage ./redo-zombiezen.nix {};
        gopls = super.gopls.override {
          buildGoModule = self.buildGo120Module;
        };
      };
    } // flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };

      in
      {
        packages =
          self.lib.basePackages system //
          self.lib.baseGUIPackages system //
          self.lib.personalPackages system //
          self.lib.personalGUIPackages system //
          {
            nixos-vscode-deps = pkgs.symlinkJoin {
              name = "nixos-vscode";
              paths = [
                pkgs.nodejs-16_x
                pkgs.ripgrep
              ];
            };
          };

        # Environment for ~/.local/bin/nixos-vscode.sh
        devShells.nixos-vscode = pkgs.mkShell {
          packages = [
            pkgs.bash
            pkgs.coreutils
            pkgs.findutils
          ];
        };
      });
}
