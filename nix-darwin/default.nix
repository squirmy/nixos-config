{
  inputs,
  self,
  config,
  ...
}: {
  flake = {
    darwinModules = {
      imports = [
        {
          home-manager.users.${config.myself.username} = {pkgs, ...}: {
            imports = [
              self.homeModules
            ];
          };
        }
        ./nix.nix
        ./shell.nix
        ./network.nix
        ./macos.nix
        ./fonts.nix
        ./homebrew.nix
      ];
    };
  };
}
