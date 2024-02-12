{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} ({flake-parts-lib, ...}: {
      systems = ["aarch64-darwin" "x86_64-darwin"];
      imports = [
        ./nix-machine/flake-module.nix
        ./configuration
      ];

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
          zsh.enable = true;
          direnv.enable = true;
          ssh.enable = true;
          starship.enable = true;
          kitty.enable = true;
          fzf.enable = true;
          vscode.enable = true;
          zoom.enable = true;
          homebrew.enable = true;
          onepassword.enable = true;
          slack.enable = true;
          macos.enable = true;
          network.enable = true;
          vim.enable = true;
        };
      };

      flake = {
        flakeModule = ./configuration;
      };
    });
}
