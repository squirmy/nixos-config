{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    # Rust toolchains and rust-analyzer nightly for Nix
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    # Nix expressions for VSCode and OpenVSX extensions updated daily
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # age-encrypted secrets for NixOS; drop-in replacement for agenix
    agenix.url = "github:yaxitech/ragenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-darwin" "x86_64-darwin"];

      imports = [
        ./lib
        ./users
        ./home
        ./nix-darwin
      ];

      flake = {
        darwinConfigurations."Adams-MBP" = self.lib.mkMacosHomeManagerSystem {
          nixpkgs.hostPlatform = "aarch64-darwin";
          imports = [
            self.darwinModules
          ];
        };
      };
    };
}
