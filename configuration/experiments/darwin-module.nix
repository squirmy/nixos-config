{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.experiments.enable {
  homebrew.casks = [
    "firefox"
  ];

  nix.settings = {
    trusted-substituters = [
      "https://toyvo.cachix.org"
    ];
    trusted-public-keys = [
      "toyvo.cachix.org-1:s++CG1te6YaS9mjICre0Ybbya2o/S9fZIyDNGiD4UXs="
    ];
  };

  # This is a (perhaps futile) attempt at allowing nix-darwin to
  # overwrite the modified version of nix.conf that was installed
  # in install.sh. It needs to be updated if I ever change it,
  # or the nix installer changes it.
  environment.etc."nix/nix.conf".knownSha256Hashes = [
    "eae636b09923394ed1e4dc30179857beb72060bcb26c0f10c2c6a7787baf7dc1"
  ];
}
