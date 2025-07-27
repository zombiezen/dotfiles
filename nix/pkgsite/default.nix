{ lib, buildGoModule, fetchgit }:

let
  rev = "d4de6668b91034bd7c6315aff98f232c1339335f";
  srcHash = "sha256-H3yL82obJ/z8BDeyLdR1DVCxsPwrn0xxHLoMFHKhQn8=";
  vendorHash = "sha256-sHpWI3oUuazFlWJhHB5uZ89z1GPbPfLoFQL12Jk3NP0=";
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

  subPackages = [ "./cmd/pkgsite" ];

  doCheck = false;

  meta = {
    description = "Extract and generate documentation for Go programs";
    homepage = "https://pkg.go.dev/golang.org/x/pkgsite/cmd/pkgsite";
    license = lib.licenses.bsd3;
    maintainers = [ lib.maintainers.zombiezen ];
  };
}
