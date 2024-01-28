{
  self,
  inputs,
  config,
  lib,
  ...
}: let
  catalog = config.catalog;

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

  macosMachineOptions = {
    home-manager.enable = lib.options.mkEnableOption "home-manager";
    system = lib.mkOption {
      type = lib.types.str;
    };
    user = lib.mkOption {
      type = lib.types.submodule {
        options = userOptions;
        freeformType = lib.types.attrsOf lib.types.anything;
      };
    };
  };
in {
  options.catalog.options = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
  };
  options.catalog.nixDarwinModules = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
  };
  options.catalog.homeManagerModules = lib.mkOption {
    type = lib.types.deferredModule;
    default = {};
  };

  options.macos-machines = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submoduleWith {
      modules = [catalog.options {options = macosMachineOptions;}];
    });
    default = {};
  };

  config = let
    # Share the options between nix-darwin and home-manager so that they can be
    # configured in a way that is agnostic to the where the configuration applies.
    nixDarwinModules = {imports = [catalog.options catalog.nixDarwinModules];};
    homeManagerModules = {imports = [catalog.options catalog.homeManagerModules];};
  in {
    flake = {
      darwinConfigurations =
        builtins.mapAttrs (
          _machine-name: machine: let
            # Allow access to the user
            specialArgs = specialArgsFor.darwin // {myself = machine.user;};

            # Remove non-catalog options from the machine config
            catalogOptions = builtins.removeAttrs machine (builtins.attrNames macosMachineOptions);

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
                    homeManagerModules
                    catalogOptions
                  ];
                };
              }
            ];

            # nix-darwin configuration
            nix-darwin-modules = [
              {
                nixpkgs.hostPlatform = machine.system;

                # Set the user's name & home directory. This should be
                # in sync with home manager. (above)
                users.users.${machine.user.username} = {
                  name = machine.user.username;
                  home = machine.user.home;
                };
              }
              nixDarwinModules
              catalogOptions
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
