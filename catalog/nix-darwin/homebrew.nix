{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.homebrew.enable {
  homebrew.enable = true;
  homebrew.taps = [
    "nrlquaker/createzap"
  ];

  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";

  # Required so that applications installed with homebrew are in your path.
  programs.zsh.shellInit = ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  # Upgrade outdated mac app store apps
  homebrew.onActivation.upgrade = true;
}
