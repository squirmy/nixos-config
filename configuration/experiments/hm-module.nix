{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.experiments.enable {
  # home.packages = with pkgs; [
  #   # playing with getting containers running
  #   podman
  #   lima
  # ];

  home.packages = [
    pkgs.discord
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = config.nix-machine.shells.zsh.enable;
    options = ["--cmd" "cd"];
  };
}
