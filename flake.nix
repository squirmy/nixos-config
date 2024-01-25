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
    user = (import ./users/myself.nix) {};
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} ({config, ...}: {
      systems = ["aarch64-darwin" "x86_64-darwin"];

      imports = [./lib];

      macos-machines."Adams-MBP" = {
        system = "aarch64-darwin";

        inherit user;

        nix-darwin = {
          imports = [./nix-darwin];
        };

        home-manager = {
          imports = [./home];
          programs.git.userName = user.name;
          programs.git.userEmail = user.email;
        };
      };
    });
}
