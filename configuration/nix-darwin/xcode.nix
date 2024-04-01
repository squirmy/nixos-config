{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.xcode.enable {
  homebrew.masApps = {
    "Xcode" = 497799835;
  };
}
