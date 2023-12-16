{config, ...}: {
  flake = {
    homeModules = {
      # Set the username & home directory. This should be
      # in sync with nix-darwin. (nix-darwin/macos.nix)
      home.username = config.myself.username;
      home.homeDirectory = config.myself.home;

      # It is occasionally necessary for Home Manager to change configuration
      # defaults in a way that is incompatible with stateful data.
      # Update this when you want to consume newer defaults.
      home.stateVersion = "22.11";

      # Programs and packages to manage with home manager.
      imports = [
        ./terminal.nix
        ./secrets.nix
        ./ssh.nix
        ./git.nix
        # TODO: remove this and other rust configuration after moving this
        # to a project specfic flake.
        # ./rust.nix
        ./rider.nix
        ./shell.nix
        ./vscode.nix
        ./zoom.nix
      ];
    };
  };
}
