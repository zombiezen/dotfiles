{
  description = "zombiezen/dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs";
    gg.url = "github:gg-scm/gg/87491309f384566c7587fa9ed0b55fbd51a312e4";
    jupyter-ivy.url = "github:zombiezen/jupyter-ivy";
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
          config = {
            allowUnfreePredicate = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [
              "1password-cli"
            ];
          };
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
              ghz
              git
              git-lfs
              gnupatch
              gnupg
              go-outline
              go_1_20
              gohack
              gopls
              govulncheck
              graphviz-nox
              grpcurl
              htop
              ivy
              jq
              mercurial
              moreutils  # sponge
              nil
              nix-prefetch-github
              patchutils
              shellcheck
              subversionClient
              sqlite-interactive
              tree
              unzip
              vim_configurable
              zip
            ;
            inherit (pkgs.nodePackages) node2nix;

            gg-scm = inputs.gg.packages.${system}.default;
            jupyter-ivy = inputs.jupyter-ivy.packages.${system}.default;

            gonb = pkgs.callPackage ./gonb.nix {
              buildGoModule = pkgs.buildGo120Module;
            };
            nix-op-key = pkgs.callPackage ./nix-op-key {};
            nix-rebuild-profile = pkgs.callPackage ./nix-rebuild-profile {};
          } // lib.optionalAttrs pkgs.targetPlatform.isLinux {
            inherit (pkgs) psmisc strace;
          } // lib.optionalAttrs (!pkgs.targetPlatform.isDarwin) {
            # TODO(someday): netcat-openbsd has been marked as broken on Darwin.
            inherit (pkgs) netcat-openbsd;
          } // lib.optionalAttrs (!builtins.isNull pkgs.glibcLocales) {
            glibcLocales = pkgs.glibcLocales.override {
              allLocales = false;
              locales = [ "C.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
            };
          };

        baseGUIPackages = system:
          let
            pkgs = self.lib.nixpkgs system;
          in
          {
            inherit (pkgs) go-font;
          };

        personalPackages = system:
          let
            pkgs = self.lib.nixpkgs system;
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
          in
          {
            inherit (pkgs) wireshark;
          };

        workPackages = system:
          let
            pkgs = self.lib.nixpkgs system;
          in
          {
            inherit (pkgs) nix jsonnet-language-server;
          };

        mypkgs = { system, discord ? false, gui ? false }:
          self.lib.basePackages system //
          nixpkgs.lib.optionalAttrs gui (self.lib.baseGUIPackages system) //
          nixpkgs.lib.optionalAttrs discord (self.lib.workPackages system) //
          nixpkgs.lib.optionalAttrs (!discord) (self.lib.personalPackages system) //
          nixpkgs.lib.optionalAttrs (gui && !discord) (self.lib.personalGUIPackages system);

        mypkgsList = args: builtins.attrValues (self.lib.mypkgs args);

        mkProfile = args:
          let
            pkgs = self.lib.nixpkgs args.system;
            sourceInfo = pkgs.lib.lists.optional
              (!builtins.isNull self.sourceInfo.rev or null)
              (pkgs.writeTextDir "zombiezen-dotfiles-revision.txt" self.sourceInfo.rev);
          in pkgs.buildEnv {
            name = "zombiezen-dotfiles-profile";
            paths = self.lib.mypkgsList args ++ sourceInfo;
            extraOutputsToInstall = [ "man" ];
          };
      };

      overlays.default = final: prev: {
        gohack = prev.callPackage ./gohack.nix {};
        gopls = prev.gopls.override {
          buildGoModule = final.buildGo120Module;
        };
        govulncheck = prev.callPackage ./govulncheck.nix {
          buildGoModule = final.buildGo120Module;
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
            nixos-vscode = pkgs.callPackage ./nixos-vscode {};
          };
      });
}
