{lib, ...}: {
  options.squirmy.pure.enable = lib.options.mkEnableOption "pure";
}
