{...}: {
  nix-machine.configurations.squirmy = {
    path = ./.;
    scheme = "flat";
  };
}
