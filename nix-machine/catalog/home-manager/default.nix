{config, ...}: {
  imports = [./trampoline];

  # It is occasionally necessary for Home Manager to change configuration
  # defaults in a way that is incompatible with stateful data.
  # Update this when you want to consume newer defaults.
  # Release notes detailing changes to defaults are here:
  # https://github.com/nix-community/home-manager/tree/master/docs/release-notes
  home.stateVersion = "22.11";

  # Set the username & home directory. This should be
  # in sync with nix-darwin.
  home.username = config.nix-machine.username;
  home.homeDirectory = config.nix-machine.homeDirectory;
}
