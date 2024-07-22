{
  lib,
  config,
  ...
}: {
  options.squirmy.ssh.enable = lib.options.mkEnableOption "ssh";
  options.squirmy.ssh.authSock = lib.mkOption {
    type = lib.types.str;
    default = "/users/${config.nix-machine.username}/.ssh/agent";
  };
}
