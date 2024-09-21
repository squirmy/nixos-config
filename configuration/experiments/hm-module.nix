{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.experiments.enable {
  home.packages = [
    pkgs.discord
    pkgs.devenv
    pkgs.alt-tab-macos
    # todo; switch when this becomes available (https://github.com/NixOS/nixpkgs/pull/313973)
    # pkgs.teams-for-linux
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = config.nix-machine.shells.zsh.enable;
    options = ["--cmd" "cd"];
  };

  programs.tmux = {
    enable = true;
  };
}
