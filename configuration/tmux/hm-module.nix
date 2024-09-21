{
  lib,
  config,
  pkgs,
  ...
}: lib.mkIf config.squirmy.tmux.enable {
    home.packages = [
      pkgs.tmux
    ];

    home.file.".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "/users/${config.nix-machine.username}/.config/nixos-config/configuration/tmux/config";
  }
