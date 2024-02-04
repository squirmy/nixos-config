{
  inputs,
  config,
  lib,
  ...
}: let
  nix-machine = config.nix-machine;

  catalogs = map (catalog: catalog.value) (lib.attrsets.attrsToList nix-machine.catalogs);

  allCatalogOptions = lib.catAttrs "options" catalogs;
  allNixDarwinModules = lib.catAttrs "nixDarwinModules" catalogs;
  allHomeManagerModules = lib.catAttrs "homeManagerModules" catalogs;

  # Share the options between nix-darwin and home-manager so that they can be
  # configured in a way that is agnostic to the where the configuration applies.
  nixDarwinModules = {imports = allCatalogOptions ++ allNixDarwinModules;};
  homeManagerModules = {imports = allCatalogOptions ++ allHomeManagerModules;};

  catalogOptions = {
    options = lib.mkOption {
      type = lib.types.deferredModule;
      default = {};
    };
    nixDarwinModules = lib.mkOption {
      type = lib.types.deferredModule;
      default = {};
    };
    homeManagerModules = lib.mkOption {
      type = lib.types.deferredModule;
      default = {};
    };
  };
in {
  options.nix-machine.catalogs = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {options = catalogOptions;});
    default = {};
  };

  options.nix-machine.macos = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submoduleWith {
      modules = allCatalogOptions;
    });
    default = {};
  };

  imports = [./catalog];

  config = {
    flake = {
      darwinConfigurations =
        builtins.mapAttrs (
          _machine-name: options: let
            # allow nix-darwin and home-manager catalog modules to access inputs
            specialArgs = {
              inherit inputs;
              rosettaPkgs = import inputs.nixpkgs {system = "x86_64-darwin";};
            };

            # nix-darwin configuration
            nix-darwin-modules = [
              inputs.home-manager.darwinModules.home-manager
              inputs.nix-homebrew.darwinModules.nix-homebrew
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${options.nix-machine.username} = {
                  imports = [homeManagerModules options];
                };
              }
              nixDarwinModules
              options
            ];
          in (inputs.nix-darwin.lib.darwinSystem {
            inherit specialArgs;
            modules = nix-darwin-modules;
          })
        )
        nix-machine.macos;
    };
  };
}
