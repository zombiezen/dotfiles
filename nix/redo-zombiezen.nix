{ lib, fetchFromGitHub, nix-gitignore, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "redo-zombiezen";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "zombiezen";
    repo = "redo-rs";
    rev = "v${version}";
    sha256 = "ZN9TqIY0MOf0kNdjrUxnETc2p1KREHL1LIFN4CanIKU=";
  };
  cargoHash = "sha256-0i7c5/rlMiwy144G3JVlIeH8op8NJzvSmqLRwclS6rg=";
  cargoTestFlags = ["--lib" "--bins" "--examples"];

  meta = with lib; {
    description = "Port of apenwarr's redo to Rust";
    homepage = "https://github.com/zombiezen/redo-rs";
    license = licenses.asl20;
    mainProgram = "redo";
    platforms = platforms.linux ++ platforms.darwin;
  };
}