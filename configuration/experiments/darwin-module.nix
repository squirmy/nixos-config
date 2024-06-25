{config, ...}: {
  nix.settings.trusted-users = ["root" config.nix-machine.username];

  homebrew.casks = [
    "betterdisplay"
  ];
}
