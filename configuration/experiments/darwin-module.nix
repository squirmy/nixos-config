{inputs, ...}: {
  # Issue: https://github.com/NixOS/nixpkgs/issues/327836
  # Remove this and the flake input once either:
  #   1. Swift builds quicker
  #   2. Swift is able to be sourced from the cache
  nixpkgs.overlays = [
    (_final: _prev: {
      dockutil = inputs.nixpkgs-dockutil.legacyPackages.aarch64-darwin.dockutil;
    })
  ];

  homebrew.masApps = {
    "Citrix Secure Access" = 1338991513;
  };

  homebrew.casks = [
    "firefox"
  ];
}
