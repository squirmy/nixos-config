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
}
