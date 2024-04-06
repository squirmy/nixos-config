{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.magnet.enable {
  homebrew.masApps = {
    "Magnet" = 441258766;
  };
}
