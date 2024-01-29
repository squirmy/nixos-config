{...}: {
  nix-machine.catalogs.squirmy.options = ./options.nix;
  nix-machine.catalogs.squirmy.nixDarwinModules = ./nix-darwin;
  nix-machine.catalogs.squirmy.homeManagerModules = ./home-manager;
}
