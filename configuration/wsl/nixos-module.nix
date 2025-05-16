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
    pkgs.asdbctl
  ];

  # Setup docker in rootless mode
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  time.timeZone = "Australia/Melbourne";

  nixpkgs.config.allowUnfree = true;

  nix.settings.trusted-substituters = [
    "https://nixpkgs-terraform.cachix.org"
  ];

  nix.settings.trusted-public-keys = [
    "nixpkgs-terraform.cachix.org-1:8Sit092rIdAVENA3ZVeH9hzSiqI/jng6JiCrQ1Dmusw="
  ];
}
