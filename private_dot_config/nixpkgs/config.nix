{ pkgs }: {
  allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "1password"
  ];
}