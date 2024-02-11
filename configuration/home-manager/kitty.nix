{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.kitty.enable {
  # kitty
  # The fast, feature-rich, GPU based terminal emulator
  # https://sw.kovidgoyal.net/kitty/
  # Why:
  #   1. Font & Color scheme is able to be configured easily, unlike iterm.
  #   2. Wasn't impressed with the Alacritty maintainers attitude towards
  #      accepting contributions from the community.
  #      - https://github.com/alacritty/alacritty/issues/3926
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = config.squirmy.zsh.enable;
    theme = "Tomorrow Night Eighties";
    extraConfig = ''
      # Use JetBrainsMono with its recommended font size and line height
      font_family JetBrainsMono Nerd Font
      font_size 13.0
      modify_font cell_height +2.6px";
    '';
  };
}
