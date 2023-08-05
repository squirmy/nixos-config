{ self, config, ... }:

{
  flake = {
    xxx = {
      my-home = {
        home-manager.users.${config.myself.username} = { pkgs, ... }: {
          imports = [
            self.homeModules.default
          ];
        };
      };

      default.imports = [
        self.darwinModules.home-manager
        self.xxx.my-home
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