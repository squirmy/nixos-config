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

  imports = [./catalog];

  config = {
    flake = {
      darwinConfigurations =
        builtins.mapAttrs (
          _machine-name: machine: let
            # Allow access to the user
            specialArgs = specialArgsFor.darwin;

            # Remove non-catalog options from the machine config
            options = builtins.removeAttrs machine (builtins.attrNames macosMachineOptions);

            # nix-darwin configuration
            nix-darwin-modules = [nixDarwinModules options];

            # home-manager configuration
            home-manager-modules = lib.lists.optionals machine.home-manager.enable [
              inputs.home-manager.darwinModules.home-manager
              ({config, ...}: {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${config.nix-machine.username} = {pkgs, ...}: {
                  imports = [
                    homeManagerModules
                    options
                  ];
                };
              })
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
