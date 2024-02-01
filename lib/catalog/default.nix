{...}: {
  nix-machine.catalogs.nix-machine = {
    options = ./options.nix;
    nixDarwinModules = ./nix-darwin;
    homeManagerModules = ./home-manager;
  };
}
