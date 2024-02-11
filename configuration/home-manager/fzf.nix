{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.fzf.enable {
  # fzf
  # 🌸 A command-line fuzzy finder
  # https://github.com/junegunn/fzf
  # Why: Handy for searching through history for past commands
  programs.fzf = {
    enable = true;
    enableZshIntegration = config.squirmy.zsh.enable;
  };
}
