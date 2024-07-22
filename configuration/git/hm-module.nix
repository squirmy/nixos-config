{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.git.enable {
  # Git
  programs.git.enable = true;
  programs.git.userName = config.squirmy.git.userName;
  programs.git.userEmail = config.squirmy.git.userEmail;

  programs.git.ignores = [
    ".DS_Store"
  ];

  # Options documented here:
  # https://git-scm.com/docs/git-config#Documentation/git-config.txt
  programs.git.extraConfig = {
    fetch.prune = true;
    diff.colorMoved = "default";
  };

  # Delta
  # https://github.com/dandavison/delta
  # Why: Enhanced `git diff` with syntax highlighting.
  # Also used for `git add -p`
  programs.git.delta.enable = true;
  programs.git.delta.options = {
    syntax-theme = "ansi";
  };

  # GitUI
  # Blazing 💥 fast terminal-ui for git written in rust 🦀
  # https://github.com/extrawurst/gitui
  # Why: I like to be able to browse the git repository
  # in the terminal.
  programs.gitui.enable = true;

  # GitHub CLI
  # https://github.com/cli/cli
  programs.gh.enable = true;
  programs.gh.settings.git_protocol = "ssh";
}
