{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.darkroom.enable {
  homebrew.masApps = {
    "Darkroom - Photo & Video Editor" = 953286746;
  };
}
