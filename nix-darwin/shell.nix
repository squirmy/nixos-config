{
  pkgs,
  config,
  ...
}: {
  environment.shells = with pkgs; [
    bashInteractive
    zsh
  ];

  # Manage .zshrc. Required for packages to be in the your path.
  programs.zsh.enable = true;

  # Required so that applications installed with homebrew are in your path.
  programs.zsh.shellInit = ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';
}
