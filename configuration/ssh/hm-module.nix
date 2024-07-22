{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.ssh.enable {
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

  # Set SSH_AUTH_SOCK to the same value the ssh-agent is configured with
  home.sessionVariables = {
    SSH_AUTH_SOCK = config.squirmy.ssh.authSock;
  };
}
