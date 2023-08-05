{ config, ... }:

{
  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;

  homebrew.taps = [
    "nrlquaker/createzap"
  ];

  # Prefer installing application from the Mac App Store
  homebrew.masApps = {
    # "1Password for Safari" = 1569813296;
  };

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    # Raycast
    # Raycast is a blazingly fast, totally extendable launcher. It lets you 
    # complete tasks, calculate, share common links, and much more.
    # https://www.raycast.com/
    # Why: Applications installed by home-manager don't show up in spotlight.
    # Issue: https://github.com/nix-community/home-manager/issues/1341
    "raycast"
    "visual-studio-code"
  ];

  # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
  # installed in `../home/default.nix` whenever possible.
  homebrew.brews = [
  ];
}
  