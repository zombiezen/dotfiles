{ lib, buildGoModule, fetchFromGitHub }:

let
  rev = "e022fc33592806f2cecb34f05ce2db977bc6e231";
  srcHash = "sha256-OpbRZBs/3+F0pulG06vqkGcMW5P7S4BGQWpdDheB6Lw=";
  vendorHash = "sha256-b1U3E673LzFam5Dk35VCB3uRnu/h2kquW/fsVKpyFxQ=";
in

buildGoModule {
  pname = "tclip";
  version = builtins.substring 0 9 rev;

  src = fetchFromGitHub {
    owner = "tailscale-dev";
    repo = "tclip";
    inherit rev;
    hash = srcHash;
  };
  inherit vendorHash;

  subPackages = [ "./cmd/tclip" ];

  doCheck = false;

  meta = {
    description = "Post to your Tailnet's tclip service";
    homepage = "https://github.com/tailscale-dev/tclip";
    license = lib.licenses.bsd3;
  };
}
