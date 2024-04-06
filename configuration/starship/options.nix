{lib, ...}: {
  options.squirmy.starship.enable = lib.options.mkEnableOption "starship";
}
