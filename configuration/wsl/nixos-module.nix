{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.wsl.enable {
  wsl.enable = true;
  wsl.wslConf.interop.appendWindowsPath = false;
}
