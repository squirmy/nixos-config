{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-dockutil.url = "github:NixOS/nixpkgs/e89cf1c932006531f454de7d652163a9a5c86668";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-machine.url = "github:squirmy/nix-machine";
    nix-machine.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Used in the pre-commit hook
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    flake-root.url = "github:srid/flake-root";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks-nix.inputs.nixpkgs.follows = "nixpkgs";
    nh-darwin.url = "github:ToyVo/nh-darwin";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-darwin"];
      imports = [
        inputs.devshell.flakeModule
        inputs.treefmt-nix.flakeModule
        inputs.flake-root.flakeModule
        inputs.pre-commit-hooks-nix.flakeModule
        inputs.nix-machine.flakeModule
        ./configuration
        ./devshell.nix
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
          yubikey.enable = true;
          shell.enable = true;
          direnv.enable = true;
          ssh.enable = true;
          pure.enable = true;
          wezterm.enable = true;
          fzf.enable = true;
          vscode.enable = true;
          zoom.enable = true;
          homebrew.enable = true;
          _1blocker.enable = true;
          _1password.enable = true;
          darkroom.enable = true;
          magnet.enable = true;
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
