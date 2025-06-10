{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
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

    vscodes.url = "github:jcszymansk/vscodes";
    vscodes.inputs.nixpkgs.follows = "nixpkgs";
    vscodes.inputs.homeManager.follows = "home-manager";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-darwin" "x86_64-linux"];
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
          trampoline.enable = false;
        };

        squirmy = {
          fonts.enable = true;
          git = {
            enable = true;
            userName = "Adam Woods";
            userEmail = "squirmy.dev@gmail.com";
          };
          yubikey.enable = true;
          ssh.enable = true;
          terminal.enable = true;
          vscode.enable = true;
          zoom.enable = true;
          homebrew.enable = true;
          _1blocker.enable = true;
          _1password.enable = true;
          darkroom.enable = true;
          slack.enable = true;
          macos.enable = true;
          network.enable = true;
          experiments.enable = true;
          ninetofive.enable = true;
        };
      };

      nix-machine.macos."Squirmy-MBP" = {
        nix-machine = {
          username = "squirmy";
          homeDirectory = "/Users/squirmy";
          nixpkgs.hostPlatform = "aarch64-darwin";
          shells.zsh.enable = true;
          trampoline.enable = false;
        };

        squirmy = {
          fonts.enable = true;
          git = {
            enable = true;
            userName = "Adam Woods";
            userEmail = "squirmy.dev@gmail.com";
          };
          yubikey.enable = true;
          ssh.enable = true;
          terminal.enable = true;
          vscode.enable = true;
          homebrew.enable = true;
          _1blocker.enable = true;
          _1password.enable = true;
          darkroom.enable = true;
          slack.enable = true;
          macos.enable = true;
          network.enable = true;
          experiments.enable = true;
        };
      };

      nix-machine.linux."Squirmy-WSL" = {
        nix-machine = {
          username = "nixos";
          homeDirectory = "/home/nixos";
          nixpkgs.hostPlatform = "x86_64-linux";
          shells.zsh.enable = true;
        };

        squirmy = {
          wsl.enable = true;
          git = {
            enable = true;
            userName = "Adam Woods";
            userEmail = "squirmy.dev@gmail.com";
          };
          ssh.enable = true;
          terminal.enable = true;
          yubikey.enable = true;
        };
      };

      flake = {
        flakeModule = ./configuration;
      };
    };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
  };
}
