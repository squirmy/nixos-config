{
  lib,
  config,
  pkgs,
  ...
}: let
  wezterm = pkgs.wezterm;
in
  lib.mkIf config.squirmy.wezterm.enable {
    programs.zsh.initExtra = lib.mkIf config.nix-machine.shells.zsh.enable ''
      source "${wezterm}/etc/profile.d/wezterm.sh"
    '';

    home.packages = [
      wezterm
    ];

    home.file.".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "/users/${config.nix-machine.username}/.config/nixos-config/configuration/wezterm/config";
  }
