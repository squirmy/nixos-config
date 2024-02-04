{inputs}: {
  inherit inputs;
  rosettaPkgs = import inputs.nixpkgs {system = "x86_64-darwin";};
}
