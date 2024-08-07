{inputs, ...}: {
  nixpkgs.overlays = [
    (_final: _prev: {
      dockutil = inputs.nixpkgs-dockutil.legacyPackages.aarch64-darwin.dockutil;
    })
  ];

  homebrew.masApps = {
    "Citrix Secure Access" = 1338991513;
  };
}
