{
  lib,
  inputs,
  ...
}: {
  home-manager.useGlobalPkgs = lib.mkDefault true;
  home-manager.useUserPackages = lib.mkDefault true;

  # allow home-manager modules to access inputs
  home-manager.extraSpecialArgs = import ../../lib/special-args.nix {inherit inputs;};
}
