{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.macos.enable {
  targets.darwin.copyApps.enable = true;
  targets.darwin.linkApps.enable = false;
}
