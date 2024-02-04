{...}: let
  username = "squirmy";
  homeDirectory = "/Users/${username}";
  name = "Adam Woods";
  email = "squirmy.dev@gmail.com";
in {
  nix-machine.macos."Adams-MBP" = {
    nix-machine = {
      inherit username homeDirectory;
      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        allowUnfree = true;
      };
    };

    squirmy = {
      fonts.enable = true;
      git = {
        enable = true;
        userName = name;
        userEmail = email;
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
      onepassword.enable = true;
      slack.enable = true;
      macos.enable = true;
      network.enable = true;
    };
  };
}
