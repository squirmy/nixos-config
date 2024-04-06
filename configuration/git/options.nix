{lib, ...}: {
  options.squirmy.git.enable = lib.options.mkEnableOption "git";
  options.squirmy.git.userName = lib.mkOption {
    type = lib.types.str;
  };
  options.squirmy.git.userEmail = lib.mkOption {
    type = lib.types.str;
  };
}
