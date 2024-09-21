{lib, ...}: {
  options.squirmy.tmux.enable = lib.options.mkEnableOption "tmux";
}
