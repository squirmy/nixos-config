{myself, ...}: {
  config = {
    # Git
    programs.git.enable = true;
    programs.git.userName = myself.name;
    programs.git.userEmail = myself.email;

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
        selected_tab: Reset,
        command_fg: Rgb(202, 211, 245),
        selection_bg: Rgb(91, 96, 120),
        selection_fg: Rgb(202, 211, 245),
        cmdbar_bg: Rgb(30, 32, 48),
        cmdbar_extra_lines_bg: Rgb(30, 32, 48),
        disabled_fg: Rgb(128, 135, 162),
        diff_line_add: Rgb(166, 218, 149),
        diff_line_delete: Rgb(237, 135, 150),
        diff_file_added: Rgb(238, 212, 159),
        diff_file_removed: Rgb(238, 153, 160),
        diff_file_moved: Rgb(198, 160, 246),
        diff_file_modified: Rgb(245, 169, 127),
        commit_hash: Rgb(183, 189, 248),
        commit_time: Rgb(184, 192, 224),
        commit_author: Rgb(125, 196, 228),
        danger_fg: Rgb(237, 135, 150),
        push_gauge_bg: Rgb(138, 173, 244),
        push_gauge_fg: Rgb(36, 39, 58),
        tag_fg: Rgb(244, 219, 214),
        branch_fg: Rgb(139, 213, 202)
      )
    '';

    # GitHub CLI
    # https://github.com/cli/cli
    programs.gh.enable = true;
    programs.gh.settings.git_protocol = "ssh";
  };
}
