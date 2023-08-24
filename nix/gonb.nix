{ lib
, buildGoModule
, fetchFromGitHub
, gopls
, gotools # goimports
, makeBinaryWrapper
}:

let
  version = "0.8.0";
  sourceHash = "sha256-Ie7Tzbzu+wOjz3OnELFEM2cV7R7n/r7mIR2XekmHgwU=";
  vendorHash = "sha256-Ug3X8kv67Op4Fr0J8fi25w8sbxfNLsSBra4zcTdW/Pg=";
in

buildGoModule {
  pname = "gonb";
  inherit version;

  src = fetchFromGitHub {
    owner = "janpfeifer";
    repo = "gonb";
    rev = "v${version}";
    hash = sourceHash;
  };

  nativeBuildInputs = [
    makeBinaryWrapper
  ];

  inherit vendorHash;

  subPackages = [ "." ];
  ldflags = [ "-s" "-w" ];

  postInstall = ''
    wrapProgram $out/bin/gonb \
      --prefix PATH : ${gopls}/bin:${gotools}/bin

    mkdir -p $out/share/jupyter/kernels/gonb
    {
      echo '{'
      echo "  \"argv\": [\"$out/bin/gonb\", \"--kernel\", \"{connection_file}\"],"
      echo '  "display_name": "Go (gonb)",'
      echo '  "language": "go"'
      echo '}'
    } > "$out/share/jupyter/kernels/gonb/kernel.json"
  '';

  meta = {
    description = "A Go Notebook Kernel for Jupyter";
    homepage = "https://github.com/janpfeifer/gonb";
    license = lib.licenses.mit;
  };
}
