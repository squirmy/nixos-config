{lib, ...}: {
  options.squirmy.ssh.enable = lib.options.mkEnableOption "ssh";
}
