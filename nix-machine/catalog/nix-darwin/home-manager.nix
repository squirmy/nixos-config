{
  lib,
  inputs,
  ...
}: {
  home-manager.useGlobalPkgs = lib.mkDefault true;
  home-manager.useUserPackages = lib.mkDefault true;
  home-manager.extraSpecialArgs = import ../../lib/special-args.nix {inherit inputs;};
}
