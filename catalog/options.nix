{lib, ...}: let
  catalogOptions = {
    fonts.enable = lib.options.mkEnableOption "fonts";
    git.enable = lib.options.mkEnableOption "git";
    rider.enable = lib.options.mkEnableOption "rider";
    secrets.enable = lib.options.mkEnableOption "secrets";
    shell.enable = lib.options.mkEnableOption "shell";
    ssh.enable = lib.options.mkEnableOption "ssh";
    terminal.enable = lib.options.mkEnableOption "terminal";
    trampoline.enable = lib.options.mkEnableOption "trampoline";
    vscode.enable = lib.options.mkEnableOption "vscode";
    zoom.enable = lib.options.mkEnableOption "zoom";
    homebrew.enable = lib.options.mkEnableOption "homebrew";
    macos.enable = lib.options.mkEnableOption "macos";
    network.enable = lib.options.mkEnableOption "network";
    nix.enable = lib.options.mkEnableOption "nix";
  };
in {
  options.squirmy = lib.mkOption {
    type = lib.types.submodule {options = catalogOptions;};
    default = {};
  };
}
