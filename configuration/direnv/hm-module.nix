{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.direnv.enable {
  # direnv
  # unclutter your .profile
  # https://direnv.net
  programs.direnv = {
    enable = true;
    enableZshIntegration = config.nix-machine.shells.zsh.enable;

    # nix-direnv
    # A fast, persistent use_nix/use_flake implementation for direnv
    # https://github.com/nix-community/nix-direnv
    nix-direnv.enable = true;
  };
}
