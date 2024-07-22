{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.ssh.enable {
  # Start the ssh-agent at startup
  launchd.user.agents.ssh_agent = {
    serviceConfig = {
      Label = "ssh-agent";
      ProgramArguments = ["${pkgs.openssh}/bin/ssh-agent" "-D" "-a" "${config.squirmy.ssh.authSock}"];
      KeepAlive = true;
      RunAtLoad = true;
      ProcessType = "Background";
      StandardOutPath = "/tmp/ssh-agent.out.log";
      StandardErrorPath = "/tmp/ssh-agent.err.log";
    };
  };

  # Disable the ssh-agent that's packaged with macos
  system.activationScripts.extraActivation.text = ''
    launchctl disable user/$UID/com.openssh.ssh-agent
  '';
}
