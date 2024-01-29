{...}: let
  username = "squirmy";
  home = "/Users/${username}";
  user = {
    inherit username home;
    name = "Adam Woods";
    email = "squirmy.dev@gmail.com";
  };
in {
  nix-machine.macos."Adams-MBP" = {
    inherit user;
    system = "aarch64-darwin";
    home-manager.enable = true;

    squirmy = {
      fonts.enable = true;
      git = {
        enable = true;
        userName = user.name;
        userEmail = user.email;
      };
      rider.enable = true;
      yubikey.enable = true;
      shell.enable = true;
      ssh.enable = true;
      terminal.enable = true;
      trampoline.enable = true;
      vscode.enable = true;
      zoom.enable = true;
      homebrew.enable = true;
      macos.enable = true;
      network.enable = true;
      nix.enable = true;
    };
  };
}
