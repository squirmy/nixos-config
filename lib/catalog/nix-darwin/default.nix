{config, ...}: {
  imports = [./nix.nix];

  nixpkgs.hostPlatform = config.nix-machine.system;

  # TODO: configure this optionally
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Set the user's name & home directory. This should be
  # in sync with home manager. (above)
  users.users.${config.nix-machine.username} = {
    name = config.nix-machine.username;
    home = config.nix-machine.homeDirectory;
  };
}
