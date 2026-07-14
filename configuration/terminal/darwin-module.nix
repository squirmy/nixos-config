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

  # /etc/zshrc's default compinit call has no flags, so it prompts about
  # /nix/store being an "insecure" completion directory (a false positive
  # under Nix). Disable it here and let home-manager's zsh module run
  # compinit -u once instead, rather than running it twice per shell.
  programs.zsh.enableGlobalCompInit = lib.mkIf config.nix-machine.shells.zsh.enable false;

  system.defaults.CustomUserPreferences = {
    "org.hammerspoon.Hammerspoon" = {
      MJConfigFile = "~/.config/hammerspoon/init.lua";
    };
  };
}
