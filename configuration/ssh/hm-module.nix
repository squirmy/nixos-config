{
  lib,
  config,
  pkgs,
  ...
}: let
  githubLib = import ../github/lib.nix;
  identities = config.squirmy.github.identities;
  keyFileName = name: ".ssh/id_ed25519_sk_${name}.pub";
  hostName = name: identity:
    if githubLib.isDefaultIdentity identity
    then "github.com"
    else "github.com-${name}";
in
  lib.mkIf config.squirmy.ssh.enable {
    programs.ssh.enable = true;
    programs.ssh.enableDefaultConfig = false;
    programs.ssh.package = pkgs.openssh;

    # Authentication to github.com uses FIDO2 resident SSH keys stored on the
    # YubiKey, loaded into ssh-agent with `ssh-add -K` (private key stubs never
    # touch disk).
    home.file = lib.mapAttrs' (name: identity:
      lib.nameValuePair (keyFileName name) {text = identity.pubkey;})
    identities;

    programs.ssh.settings = lib.mapAttrs' (name: identity:
      lib.nameValuePair (hostName name identity) {
        HostName = "github.com";
        User = "git";
        IdentitiesOnly = true;
        IdentityFile = "${config.home.homeDirectory}/${keyFileName name}";
      })
    identities;

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
