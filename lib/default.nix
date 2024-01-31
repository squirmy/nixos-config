{
  self,
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

  macosMachineOptions = {
    # I'm assuming that home-manager is going to be wanted most of the time
    # so enabling it by default.
    home-manager.enable = lib.mkOption {
      default = true;
      example = false;
      description = "Whether to enable home-manager.";
      type = lib.types.bool;
    };
    system = lib.mkOption {
      type = lib.types.str;
      default = "aarch64-darwin";
    };
    username = lib.mkOption {
      type = lib.types.str;
    };
    homeDirectory = lib.mkOption {
      type = lib.types.str;
    };
  };

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
      modules = allCatalogOptions ++ [{options = macosMachineOptions;}];
    });
    default = {};
  };

  config = {
    flake = {
      darwinConfigurations =
        builtins.mapAttrs (
          _machine-name: machine: let
            # Allow access to the user
            specialArgs = specialArgsFor.darwin;

            # Remove non-catalog options from the machine config
            options = builtins.removeAttrs machine (builtins.attrNames macosMachineOptions);

            # home-manager configuration
            home-manager-modules = lib.lists.optionals machine.home-manager.enable [
              inputs.home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${machine.username} = {pkgs, ...}: {
                  imports = [
                    {
                      # It is occasionally necessary for Home Manager to change configuration
                      # defaults in a way that is incompatible with stateful data.
                      # Update this when you want to consume newer defaults.
                      home.stateVersion = "22.11";

                      # Set the username & home directory. This should be
                      # in sync with nix-darwin. (below)
                      home.username = machine.username;
                      home.homeDirectory = machine.homeDirectory;
                    }
                    homeManagerModules
                    options
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
                users.users.${machine.username} = {
                  name = machine.username;
                  home = machine.homeDirectory;
                };
              }
              nixDarwinModules
              options
            ];
          in (inputs.nix-darwin.lib.darwinSystem {
            specialArgs = specialArgs;
            modules = nix-darwin-modules ++ home-manager-modules;
          })
        )
        nix-machine.macos;
    };
  };
}
