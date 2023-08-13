{ pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    fira-code
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
