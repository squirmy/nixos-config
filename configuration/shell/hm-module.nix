{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.shell.enable {
  # Colorize ls on macos
  home.sessionVariables = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {CLICOLOR = "1";};
}
