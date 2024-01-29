{
  flake,
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.nix.enable {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    nixPath = ["nixpkgs=${flake.inputs.nixpkgs}"];
    registry.nixpkgs.flake = flake.inputs.nixpkgs;
    settings = {
      # https://github.com/NixOS/nix/issues/7273
      auto-optimise-store = false;
      experimental-features = "nix-command flakes repl-flake";
      extra-platforms = lib.mkIf (pkgs.system == "aarch64-darwin") ["aarch64-darwin x86_64-darwin"];
      max-jobs = "auto";
      trusted-users = ["@admin"];

      # List of binary cache URLs used to obtain pre-built binaries of Nix packages
      # https://nixos.wiki/wiki/Binary_Cache
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
        "https://squirmy.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "squirmy.cachix.org-1:ke0hGUzJx+rdwiZaNxQzAHTfTlGa8VyDpfwgywfwP28="
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    # Cachix
    # Never build software twice
    # https://www.cachix.org
    cachix
  ];

  # Enable nix-daemon to support multi-user mode nix.
  # This is the recommended nix installation option.
  services.nix-daemon.enable = true;

  # Every once in a while, a new NixOS release may change configuration
  # defaults in a way incompatible with stateful data. Update this
  # when you want to consume newer defaults.
  system.stateVersion = 4;
}
