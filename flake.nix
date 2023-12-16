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

    # Fix .app programs installed by Nix on Mac
    # Why: Applications installed by home-manager don't show up in spotlight. This
    # module works around the issue. Can be removed if this is ever included
    # in home-manager.
    # Issue: https://github.com/nix-community/home-manager/issues/1341
    mac-app-util.url = "github:hraban/mac-app-util";
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
