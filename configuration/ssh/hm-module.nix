{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.ssh.enable {
  programs.ssh.enable = true;
  programs.ssh.package = pkgs.openssh;
  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = [
        "${config.nix-machine.homeDirectory}/.ssh/squirmy:SHA256:z0_8MioTATFoqKQPUSlyuhjKAVTAs5sbyI42ERuApVc"
      ];
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
