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

  # GitUI
  # Blazing 💥 fast terminal-ui for git written in rust 🦀
  # https://github.com/extrawurst/gitui
  # Why: I like to be able to browse the git repository
  # in the terminal.
  # Theme from: https://github.com/catppuccin/gitui (🌺 Macchiato)
  programs.gitui.enable = true;
  programs.gitui.theme = ''
    (
        selected_tab: Some(Reset),
        command_fg: Some(Rgb(202, 211, 245)),
        selection_bg: Some(Rgb(91, 96, 120)),
        selection_fg: Some(Rgb(202, 211, 245)),
        cmdbar_bg: Some(Rgb(30, 32, 48)),
        cmdbar_extra_lines_bg: Some(Rgb(30, 32, 48)),
        disabled_fg: Some(Rgb(128, 135, 162)),
        diff_line_add: Some(Rgb(166, 218, 149)),
        diff_line_delete: Some(Rgb(237, 135, 150)),
        diff_file_added: Some(Rgb(238, 212, 159)),
        diff_file_removed: Some(Rgb(238, 153, 160)),
        diff_file_moved: Some(Rgb(198, 160, 246)),
        diff_file_modified: Some(Rgb(245, 169, 127)),
        commit_hash: Some(Rgb(183, 189, 248)),
        commit_time: Some(Rgb(184, 192, 224)),
        commit_author: Some(Rgb(125, 196, 228)),
        danger_fg: Some(Rgb(237, 135, 150)),
        push_gauge_bg: Some(Rgb(138, 173, 244)),
        push_gauge_fg: Some(Rgb(36, 39, 58)),
        tag_fg: Some(Rgb(244, 219, 214)),
        branch_fg: Some(Rgb(139, 213, 202))
    )
  '';

  # GitHub CLI
  # https://github.com/cli/cli
  programs.gh.enable = true;
  programs.gh.settings.git_protocol = "ssh";
}
