{pkgs, ...}: {
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

  programs.vscode.enable = true;
  programs.vscode.enableUpdateCheck = false;
  programs.vscode.enableExtensionUpdateCheck = false;

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
    dbaeumer.vscode-eslint
    rust-lang.rust-analyzer
    tamasfe.even-better-toml
    serayuzgur.crates
    esbenp.prettier-vscode
    timonwong.shellcheck
  ];

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

    # Default Behaviors
    "workbench.startupEditor" = "newUntitledFile";
    "terminal.integrated.defaultProfile.osx" = "zsh";

    # js/ts
    "javascript.updateImportsOnFileMove.enabled" = "always";
    "typescript.updateImportsOnFileMove.enabled" = "always";

    # eslint configuration
    "editor.formatOnSave" = false;
    "editor.codeActionsOnSave" = {
      "source.fixAll" = false;
      "source.fixAll.eslint" = true;
      "source.organizeImports" = false;
    };
    "eslint.validate" = [
      "javascript"
      "javascriptreact"
      "typescript"
      "typescriptreact"
      "vue"
      "html"
      "markdown"
      "json"
      "jsonc"
      "json5"
      "yaml"
    ];
    "eslint.codeActionsOnSave.rules" = [
      "!unused-imports/no-unused-imports"
      "*"
    ];

    # rust linting and formatting
    "rust-analyzer.check.command" = "clippy";
    "[rust]" = {
      "editor.defaultFormatter" = "rust-lang.rust-analyzer";
      "editor.formatOnSave" = true;
    };

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

    # markdown
    "[markdown]" = {
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };

    # markdown
    "[toml]" = {
      "editor.defaultFormatter" = "tamasfe.even-better-toml";
      "editor.formatOnSave" = true;
    };

    "shellcheck.executablePath" = "${pkgs.shellcheck.bin}/bin/shellcheck";

    # exclude these directories from cmd + shift + f
    "search.exclude" = {
      "**/.git" = true;
      "**/.pnpm" = true;
      "**/node_modules" = true;
      "**/pnpm-lock.yaml" = true;
    };
  };
}
