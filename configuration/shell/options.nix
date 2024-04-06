{lib, ...}: {
  options.squirmy.shell.enable = lib.options.mkEnableOption "shell";
}
