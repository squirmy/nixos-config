{lib, ...}: {
  options.squirmy.terminal.enable = lib.options.mkEnableOption "terminal configuration (wezterm, ghostty, tmux, nvim, etc.)";
}
