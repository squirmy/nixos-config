{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.zsh.enable {
  programs.zsh.enable = true;
}
