{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.terminal.enable {
  homebrew.casks = [
    "hammerspoon"
    "raycast"
  ];

  system.defaults.CustomUserPreferences = {
    "org.hammerspoon.Hammerspoon" = {
      MJConfigFile = "~/.config/hammerspoon/init.lua";
    };
  };
}
