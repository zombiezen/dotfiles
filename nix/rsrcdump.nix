{ python310Packages
, fetchFromGitHub
}:

python310Packages.buildPythonApplication {
  pname = "rsrcdump";
  version = "20231230";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "jorio";
    repo = "rsrcdump";
    rev = "7426f3cb41e3cd237a01d6f2871f020bfbb6c9aa";
    hash = "sha256-O1BfVIWhZMqNmBAVSqWPXmQ5FZ9Xchki23JGCAADggc=";
  };

  build-system = [
    python310Packages.poetry-core
  ];

  meta = {
    homepage = "https://github.com/jorio/rsrcdump";
  };
}
