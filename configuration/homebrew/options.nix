{lib, ...}: {
  options.squirmy.homebrew.enable = lib.options.mkEnableOption "homebrew";
}
