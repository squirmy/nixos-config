{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.experiments.enable {
  homebrew.casks = [
    "firefox"
  ];

  # This is a (perhaps futile) attempt at allowing nix-darwin to
  # overwrite the modified version of nix.conf that was installed
  # in install.sh. It needs to be updated if I ever change it,
  # or the nix installer changes it.
  environment.etc."nix/nix.conf".knownSha256Hashes = [
    "eae636b09923394ed1e4dc30179857beb72060bcb26c0f10c2c6a7787baf7dc1"
  ];

  # For now, until I sort out the nix build group
  ids.gids.nixbld = 350;

  # whilst nix-darwin does there thing
  system.primaryUser = config.nix-machine.username;
}
