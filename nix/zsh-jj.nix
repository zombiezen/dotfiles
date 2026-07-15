{ fetchFromGitHub
, stdenvNoCC
, lib
}:

let
  rev = "7ff882a761688aad7bcb0c2d74b05eacd4f7b3e2";
  hash = "sha256-Qlsye7Q0p1MfpeSOECYJP0mJVtxlVP37J5pVh/uuJ8k=";
in
stdenvNoCC.mkDerivation {
  pname = "zsh-jj";
  version = builtins.substring 0 9 rev;
  src = fetchFromGitHub {
    owner = "rkh";
    repo = "zsh-jj";
    inherit rev hash;
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/share/zsh"
    cp --reflink=auto -a functions "$out/share/zsh/site-functions"
    runHook postInstall
  '';
}
