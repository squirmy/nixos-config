{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.zsh.enable {
  environment.shells = with pkgs; [
    bashInteractive
    zsh
  ];

  # Manage .zshrc. Required for packages to be in your path.
  programs.zsh.enable = true;
}
