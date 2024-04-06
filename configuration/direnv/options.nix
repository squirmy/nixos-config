{lib, ...}: {
  options.squirmy.direnv.enable = lib.options.mkEnableOption "direnv";
}
