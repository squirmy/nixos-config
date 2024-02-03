{config, ...}: {
  nixpkgs.hostPlatform = config.nix-machine.system;
  # TODO: configure this optionally
  nixpkgs.config.allowUnfree = true;
}
