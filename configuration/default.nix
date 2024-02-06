{...}: {
  nix-machine.configurations.squirmy = {
    options = ./options.nix;
    nixDarwin = ./nix-darwin;
    homeManager = ./home-manager;
  };
}
