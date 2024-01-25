{...}: {
  # It is occasionally necessary for Home Manager to change configuration
  # defaults in a way that is incompatible with stateful data.
  # Update this when you want to consume newer defaults.
  home.stateVersion = "22.11";

  # Programs and packages to manage with home manager.
  imports = [
    ./trampoline
    ./terminal.nix
    ./secrets.nix
    ./ssh.nix
    ./git.nix
    ./rider.nix
    ./shell.nix
    ./vscode.nix
    ./zoom.nix
  ];
}
