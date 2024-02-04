{lib, ...}: let
  catalogOptions = {
    nixpkgs.hostPlatform = lib.mkOption {
      type = lib.types.str;
      default = "aarch64-darwin";
    };
    nixpkgs.allowUnfree = lib.mkOption {
      default = true;
      example = false;
      description = "Whether to enable unfree software.";
      type = lib.types.bool;
    };
    trampoline.enable = lib.mkOption {
      default = true;
      example = false;
      description = "Whether to enable trampoline.";
      type = lib.types.bool;
    };
    username = lib.mkOption {
      type = lib.types.str;
    };
    homeDirectory = lib.mkOption {
      type = lib.types.str;
    };
  };
in {
  options.nix-machine = lib.mkOption {
    type = lib.types.submodule {options = catalogOptions;};
    default = {};
  };
}
