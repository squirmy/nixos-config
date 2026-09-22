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

  githubLib = import ../github/lib.nix;

  scopedIdentities = lib.filterAttrs (_: identity: !githubLib.isDefaultIdentity identity) config.squirmy.github.identities;

  # Refuses to commit while user.email is still the machine's default,
  # inside a directory scoped to another GitHub identity — keeps
  # wrong-email commits out of history in the first place. Chains to any
  # repo-local pre-commit hook so per-project hook tooling still runs.
  identityGuardHooksDir = ".config/git/identity-guard-hooks";
  identityGuardHook = ''
    #!/usr/bin/env bash
    set -euo pipefail

    default_email="${config.squirmy.git.userEmail}"
    current_email="$(git config user.email || true)"

    if [ "$current_email" = "$default_email" ]; then
      echo "error: this repo is under a scoped GitHub identity, but user.email is still the default ($default_email)." >&2
      echo "Set it for this repo: git config user.email <address>" >&2
      exit 1
    fi

    git_dir="$(git rev-parse --git-dir)"
    local_hook="$git_dir/hooks/pre-commit"
    if [ -x "$local_hook" ]; then
      exec "$local_hook" "$@"
    fi
  '';

  includesFor = name: identity:
    map (dir: {
      condition = "gitdir:${config.home.homeDirectory}/${dir}/";
      contents = {
        url."git@github.com-${name}:".insteadOf = "git@github.com:";
        core.hooksPath = "${config.home.homeDirectory}/${identityGuardHooksDir}";
      };
    })
    identity.directories;
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

    # Route github.com over the SSH alias for the right account
    programs.git.includes = lib.flatten (lib.mapAttrsToList includesFor scopedIdentities);

    home.file = lib.mkIf (scopedIdentities != {}) {
      "${identityGuardHooksDir}/pre-commit" = {
        text = identityGuardHook;
        executable = true;
      };
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

    programs.gh.settings = {
      git_protocol = "ssh";
      pager = "cat";
    };
  }
