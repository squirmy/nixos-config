{lib, ...}: {
  options.squirmy.network.enable = lib.options.mkEnableOption "network";
}
