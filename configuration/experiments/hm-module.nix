{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.experiments.enable {
  home.packages = [
    pkgs.discord
    # pkgs.alt-tab-macos
    # todo; switch when this becomes available (https://github.com/NixOS/nixpkgs/pull/313973)
    # pkgs.teams-for-linux
  ];
}
