{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.experiments.enable {
  homebrew.casks = [
    "firefox"
  ];

  # These are configured when installing lix and land in nix/nix.custom.conf
  nix.settings.trusted-substituters = [
    "https://nix-community.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  # Allow nix-darwin to overwrite the nix.custom.conf created by the Lix installer
  environment.etc."nix/nix.custom.conf".knownSha256Hashes = [
    "b312344e53125fa33b510a7ebe765be7a8981f3aead73f3f168f2899c62a72f4"
  ];

  # For now, until I sort out the nix build group
  ids.gids.nixbld = 350;

  # whilst nix-darwin does there thing
  system.primaryUser = config.nix-machine.username;
}
