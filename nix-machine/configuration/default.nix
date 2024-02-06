{...}: {
  nix-machine.configurations.nix-machine = {
    options = ./options.nix;
    nixDarwin = ./nix-darwin;
    homeManager = ./home-manager;
  };
}
