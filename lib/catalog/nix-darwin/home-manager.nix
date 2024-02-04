{inputs, ...}: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = import ../../lib/special-args.nix {inherit inputs;};
}
