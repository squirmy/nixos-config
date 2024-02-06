{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.shell.enable {
  # direnv
  # unclutter your .profile
  # https://direnv.net
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;

    # nix-direnv
    # A fast, persistent use_nix/use_flake implementation for direnv
    # https://github.com/nix-community/nix-direnv
    nix-direnv.enable = true;
  };

  programs.zsh.enable = true;
}
