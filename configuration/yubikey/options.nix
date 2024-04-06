{lib, ...}: {
  options.squirmy.yubikey.enable = lib.options.mkEnableOption "yubikey";
}
