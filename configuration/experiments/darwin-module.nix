{inputs, ...}: {
  nixpkgs.overlays = [
    (_final: _prev: {
      dockutil = inputs.nixpkgs-dockutil.legacyPackages.aarch64-darwin.dockutil;
    })
  ];
}
