{lib, ...}: let
  catalogOptions = {
    fonts.enable = lib.options.mkEnableOption "fonts";
    git.enable = lib.options.mkEnableOption "git";
    git.userName = lib.mkOption {
      type = lib.types.str;
    };
    git.userEmail = lib.mkOption {
      type = lib.types.str;
    };
    rider.enable = lib.options.mkEnableOption "rider";
    yubikey.enable = lib.options.mkEnableOption "yubikey";
    shell.enable = lib.options.mkEnableOption "shell";
    ssh.enable = lib.options.mkEnableOption "ssh";
    terminal.enable = lib.options.mkEnableOption "terminal";
    vscode.enable = lib.options.mkEnableOption "vscode";
    zoom.enable = lib.options.mkEnableOption "zoom";
    homebrew.enable = lib.options.mkEnableOption "homebrew";
    onepassword.enable = lib.options.mkEnableOption "1password";
    slack.enable = lib.options.mkEnableOption "slack";
    macos.enable = lib.options.mkEnableOption "macos";
    network.enable = lib.options.mkEnableOption "network";
  };
in {
  options.squirmy = lib.mkOption {
    type = lib.types.submodule {options = catalogOptions;};
    default = {};
  };
}
