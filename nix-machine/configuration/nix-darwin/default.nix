{config, ...}: {
  imports = [./nix.nix ./nixpkgs.nix ./home-manager.nix];

  # Set the user's name & home directory. This should be
  # in sync with home manager.
  users.users.${config.nix-machine.username} = {
    name = config.nix-machine.username;
    home = config.nix-machine.homeDirectory;
  };
}
