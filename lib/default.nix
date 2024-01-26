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

  nixDarwinOptions = {
    system = lib.mkOption {
      type = lib.types.str;
    };
    modules = lib.mkOption {
      type = lib.types.deferredModule;
    };
  };

  homeManagerOptions = {
    enable = lib.options.mkEnableOption "home-manager";
    modules = lib.mkOption {
      type = lib.types.deferredModule;
    };
  };

  machineOptions = {
    system = lib.mkOption {
      type = lib.types.str;
    };
    nix-darwin = lib.mkOption {
      type = lib.types.submodule {options = nixDarwinOptions;};
    };
    home-manager = lib.mkOption {
      type = lib.types.submodule {options = homeManagerOptions;};
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
          _machine-name: machine: let
            # Allow access to the user
            specialArgs = specialArgsFor.darwin // {myself = machine.user;};

            # home-manager configuration
            home-manager-modules = lib.lists.optionals machine.home-manager.enable [
              inputs.home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${machine.user.username} = {pkgs, ...}: {
                  imports = [
                    {
                      # Set the username & home directory. This should be
                      # in sync with nix-darwin. (below)
                      home.username = machine.user.username;
                      home.homeDirectory = machine.user.home;
                    }
                    machine.home-manager.modules
                  ];
                };
              }
            ];

            # nix-darwin configuration
            nix-darwin-modules = [
              {
                nixpkgs.hostPlatform = machine.nix-darwin.system;

                # Set the user's name & home directory. This should be
                # in sync with home manager. (above)
                users.users.${machine.user.username} = {
                  name = machine.user.username;
                  home = machine.user.home;
                };
              }
              machine.nix-darwin.modules
            ];
          in (inputs.nix-darwin.lib.darwinSystem {
            specialArgs = specialArgs;
            modules = nix-darwin-modules ++ home-manager-modules;
          })
        )
        config.macos-machines;
    };
  };
}
