{lib, ...}: let
  configurationOptions = {
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
    direnv.enable = lib.options.mkEnableOption "direnv";
    ssh.enable = lib.options.mkEnableOption "ssh";
    starship.enable = lib.options.mkEnableOption "starship";
    kitty.enable = lib.options.mkEnableOption "kitty";
    fzf.enable = lib.options.mkEnableOption "fzf";
    vscode.enable = lib.options.mkEnableOption "vscode";
    zoom.enable = lib.options.mkEnableOption "zoom";
    homebrew.enable = lib.options.mkEnableOption "homebrew";
    onepassword.enable = lib.options.mkEnableOption "1password";
    slack.enable = lib.options.mkEnableOption "slack";
    macos.enable = lib.options.mkEnableOption "macos";
    network.enable = lib.options.mkEnableOption "network";
    vim.enable = lib.options.mkEnableOption "vim";
    shell.enable = lib.options.mkEnableOption "shell";
    experiments.enable = lib.options.mkEnableOption "experiments";
  };
in {
  options.squirmy = lib.mkOption {
    type = lib.types.submodule {options = configurationOptions;};
    default = {};
  };
}
