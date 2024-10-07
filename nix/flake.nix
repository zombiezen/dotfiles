{
  description = "zombiezen/dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs";
    gg.url = "github:gg-scm/gg/87491309f384566c7587fa9ed0b55fbd51a312e4";
    jupyter-ivy.url = "github:zombiezen/jupyter-ivy";
    sqlite-notebook.url = "github:zombiezen/sqlite-notebook";
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

            permittedInsecurePackages = [
              "nodejs-16.20.2"
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
              delta
              delve
              dig
              direnv
              file
              gcrane
              ghz
              git
              git-lfs
              gnupatch
              gnupg
              go-outline
              go_1_23
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
              otel-desktop-viewer
              patchutils
              rsync
              shellcheck
              subversionClient
              sqlite-interactive
              tree
              unzip
              vim_configurable
              zip
            ;
            inherit (pkgs.nodePackages) node2nix;
            inherit (pkgs.unixtools) watch;

            gg-scm = inputs.gg.packages.${system}.default;
            jupyter-ivy = inputs.jupyter-ivy.packages.${system}.default;
            sqlite-notebook = inputs.sqlite-notebook.packages.${system}.default;

            gonb = pkgs.callPackage ./gonb.nix {
              buildGoModule = pkgs.buildGo122Module;
            };
            nix-op-key = pkgs.callPackage ./nix-op-key {};
            nix-rebuild-profile = pkgs.callPackage ./nix-rebuild-profile {};
            pkgsite = pkgs.callPackage ./pkgsite {
              buildGoModule = pkgs.buildGo122Module;
            };
          } // lib.optionalAttrs pkgs.targetPlatform.isLinux {
            inherit (pkgs) psmisc strace;
            chroot-init = pkgs.callPackage ./chroot-init {};
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

            google-cloud-sdk = let c = pkgs.google-cloud-sdk.components; in
              pkgs.google-cloud-sdk.withExtraComponents [
                c.beta
                c.config-connector
                c.pubsub-emulator
              ];
          in
          {
            # Use managed versions at work.
            inherit (pkgs)
              binutils
            ;

            inherit google-cloud-sdk;
          };

        personalGUIPackages = system:
          let
            pkgs = self.lib.nixpkgs system;
          in
          {
            inherit (pkgs) wireshark;
          };

        mypkgs = { system, gui ? false }:
          self.lib.basePackages system //
          nixpkgs.lib.optionalAttrs gui (self.lib.baseGUIPackages system) //
          self.lib.personalPackages system //
          nixpkgs.lib.optionalAttrs gui (self.lib.personalGUIPackages system);

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
          buildGoModule = final.buildGo123Module;
        };

        go_1_23 = prev.go_1_23.overrideAttrs {
          version = "1.23.2";
          src = prev.fetchurl {
            url = "https://go.dev/dl/go1.23.2.src.tar.gz";
            hash = "sha256-NpMBYqk99BfZC9IsbhTa/0cFuqwrAkGO3aZxzfqc0H8=";
          };
        };
      };
    } // flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = self.lib.nixpkgs system;
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
