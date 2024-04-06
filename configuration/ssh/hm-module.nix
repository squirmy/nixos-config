{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.ssh.enable {
  # Enable ssh. Not sure how much to setup with this just yet.
  programs.ssh.enable = true;

  home.packages = [
    pkgs.openssh
  ];
}
