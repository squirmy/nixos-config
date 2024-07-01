{inputs, ...}: {
  nixpkgs.overlays = [
    (_final: _prev: {
      swift = inputs.nixpkgs-swift.legacyPackages.aarch64-darwin.swift;
    })
  ];
}
