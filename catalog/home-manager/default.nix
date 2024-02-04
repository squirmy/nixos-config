{...}: {
  # Programs and packages to manage with home manager.
  imports = [
    ./fonts.nix
    ./git.nix
    ./rider.nix
    ./shell.nix
    ./ssh.nix
    ./terminal.nix
    ./vscode.nix
    ./yubikey.nix
    ./zoom.nix
  ];
}
