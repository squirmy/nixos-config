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
    pkgs.libfido2
  ];
  services.pcscd.enable = true;
  services.udev = {
    enable = true;
    packages = [pkgs.yubikey-personalization];
    extraRules = ''
      SUBSYSTEM=="usb", MODE="0666"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", TAG+="uaccess", MODE="0666"
    '';
  };
}
