{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.homebrew.enable {
  homebrew.enable = true;
  homebrew.taps = ["nrlquaker/createzap"];

  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";

  # Upgrade outdated mac app store apps
  homebrew.onActivation.upgrade = true;

  # Required so that applications installed with homebrew are in your path.
  programs.zsh.shellInit = lib.mkIf config.squirmy.zsh.enable ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';
}
