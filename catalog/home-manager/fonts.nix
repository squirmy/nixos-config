{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.fonts.enable {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    fira-code
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];
}
