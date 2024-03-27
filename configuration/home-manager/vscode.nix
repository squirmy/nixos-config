{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.vscode.enable {
  home.packages = with pkgs; [
    # nil
    # NIx Language server, an incremental analysis assistent for writing in Nix.
    # https://github.com/oxalica/nil
    nil

    # Alejandra
    # The Uncompromising Nix Code Formatter
    # https://github.com/kamadorueda/alejandra
    alejandra

    # shfmt
    # A shell parser, formatter, and interpreter with bash support; includes shfmt
    # https://github.com/mvdan/sh
    shfmt

    # Prettier
    # Opinionated Code Formatter
    # https://github.com/prettier/prettier
    nodePackages.prettier

    # taplo
    # A TOML toolkit written in Rust
    # https://github.com/tamasfe/taplo
    taplo

    # treefmt
    # one CLI to format your repo
    # https://github.com/numtide/treefmt
    treefmt

    # shellcheck
    # ShellCheck, a static analysis tool for shell scripts
    # https://github.com/koalaman/shellcheck
    shellcheck

    # pre-commit
    # A framework for managing and maintaining multi-language pre-commit hooks
    # https://pre-commit.com
    pre-commit
  ];

  # Remove color from pre-commit. It's hard to read.
  home.sessionVariables = {PRE_COMMIT_COLOR = "never";};

  programs.vscode.enable = true;
  programs.vscode.enableUpdateCheck = false;
  programs.vscode.enableExtensionUpdateCheck = true;
  programs.vscode.mutableExtensionsDir = true;

  programs.vscode.userSettings = {
    # Visual Tweaks
    "editor.accessibilitySupport" = "off";
    "editor.cursorSmoothCaretAnimation" = "on";
    "editor.find.addExtraSpaceOnTop" = false;
    "window.nativeTabs" = true;
    "workbench.list.smoothScrolling" = true;
    "workbench.tree.indent" = 10;

    # Font
    "editor.fontFamily" = "Fira Code";
    "editor.fontLigatures" = true;
    "editor.fontWeight" = "450"; # Retina
    "workbench.fontAliasing" = "antialiased";
    "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
    "terminal.integrated.fontSize" = 13;
    "terminal.integrated.fontWeight" = "450";
    "terminal.integrated.fontWeightBold" = "600";

    # Default Behaviors
    "workbench.startupEditor" = "newUntitledFile";
    "terminal.integrated.defaultProfile.osx" = "zsh";

    # js/ts
    "javascript.updateImportsOnFileMove.enabled" = "never";
    "typescript.updateImportsOnFileMove.enabled" = "never";

    # shellcheck
    "shellcheck.executablePath" = "${pkgs.shellcheck.bin}/bin/shellcheck";

    # nix
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nil";
    "nix.serverSettings" = {
      "nil" = {
        "formatting" = {
          "command" = ["alejandra"];
        };
      };
    };
    "[nix]" = {
      "editor.formatOnSave" = true;
    };

    # default formatters
    "[json][jsonc]" = {
      "editor.defaultFormatter" = "vscode.json-language-features";
      "editor.formatOnSave" = true;
    };

    "[markdown]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.formatOnSave" = true;
    };

    "[toml]" = {
      "editor.defaultFormatter" = "tamasfe.even-better-toml";
      "editor.formatOnSave" = true;
    };

    # 🧘 do not disturb
    "editor.acceptSuggestionOnCommitCharacter" = false;
    "editor.codeLens" = false;
    "editor.copyWithSyntaxHighlighting" = false;
    "editor.dragAndDrop" = false;
    "editor.hover.delay" = 1200;
    "editor.lightbulb.enabled" = "off";
    "editor.minimap.enabled" = false;
    "editor.parameterHints.enabled" = false;
    "editor.quickSuggestions" = {
      "other" = false;
      "comments" = false;
      "strings" = false;
    };
    "editor.suggestOnTriggerCharacters" = false;
    "explorer.openEditors.visible" = 0;
    "extensions.ignoreRecommendations" = true;
    "git.openRepositoryInParentFolders" = "never";
    "keyboard.touchbar.enabled" = false;
    "update.showReleaseNotes" = false;
    "workbench.enableExperiments" = false;
    "workbench.tips.enabled" = false;
  };
}
