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
    pkgs.devenv
  ];

  programs.wezterm = {
    enable = true;
    enableZshIntegration = config.nix-machine.shells.zsh.enable;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main

      local config = {}

      config.colors = theme.colors()
      config.window_frame = theme.window_frame()

      config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Medium' })
      config.font_size = 13.0
      config.line_height = 1.1

      config.enable_tab_bar = false

      return config
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = config.nix-machine.shells.zsh.enable;
    options = ["--cmd" "cd"];
  };
}
