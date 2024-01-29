{...}: {
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
    ./fonts.nix
  ];
}
