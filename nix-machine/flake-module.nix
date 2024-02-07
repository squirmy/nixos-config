{
  inputs,
  config,
  lib,
  ...
}: let
  nix-machine = config.nix-machine;

  configurations = map (x: x.value) (lib.attrsets.attrsToList nix-machine.configurations);

  sharedOptions = lib.catAttrs "options" configurations;
  nixDarwinConfigurations = lib.catAttrs "nixDarwin" configurations;
  homeManagerConfigurations = lib.catAttrs "homeManager" configurations;

  # Share the options between nix-darwin and home-manager so that they can be
  # configured in a way that is agnostic to the where the configuration applies.
  nixDarwinConfiguration = {imports = sharedOptions ++ nixDarwinConfigurations;};
  homeManagerConfiguration = {imports = sharedOptions ++ homeManagerConfigurations;};

  nix-homebrew = lib.lists.optionals (lib.hasAttr "nix-homebrew" inputs) [inputs.nix-homebrew.darwinModules.nix-homebrew];

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
      modules = sharedOptions;
    });
    default = {};
  };

  imports = [./configuration];

  config = {
    flake = {
      darwinConfigurations =
        builtins.mapAttrs (
          _machineName: machineConfig: (inputs.nix-darwin.lib.darwinSystem {
            # allow nix-darwin modules to access inputs
            specialArgs = import ./lib/special-args.nix {inherit inputs;};

            # nix-darwin configuration
            modules =
              nix-homebrew
              ++ [
                inputs.home-manager.darwinModules.home-manager
                {
                  home-manager.users.${machineConfig.nix-machine.username} = {
                    imports = [homeManagerConfiguration machineConfig];
                  };
                }
                nixDarwinConfiguration
                machineConfig
              ];
          })
        )
        nix-machine.macos;
    };
  };
}
