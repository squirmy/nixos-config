{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.zsh.enable {
  # zsh
  # Why: It's the default on macOS, and I was previously
  # using oh-my-zsh.
  programs.zsh.enable = true;

  # Colorize ls on macos
  home.sessionVariables = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {CLICOLOR = "1";};
}
