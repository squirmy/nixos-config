{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.ssh.enable {
  # Enable ssh. Not sure how much to setup with this just yet.
  programs.ssh.enable = true;
  programs.ssh.package = pkgs.openssh;
  programs.ssh.addKeysToAgent = "yes";
  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = "/users/${config.nix-machine.username}/.ssh/id_ed25519_sk_rk_no-pin-required";
    };
  };

  home.packages = [
    pkgs.openssh
    pkgs.openssl
  ];
}
