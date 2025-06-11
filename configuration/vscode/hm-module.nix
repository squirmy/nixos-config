{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  baseConfig = {
    enable = true;
    profiles.default.enableUpdateCheck = false;
    profiles.default.enableExtensionUpdateCheck = true;
    mutableExtensionsDir = true;

    profiles.default.userSettings = {
      # Visual Tweaks
      "editor.accessibilitySupport" = "off";
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.find.addExtraSpaceOnTop" = false;
      "window.nativeTabs" = true;
      "workbench.list.smoothScrolling" = true;
      "workbench.tree.indent" = 10;

      # Default Theme
      "workbench.colorTheme" = "Default Dark Modern";

      # Font
      "editor.fontSize" = 15;
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

      # 🧘 do not disturb
      "editor.codeLens" = false;
      "editor.copyWithSyntaxHighlighting" = false;
      "editor.dragAndDrop" = false;
      "editor.minimap.enabled" = false;
      "git.openRepositoryInParentFolders" = "never";
      "update.showReleaseNotes" = false;
      "workbench.enableExperiments" = false;
      "workbench.tips.enabled" = false;

      # minimal
      "zenMode.centerLayout" = false;
      "zenMode.fullScreen" = false;
      "zenMode.hideLineNumbers" = false;
      "zenMode.hideStatusBar" = false;
      "zenMode.silentNotifications" = false;
      "zenMode.showTabs" = "none";

      "editor.renderLineHighlight" = "none";
      "editor.foldingHighlight" = false;
      "editor.inlayHints.enabled" = "off";
      "editor.guides.indentation" = false;
      "editor.bracketPairColorization.enabled" = false;

      "window.commandCenter" = false;
      "workbench.activityBar.location" = "hidden";
      "workbench.layoutControl.enabled" = false;

      "editor.stickyScroll.enabled" = false;

      # zig config
      "zig.path" = "zig";
      "zig.zls.path" = "zls";
    };
  };
in {
  imports = [inputs.vscodes.modules.default];

  config = lib.mkIf config.squirmy.vscode.enable {
    # Remove color from pre-commit. It's hard to read.
    home.sessionVariables = {PRE_COMMIT_COLOR = "never";};

    programs.vscodes.code = lib.mkMerge [
      baseConfig
      {package = pkgs.vscode;}
    ];

    programs.vscodes.cursor = lib.mkMerge [
      baseConfig
      {package = pkgs.code-cursor;}
    ];
  };
}
