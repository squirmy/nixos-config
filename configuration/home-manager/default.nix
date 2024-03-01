{...}: {
  # Programs and packages to manage with home manager.
  imports = [
    ./fonts.nix
    ./git.nix
    ./rider.nix
    ./direnv.nix
    ./ssh.nix
    ./starship.nix
    ./kitty.nix
    ./fzf.nix
    ./vscode.nix
    ./yubikey.nix
    ./zoom.nix
    ./vim.nix
    ./shell.nix
  ];
}
