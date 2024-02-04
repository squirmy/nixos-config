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
          _machine-name: machineConfig: let
            # allow nix-darwin modules to access inputs
            specialArgs = import ./lib/special-args.nix {inherit inputs;};

            # nix-darwin configuration
            nix-darwin-modules = [
              inputs.home-manager.darwinModules.home-manager
              inputs.nix-homebrew.darwinModules.nix-homebrew
              {
                home-manager.users.${machineConfig.nix-machine.username} = {
                  imports = [homeManagerModules machineConfig];
                };
              }
              nixDarwinModules
              machineConfig
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
