{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gohack";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "rogpeppe";
    repo = "gohack";
    rev = "v${version}";
    sha256 = "BNBIz7X1vaE9J0NdywO1WgZq+0uO7tlCtZBEkM900p0=";
  };
  vendorSha256 = "CO1zyEFbu/vGgYzZUtOAypkcQTwVoVqB0OFsx3vdyEA=";

  # TODO(soon): Various problems with testscript
  doCheck = false;

  meta = with lib; {
    description = "Make temporary edits to your Go module dependencies";
    homepage = "https://github.com/rogpeppe/gohack#readme";
    license = licenses.bsd3;
    maintainers = with maintainers; [ zombiezen ];
  };
}
