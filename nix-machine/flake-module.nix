{
  inputs,
  config,
  lib,
  ...
}: let
  nix-machine = config.nix-machine;

  configurations = map (x: x.value) (lib.attrsets.attrsToList nix-machine.configurations);

  yyy = lib.catAttrs "options" configurations;
  nixDarwinConfigurations = lib.catAttrs "nixDarwin" configurations;
  homeManagerConfigurations = lib.catAttrs "homeManager" configurations;

  # Share the options between nix-darwin and home-manager so that they can be
  # configured in a way that is agnostic to the where the configuration applies.
  nixDarwinConfiguration = {imports = yyy ++ nixDarwinConfigurations;};
  homeManagerConfiguration = {imports = yyy ++ homeManagerConfigurations;};

  configurationOptions = {
    options = lib.mkOption {
      type = lib.types.deferredModule;
      default = {};
    };
    nixDarwin = lib.mkOption {
      type = lib.types.deferredModule;
      default = {};
    };
    homeManager = lib.mkOption {
      type = lib.types.deferredModule;
      default = {};
    };
  };
in {
  options.nix-machine.configurations = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {options = configurationOptions;});
    default = {};
  };

  options.nix-machine.macos = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submoduleWith {
      modules = yyy;
    });
    default = {};
  };

  imports = [./configuration];

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
                  imports = [homeManagerConfiguration machineConfig];
                };
              }
              nixDarwinConfiguration
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
