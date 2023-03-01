{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "govulncheck";
  version = "unstable-2023-03-01";

  src = fetchFromGitHub {
    owner = "golang";
    repo = "vuln";
    rev = "edec1fb0a9c7d7874fcada1a66890a82198da3e0";
    hash = "sha256-XqugFMpLt8kpVCJjabsZ2U8NwQUjCIRe3yBEFLt/Ljk=";
  };

  vendorHash = "sha256-+luU71QHNs7xxXQOLtd+Ka8+ETv5sA+gv+4g7Ogm5TI=";

  subPackages = [ "cmd/govulncheck" ];

  doCheck = false;

  ldflags = [ "-s" "-w" ];

  meta = with lib; {
    homepage = "https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck";
    description = "The database client and tools for the Go vulnerability database, also known as vuln";
    longDescription = ''
      Govulncheck reports known vulnerabilities that affect Go code. It uses
      static analysis of source code or a binary's symbol table to narrow down
      reports to only those that could affect the application.

      By default, govulncheck makes requests to the Go vulnerability database at
      https://vuln.go.dev. Requests to the vulnerability database contain only
      module paths, not code or other properties of your program. See
      https://vuln.go.dev/privacy.html for more. Set the GOVULNDB environment
      variable to specify a different database, which must implement the
      specification at https://go.dev/security/vuln/database.

      Govulncheck looks for vulnerabilities in Go programs using a specific
      build configuration. For analyzing source code, that configuration is the
      operating system, architecture, and Go version specified by GOOS, GOARCH,
      and the “go” command found on the PATH. For binaries, the build
      configuration is the one used to build the binary. Note that different
      build configurations may have different known vulnerabilities. For
      example, a dependency with a Windows-specific vulnerability will not be
      reported for a Linux build.
    '';
    license = with licenses; [ bsd3 ];
    maintainers = with maintainers; [ jk ];
  };
}
