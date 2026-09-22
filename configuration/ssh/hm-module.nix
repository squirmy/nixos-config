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

  # Authentication to github.com uses FIDO2 resident SSH keys stored on the
  # YubiKey, loaded into ssh-agent with `ssh-add -K` (private key stubs never
  # touch disk).
  home.file.".ssh/id_ed25519_sk_squirmy.pub".text = ''
    sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHCLOWFkP2PPSxQ3KjCHe2BJTEVfPJ+aQJ6YRMbQeGafAAAABHNzaDo= ssh:
  '';
  home.file.".ssh/id_ed25519_sk_awoods-tw.pub".text = ''
    sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIOs6RqFezEKvbzyynXLfMTXnXN3rciD6UHR66UfQ0cIWAAAABnNzaDp0dw== ssh:tw
  '';
  home.file.".ssh/id_ed25519_sk_awoods-js.pub".text = ''
    sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIAX72O3FL+7vlInKzfRr4tup8sH0Rgo02b73npbmWCQOAAAABnNzaDpqcw== ssh:js
  '';

  programs.ssh.settings."github.com-squirmy" = {
    HostName = "github.com";
    User = "git";
    IdentitiesOnly = true;
    IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_sk_squirmy.pub";
  };
  programs.ssh.settings."github.com-awoods-tw" = {
    HostName = "github.com";
    User = "git";
    IdentitiesOnly = true;
    IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_sk_awoods-tw.pub";
  };
  programs.ssh.settings."github.com-awoods-js" = {
    HostName = "github.com";
    User = "git";
    IdentitiesOnly = true;
    IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_sk_awoods-js.pub";
  };

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
