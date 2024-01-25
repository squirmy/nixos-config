{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {self, ...}: let
    myself = (import ./users/myself.nix) {};
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} ({config, ...}: {
      systems = ["aarch64-darwin" "x86_64-darwin"];

      imports = [./lib];

      macos-machines."Adams-MBP" = {
        user = myself;
        system = "aarch64-darwin";

        nix-darwin = {
          imports = [./nix-darwin];
          nixpkgs.hostPlatform = "aarch64-darwin";
        };

        home-manager = {
          imports = [./home];
          programs.git.userName = myself.name;
          programs.git.userEmail = myself.email;
        };
      };
    });
}
