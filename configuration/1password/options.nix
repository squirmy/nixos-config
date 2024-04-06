{lib, ...}: {
  options.squirmy._1password.enable = lib.options.mkEnableOption "1password";
}
