{config, ...}: {
  # It is occasionally necessary for Home Manager to change configuration
  # defaults in a way that is incompatible with stateful data.
  # Update this when you want to consume newer defaults.
  home.stateVersion = "22.11";

  # Set the username & home directory. This should be
  # in sync with nix-darwin. (below)
  home.username = config.nix-machine.username;
  home.homeDirectory = config.nix-machine.homeDirectory;
}
