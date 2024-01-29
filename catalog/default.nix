{...}: {
  nix-machine.catalogs.squirmy = {
    options = ./options.nix;
    nixDarwinModules = ./nix-darwin;
    homeManagerModules = ./home-manager;
  };
}
