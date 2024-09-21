{lib, ...}: {
  options.squirmy.terminal.enable = lib.options.mkEnableOption "wezterm";
}
