{
  inputs,
  self,
  config,
  ...
}: {
  flake = {
    darwinModules = {
      imports = [
        inputs.mac-app-util.darwinModules.default
        {
          home-manager.users.${config.myself.username} = {pkgs, ...}: {
            imports = [
              inputs.mac-app-util.homeManagerModules.default
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
