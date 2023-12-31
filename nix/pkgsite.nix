{ lib, buildGoModule, fetchgit }:

let
  rev = "475d4c57676e9e93276be3b802aaa7e758610ead";
  srcHash = "sha256-kKwqNNrshqIu+ZUEU0bTKYZzb4t6FOcRsIhUeq9Lpdc=";
  vendorHash = "sha256-i4AQJ6J0qfhmpteJ52vHyUp/jpO+IbNiPoyROkaXpLM=";
in

buildGoModule {
  pname = "pkgsite";
  version = builtins.substring 0 9 rev;

  src = fetchgit {
    url = "https://go.googlesource.com/pkgsite";
    inherit rev;
    hash = srcHash;
  };
  inherit vendorHash;

  subpackages = [ "./cmd/pkgsite" ];

  doCheck = false;

  meta = {
    description = "Extract and generate documentation for Go programs";
    homepage = "https://pkg.go.dev/golang.org/x/pkgsite/cmd/pkgsite";
    license = lib.licenses.bsd3;
    maintainers = [ lib.maintainers.zombiezen ];
  };
}
