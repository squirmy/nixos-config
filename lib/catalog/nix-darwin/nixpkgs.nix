{config, ...}: {
  nixpkgs.hostPlatform = config.nix-machine.nixpkgs.hostPlatform;
  nixpkgs.config.allowUnfree = config.nix-machine.nixpkgs.allowUnfree;
}
