{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.ninetofive.enable {
  homebrew.masApps = {
    "Citrix Secure Access" = 1338991513;
  };
}
