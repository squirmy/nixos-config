{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  pkgs-gitui = import inputs.nixpkgs-gitui {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
  lib.mkIf config.squirmy.git.enable {
    # Git
    programs.git.enable = true;

    programs.git.ignores = [
      ".DS_Store"
    ];

    # Options documented here:
    # https://git-scm.com/docs/git-config#Documentation/git-config.txt
    programs.git.settings = {
      user.name = config.squirmy.git.userName;
      user.email = config.squirmy.git.userEmail;
      fetch.prune = true;
      diff.colorMoved = "default";
    };

    # Delta
    # https://github.com/dandavison/delta
    # Why: Enhanced `git diff` with syntax highlighting.
    # Also used for `git add -p`
    programs.delta.enable = true;
    programs.delta.options = {
      syntax-theme = "ansi";
    };
    programs.delta.enableGitIntegration = true;

    # GitUI
    # Blazing 💥 fast terminal-ui for git written in rust 🦀
    # https://github.com/extrawurst/gitui
    # Why: I like to be able to browse the git repository
    # in the terminal.
    programs.gitui.enable = true;
    programs.gitui.package = pkgs-gitui.gitui;

    # GitHub CLI
    # https://github.com/cli/cli
    programs.gh.enable = true;
    programs.gh.settings.git_protocol = "ssh";
  }
