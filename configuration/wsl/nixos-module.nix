{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.wsl.enable {
  wsl.enable = true;
  wsl.usbip.enable = true;
  wsl.wslConf.interop.appendWindowsPath = false;

  environment.systemPackages = [
    pkgs.gnumake
    pkgs.gcc
  ];

  # Setup docker in rootless mode
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
