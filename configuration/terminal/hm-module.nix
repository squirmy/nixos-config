{
  lib,
  config,
  pkgs,
  ...
}: let
  configDir = "${config.nix-machine.homeDirectory}/.config/nixos-config/configuration/terminal";
  wezterm = pkgs.wezterm;
in
  lib.mkIf config.squirmy.terminal.enable {
    # Don't use home manager's "programs" for some packages so that we can
    # specify the configuration explicitly.
    home.packages = [
      pkgs.gitmux
      pkgs.gum
      pkgs.nodejs_24
      pkgs.pure-prompt
      pkgs.sesh
      pkgs.tmux
      pkgs.tree-sitter
      wezterm
      pkgs.yq-go
      pkgs.go

      # nil
      # NIx Language server, an incremental analysis assistent for writing in Nix.
      # https://github.com/oxalica/nil
      pkgs.nil

      # Alejandra
      # The Uncompromising Nix Code Formatter
      # https://github.com/kamadorueda/alejandra
      pkgs.alejandra

      # shellcheck
      # ShellCheck, a static analysis tool for shell scripts
      # https://github.com/koalaman/shellcheck
      pkgs.shellcheck

      pkgs.dprint
    ];

    programs.zsh.initContent = lib.mkIf config.nix-machine.shells.zsh.enable ''
      # emacs key bindings
      bindkey -e

      # wezterm
      source "${wezterm}/etc/profile.d/wezterm.sh"

      # pure-prompt
      fpath+=(${pkgs.pure-prompt})
      prompt off
      autoload -U promptinit; promptinit
      PURE_GIT_PULL=0
      prompt pure
    '';

    # direnv
    # unclutter your .profile
    # https://direnv.net
    # Why: Initialize the environment when changing into a directory.
    programs.direnv = {
      enable = true;
      enableZshIntegration = config.nix-machine.shells.zsh.enable;
    };

    # fzf
    # 🌸 A command-line fuzzy finder
    # https://github.com/junegunn/fzf
    # Why: Handy for searching through history for past commands
    programs.fzf = {
      enable = true;
      enableZshIntegration = config.nix-machine.shells.zsh.enable;
    };

    # nvim
    # Vim-fork focused on extensibility and usability
    # https://github.com/neovim/neovim
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    # zoxide
    # A smarter cd command. Supports all major shells.
    # https://github.com/ajeetdsouza/zoxide
    # Why: Easily switch between the most frequently used directories.
    programs.zoxide = {
      enable = true;
      enableZshIntegration = config.nix-machine.shells.zsh.enable;
      options = ["--cmd" "cd"];
    };

    # Configuration files for development tools
    home.file.".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/tmux";
    home.file.".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/wezterm";
    home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/nvim";
    home.file.".config/hammerspoon".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hammerspoon";

    # Colorize ls on macos
    home.sessionVariables = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {CLICOLOR = "1";};
  }
