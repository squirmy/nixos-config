{lib, ...}: let
  catalogOptions = {
    nixpkgs.hostPlatform = lib.mkOption {
      type = lib.types.str;
      default = "aarch64-darwin";
    };
    nixpkgs.allowUnfree = lib.options.mkEnableOption "unfree software";
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
