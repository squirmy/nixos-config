{
  self,
  inputs,
  config,
  ...
}: let
  specialArgsFor = rec {
    common = {
      flake = {inherit self inputs config;};
    };
    nixos = common;
    darwin =
      common
      // {
        rosettaPkgs = import inputs.nixpkgs {system = "x86_64-darwin";};
      };
  };
in {
  flake = {
    lib = {
      mkMacosHomeManagerSystem = mod:
        inputs.nix-darwin.lib.darwinSystem {
          specialArgs = specialArgsFor.darwin;
          modules =
            [
              inputs.home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgsFor.darwin;
              }
            ]
            ++ [mod];
        };
    };
  };
}
