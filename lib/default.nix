{
  self,
  inputs,
  config,
  lib,
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

  userOptions = {
    username = lib.mkOption {
      type = lib.types.str;
    };
    home = lib.mkOption {
      type = lib.types.str;
    };
  };

  machineOptions = {
    system = lib.mkOption {
      type = lib.types.str;
    };
    nix-darwin = lib.mkOption {
      type = lib.types.deferredModule;
    };
    home-manager = lib.mkOption {
      type = lib.types.deferredModule;
    };
    user = lib.mkOption {
      type = lib.types.submodule {
        options = userOptions;
        freeformType = lib.types.attrsOf lib.types.anything;
      };
    };
  };
in {
  options.macos-machines = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {options = machineOptions;});
    default = {};
  };

  config = {
    flake = {
      darwinConfigurations =
        builtins.mapAttrs (
          _machine-name: machine: (inputs.nix-darwin.lib.darwinSystem {
            specialArgs = specialArgsFor.darwin;
            modules = [
              inputs.home-manager.darwinModules.home-manager
              {
                # home-manager configuration
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgsFor.darwin;

                home-manager.users.${machine.user.username} = {pkgs, ...}: {
                  imports = [
                    {
                      # Set the username & home directory. This should be
                      # in sync with nix-darwin. (below)
                      home.username = machine.user.username;
                      home.homeDirectory = machine.user.home;
                    }
                    machine.home-manager
                  ];
                };
              }
              {
                # nix-darwin configuration

                # Set the user's name & home directory. This should be
                # in sync with home manager. (above)
                users.users.${machine.user.username} = {
                  name = machine.user.username;
                  home = machine.user.home;
                };

                imports = [machine.nix-darwin];
              }
            ];
          })
        )
        config.macos-machines;
    };
  };
}
