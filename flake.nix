{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-machine.url = "github:squirmy/nix-machine";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-darwin" "x86_64-darwin"];
      imports = [
        inputs.nix-machine.flakeModule
        ./configuration
      ];

      nix-machine.macos."Adams-MBP" = {
        nix-machine = {
          username = "squirmy";
          homeDirectory = "/Users/squirmy";
          nixpkgs.hostPlatform = "aarch64-darwin";
          shells.zsh.enable = true;
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
          direnv.enable = true;
          ssh.enable = true;
          starship.enable = true;
          kitty.enable = true;
          fzf.enable = true;
          vscode.enable = true;
          zoom.enable = true;
          homebrew.enable = true;
          _1blocker.enable = true;
          _1password.enable = true;
          slack.enable = true;
          macos.enable = true;
          network.enable = true;
          vim.enable = true;
          experiments.enable = true;
        };
      };

      flake = {
        flakeModule = ./configuration;
      };
    };
}
