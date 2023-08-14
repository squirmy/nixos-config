{ pkgs, ... }:

{
  # A basic password store implementation using a yubikey
  # to decrypt the secrets + yubikey agent for ssh auth.
  # https://words.filippo.io/dispatches/passage/
  home.packages = with pkgs; [
    # age
    # A simple, modern and secure encryption tool with small explicit keys,
    # no config options, and UNIX-style composability.
    # https://github.com/FiloSottile/age
    age

    # age-plugin-yubikey 
    # Enables files to be encrypted to age identities stored on YubiKeys.
    # https://github.com/str4d/age-plugin-yubikey
    age-plugin-yubikey 

    # passage
    # A fork of password-store that uses age as backend.
    # https://github.com/FiloSottile/passage
    passage

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
      # Store and retreive encrypted secrets using iCloud
      passage="$HOME/Library/Mobile Documents/com~apple~CloudDocs/.passage"
      export PASSAGE_DIR="$passage/store"
      export PASSAGE_IDENTITIES_FILE="$passage/identities"
      export PASSAGE_EXTENSIONS_DIR="$passage/extensions"

      # Use a yubikey for ssh auth
      export SSH_AUTH_SOCK="/tmp/yubikey-agent.sock"
    '';
  };
}
