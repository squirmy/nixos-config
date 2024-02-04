{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-darwin" "x86_64-darwin"];
      imports = [./lib ./catalog];

      nix-machine.macos."Adams-MBP" = {
        nix-machine = {
          username = "squirmy";
          homeDirectory = "/Users/squirmy";
          nixpkgs.hostPlatform = "aarch64-darwin";
        };

        squirmy = {
          fonts.enable = true;
          git = {
            enable = true;
            userName = "Adam Woods";
            userEmail = "squirmy.dev@gmail.com";
          };
          rider.enable = true;
          yubikey.enable = true;
          shell.enable = true;
          ssh.enable = true;
          terminal.enable = true;
          vscode.enable = true;
          zoom.enable = true;
          homebrew.enable = true;
          onepassword.enable = true;
          slack.enable = true;
          macos.enable = true;
          network.enable = true;
        };
      };

      flake = {
        flakeModule = ./catalog;
      };
    };
}
