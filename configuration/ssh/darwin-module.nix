{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.ssh.enable (
  let
    sshAuthSock = "/users/${config.nix-machine.username}/.ssh/agent";
  in {
    launchd.user.agents.ssh_agent = {
      serviceConfig = {
        Label = "ssh-agent";
        ProgramArguments = ["${pkgs.openssh}/bin/ssh-agent" "-D" "-a" "${sshAuthSock}"];
        KeepAlive = true;
        RunAtLoad = true;
        ProcessType = "Background";
        StandardOutPath = "/tmp/ssh-agent.out.log";
        StandardErrorPath = "/tmp/ssh-agent.err.log";
      };
    };

    programs.zsh.variables.SSH_AUTH_SOCK = sshAuthSock;

    system.activationScripts.extraActivation.text = ''
      launchctl disable user/$UID/com.openssh.ssh-agent
    '';
  }
)
