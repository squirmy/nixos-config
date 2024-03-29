{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy._1blocker.enable {
  homebrew.masApps = {
    "1Blocker - Ad Blocker" = 1365531024;
  };
}
