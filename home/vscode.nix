{
  pkgs,
  flake,
  ...
}: let
  marketplace = flake.inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
in {
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

  programs.zsh = {
    envExtra = ''
      # Remove color from pre-commit. It's hard to read.
      export PRE_COMMIT_COLOR=never
    '';
  };

  programs.vscode.enable = true;
  programs.vscode.enableUpdateCheck = false;
  programs.vscode.enableExtensionUpdateCheck = false;
  programs.vscode.mutableExtensionsDir = false;

  # The extention id's can sometimes contain uppercase characters.
  # You'll need to make all letters lowercase for them to work.
  programs.vscode.extensions = with marketplace; [
    jnoortheen.nix-ide
    dbaeumer.vscode-eslint
    rust-lang.rust-analyzer
    tamasfe.even-better-toml
    serayuzgur.crates
    esbenp.prettier-vscode
    timonwong.shellcheck
    svelte.svelte-vscode
    bradlc.vscode-tailwindcss
    github.vscode-github-actions
    eamodio.gitlens
    mkhl.direnv
    ms-dotnettools.csharp
    ms-dotnettools.vscode-dotnet-runtime
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
    "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
    "terminal.integrated.fontSize" = "13";
    "terminal.integrated.fontWeight" = "450";
    "terminal.integrated.fontWeightBold" = "600";

    # Default Behaviors
    "workbench.startupEditor" = "newUntitledFile";
    "terminal.integrated.defaultProfile.osx" = "zsh";

    # js/ts
    "javascript.updateImportsOnFileMove.enabled" = "never";
    "typescript.updateImportsOnFileMove.enabled" = "never";

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

    # toml
    "[toml]" = {
      "editor.defaultFormatter" = "tamasfe.even-better-toml";
      "editor.formatOnSave" = true;
    };

    "shellcheck.executablePath" = "${pkgs.shellcheck.bin}/bin/shellcheck";

    "svelte.ask-to-enable-ts-plugin" = false;

    # annoyances
    "git.openRepositoryInParentFolders" = "never";
  };
}
