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
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-darwin" "x86_64-darwin"];

      imports = [./lib ./catalog];

      nix-machine.macos."Adams-MBP" = {
        system = "aarch64-darwin";
        user = ./users/myself.nix;
        home-manager.enable = true;

        squirmy = {
          fonts.enable = true;
          git.enable = true;
          rider.enable = true;
          secrets.enable = true;
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
    };
}
