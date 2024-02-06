{
  lib,
  config,
  pkgs,
  ...
}: {
  # Install homebrew if it is enabled in nix-darwin
  nix-homebrew = {
    enable = lib.mkDefault config.homebrew.enable;
    enableRosetta = lib.mkDefault (pkgs.system == "aarch64-darwin");
    user = lib.mkDefault config.nix-machine.username;
  };
}
