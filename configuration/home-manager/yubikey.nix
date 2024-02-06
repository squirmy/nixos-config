{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.yubikey.enable {
  home.packages = with pkgs; [
    # yubikey-agent
    # A seamless ssh-agent for YubiKeys.
    # https://github.com/FiloSottile/yubikey-agent
    yubikey-agent

    # YubiKey Manager
    # Cross-platform application for configuring any YubiKey over all USB interfaces
    # https://www.yubico.com/support/download/yubikey-manager/
    yubikey-manager
  ];

  # Configure the yubikey-agent service
  launchd.agents.yubikey-agent = {
    enable = true;
    config.KeepAlive = true;
    config.Label = "yubikey-agent";
    config.ProgramArguments = [
      "${pkgs.yubikey-agent}/bin/yubikey-agent"
      "-l"
      "/tmp/yubikey-agent.sock"
    ];
  };

  programs.zsh = {
    envExtra = ''
      # Use a yubikey for ssh auth
      export SSH_AUTH_SOCK="/tmp/yubikey-agent.sock"
    '';
  };
}
