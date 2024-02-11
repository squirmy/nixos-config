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

  # Required so that applications installed with homebrew are in your path.
  programs.zsh.shellInit = lib.mkIf config.squirmy.homebrew.enable ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';
}
