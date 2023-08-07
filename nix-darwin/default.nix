{ self, config, ... }:

{
  flake = {
    darwinModules = {
      my-home = {
        home-manager.users.${config.myself.username} = { pkgs, ... }: {
          imports = [
            self.homeModules.default
          ];
        };
      };

      default.imports = [
        self.darwinModules.my-home
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