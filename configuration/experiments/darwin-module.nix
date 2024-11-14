{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.experiments.enable {
  homebrew.casks = [
    "firefox"
  ];
}
