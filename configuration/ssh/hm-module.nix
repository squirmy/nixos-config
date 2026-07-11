{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.ssh.enable {
  programs.ssh.enable = true;
  programs.ssh.enableDefaultConfig = false;
  programs.ssh.package = pkgs.openssh;
  # Authentication to github.com uses the FIDO2 resident SSH key stored on the
  # YubiKey, loaded into ssh-agent with `ssh-add -K` (no key file on disk).

  home.packages = [
    pkgs.openssh
    pkgs.openssl
  ];

  # Set SSH_AUTH_SOCK to the same value the ssh-agent is configured with
  home.sessionVariables = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    SSH_AUTH_SOCK = config.squirmy.ssh.authSock;
  };

  services.ssh-agent.enable = !pkgs.stdenv.hostPlatform.isDarwin;
}
