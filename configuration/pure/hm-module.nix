{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.pure.enable {
  home.packages = [
    pkgs.pure-prompt
  ];

  programs.zsh.initExtra = lib.mkIf config.nix-machine.shells.zsh.enable ''
    fpath+=(${pkgs.pure-prompt})
    autoload -U promptinit; promptinit
    prompt pure
  '';
}
