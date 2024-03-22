{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.experiments.enable {
  home.packages = with pkgs; [
    # playing with getting containers running
    podman
    lima
  ];
}
