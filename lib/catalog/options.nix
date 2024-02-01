{lib, ...}: let
  catalogOptions = {
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
in {
  options.nix-machine = lib.mkOption {
    type = lib.types.submodule {options = catalogOptions;};
    default = {};
  };
}
