{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.git.enable {
  environment.variables = lib.mkIf config.squirmy.wsl.enable {
    GH_BROWSER = "/mnt/c/Windows/explorer.exe";
  };
}
