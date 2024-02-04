{
  config,
  pkgs,
  ...
}: {
  # Install homebrew if it is enabled in nix-darwin
  nix-homebrew = {
    enable = config.homebrew.enable;
    enableRosetta = pkgs.system == "aarch64-darwin";
    user = config.nix-machine.username;
  };
}
